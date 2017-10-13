//
//  RoundRectNode.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/2/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "RoundRectNode.h"

@interface RoundRectNode(){
    UIColor* _fillColor;
//    CGFloat _cornerRadius;
}

@end


@implementation RoundRectNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
    }
    return self;
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    [self setNeedsDisplay];
}

-(void)setTopLeftRadius:(CGFloat)topLeftRadius{
    _topLeftRadius = topLeftRadius;
    [self setNeedsDisplay];
}
-(void)setTopRightRadius:(CGFloat)topRightRadius{
    _topRightRadius = topRightRadius;
    [self setNeedsDisplay];
}
-(void)setBottomRightRadius:(CGFloat)bottomRightRadius{
    _bottomRightRadius = bottomRightRadius;
    [self setNeedsDisplay];
}
-(void)setBottomLeftRadius:(CGFloat)bottomLeftRadius{
    _bottomLeftRadius = bottomLeftRadius;
    [self setNeedsDisplay];
}

-(void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    [self setNeedsDisplay];
}

-(UIColor *)fillColor{
    if (!_fillColor) {
        _fillColor = [UIColor blackColor];
    }
    return _fillColor;
}

-(void)setStrokeColor:(UIColor *)strokeColor{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

-(void)setStrokeWidth:(CGFloat)strokeWidth{
    _strokeWidth = strokeWidth;
    [self setNeedsDisplay];
}

-(id<NSObject>)drawParametersForAsyncLayer:(_ASDisplayLayer *)layer{
    self.backgroundColor = [UIColor clearColor];
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.fillColor,@"fillColor",
                                 @(self.cornerRadius),@"cornerRadius",
                                 @(self.topLeftRadius),@"topLeftRadius",
                                 @(self.topRightRadius),@"topRightRadius",
                                 @(self.bottomRightRadius),@"bottomRightRadius",
                                 @(self.bottomLeftRadius),@"bottomLeftRadius",
                                 self.strokeColor,@"strokeColor",
                                 [NSNumber numberWithFloat:self.strokeWidth],@"strokeWidth",
                                 nil];
//    NSDictionary * dictionary = @{@"fillColor":self.fillColor,
//             @"cornerRadius":@(self.cornerRadius),
//             @"topLeftRadius":@(self.topLeftRadius),
//             @"topRightRadius":@(self.topRightRadius),
//             @"bottomRightRadius":@(self.bottomRightRadius),
//             @"bottomLeftRadius":@(self.bottomLeftRadius),
//             @"strokeColor":self.strokeColor,
//             @"strokeWidth":@(self.strokeWidth)
//             };
    return dictionary;
}

+(void)drawRect:(CGRect)bounds withParameters:(id<NSObject>)parameters isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock isRasterizing:(BOOL)isRasterizing{

    NSDictionary * dictionary = (NSDictionary *)parameters;
    UIColor* color = [dictionary objectForKey:@"fillColor"];
    
    NSNumber *radiusValue = [dictionary objectForKey:@"cornerRadius"];
    
    NSNumber *strokeValue = [dictionary objectForKey:@"strokeWidth"];
    
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    // 简便起见，这里把圆角半径设置为长和宽平均值的1/10
    CGFloat radius = 0;//(width + height) * 0.05;
    if (radiusValue.floatValue) {
        radius = radiusValue.floatValue;
    }
    
    CGFloat topLeft = 0.0,topRight = 0.0,bottomRight = 0.0,bottomLeft = 0.0;
    if (radius) {
        topLeft = topRight = bottomRight = bottomLeft = radius;
    }else{
        NSNumber *topLeftRadius = [dictionary objectForKey:@"topLeftRadius"];
        NSNumber *topRightRadius = [dictionary objectForKey:@"topRightRadius"];
        NSNumber *bottomRightRadius = [dictionary objectForKey:@"bottomRightRadius"];
        NSNumber *bottomLeftRadius = [dictionary objectForKey:@"bottomLeftRadius"];
        if (topLeftRadius.floatValue) {
            topLeft = topLeftRadius.floatValue;
        }
        if (topRightRadius.floatValue) {
            topRight = topRightRadius.floatValue;
        }
        if (bottomRightRadius.floatValue) {
            bottomRight = bottomRightRadius.floatValue;
        }
        if (bottomLeftRadius.floatValue) {
            bottomLeft = bottomLeftRadius.floatValue;
        }
    }
    
    if (strokeValue.floatValue) {
        CGFloat strokeWidth = strokeValue.floatValue;
        UIColor* strokeColor = [dictionary objectForKey:@"strokeColor"];
        [RoundRectNode drawFillPath:strokeColor width:width height:height topLeft:topLeft topRight:topRight bottomRight:bottomRight bottomLeft:bottomLeft];
        [RoundRectNode drawStrokePath:color width:width height:height topLeft:topLeft topRight:topRight bottomRight:bottomRight bottomLeft:bottomLeft strokeWidth:strokeWidth];
    }else{
        [RoundRectNode drawFillPath:color width:width height:height topLeft:topLeft topRight:topRight bottomRight:bottomRight bottomLeft:bottomLeft];
    }
    
    
}

+(void)drawFillPath:(UIColor*)color  width:(CGFloat)width height:(CGFloat)height topLeft:(CGFloat)topLeft
    topRight:(CGFloat)topRight bottomRight:(CGFloat)bottomRight bottomLeft:(CGFloat)bottomLeft{
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (topLeft) {
        // 绘制第4条线和第4个1/4圆弧
        CGContextAddArc(context, topLeft, topLeft, topLeft, M_PI, 1.5 * M_PI, 0);//TOPLEFT
    }else{
        CGContextMoveToPoint(context, 0, 0);
    }
    if (topRight) {
        CGContextAddArc(context, width - topRight, topRight, topRight, -0.5 * M_PI, 0.0, 0);//TOPRIGHT
    }else{
        CGContextAddLineToPoint(context, width, 0);
    }
    if (bottomRight) {
        // 绘制第2条线和第2个1/4圆弧
        CGContextAddArc(context, width - bottomRight, height - bottomRight, bottomRight, 0.0, 0.5 * M_PI, 0);//BOTTOMRIGHT
    }else{
        CGContextAddLineToPoint(context, width, height);
    }
    if (bottomLeft) {
        // 绘制第3条线和第3个1/4圆弧
        CGContextAddArc(context, bottomLeft, height - bottomLeft, bottomLeft, 0.5 * M_PI, M_PI, 0);//BOTTOMLEFT
    }else{
        CGContextAddLineToPoint(context, 0, height);
    }
//    CGContextClosePath(context);// 闭合路径
    [color setFill];//边框色
    //    [[UIColor blackColor] setStroke];
    CGContextDrawPath(context, kCGPathFill);
}

+(void)drawStrokePath:(UIColor*)color width:(CGFloat)width height:(CGFloat)height topLeft:(CGFloat)topLeft
             topRight:(CGFloat)topRight bottomRight:(CGFloat)bottomRight bottomLeft:(CGFloat)bottomLeft strokeWidth:(CGFloat)strokeWidth
{
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    if (topLeft && topLeft > strokeWidth) {
        // 绘制第4条线和第4个1/4圆弧
        CGContextAddArc(context, topLeft, topLeft, topLeft - strokeWidth, M_PI, 1.5 * M_PI, 0);
    }else{
        CGContextMoveToPoint(context, strokeWidth, strokeWidth);
    }
    if (topRight && topRight > strokeWidth) {
        // 绘制第2条线和第2个1/4圆弧
        CGContextAddArc(context, width - topRight, topRight, topRight - strokeWidth, -0.5 * M_PI, 0.0, 0);
    }else{
        CGContextAddLineToPoint(context, width - strokeWidth, strokeWidth);
    }
    if (bottomRight && bottomRight > strokeWidth) {
        CGContextAddArc(context, width - bottomRight, height - bottomRight, bottomRight - strokeWidth, 0.0, 0.5 * M_PI, 0);
    }else{
        CGContextAddLineToPoint(context, width - strokeWidth, height - strokeWidth);
    }
    if (bottomLeft && bottomLeft > strokeWidth) {
        // 绘制第3条线和第3个1/4圆弧
        CGContextAddArc(context, bottomLeft, height - bottomLeft, bottomLeft - strokeWidth, 0.5 * M_PI, M_PI, 0);
    }else{
        CGContextAddLineToPoint(context, strokeWidth, height - strokeWidth);
    }
//    CGContextClosePath(context);// 闭合路径
//    [color setFill];//边框色
    //    [[UIColor blackColor] setStroke];
    CGContextDrawPath(context, kCGPathFill);
}


@end
