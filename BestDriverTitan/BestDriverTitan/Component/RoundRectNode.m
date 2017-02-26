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
                                 [NSNumber numberWithFloat:self.cornerRadius],@"cornerRadius",
                                 self.strokeColor,@"strokeColor",
                                 [NSNumber numberWithFloat:self.strokeWidth],@"strokeWidth",
                                 nil];
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
    CGFloat radius = (width + height) * 0.05;
    if (radiusValue.floatValue) {
        radius = radiusValue.floatValue;
    }
    
    
    if (strokeValue.floatValue) {
        CGFloat strokeWidth = strokeValue.floatValue;
        UIColor* strokeColor = [dictionary objectForKey:@"strokeColor"];
        [RoundRectNode drawFillPath:strokeColor width:width height:height radius:radius];
        [RoundRectNode drawStrokePath:color width:width height:height radius:radius strokeWidth:strokeWidth];
    }else{
        [RoundRectNode drawFillPath:color width:width height:height radius:radius];
    }
    
    
}

+(void)drawFillPath:(UIColor*)color  width:(CGFloat)width height:(CGFloat)height radius:(CGFloat)radius{
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(context, width - radius, radius, radius, -0.5 * M_PI, 0.0, 0);
    // 绘制第2条线和第2个1/4圆弧
    CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
    // 绘制第3条线和第3个1/4圆弧
    CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
    // 绘制第4条线和第4个1/4圆弧
    CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
//    CGContextClosePath(context);// 闭合路径
    [color setFill];//边框色
    //    [[UIColor blackColor] setStroke];
    CGContextDrawPath(context, kCGPathFill);
}

+(void)drawStrokePath:(UIColor*)color width:(CGFloat)width height:(CGFloat)height radius:(CGFloat)radius strokeWidth:(CGFloat)strokeWidth{
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGContextAddArc(context, width - radius, radius, radius - strokeWidth, -0.5 * M_PI, 0.0, 0);
    // 绘制第2条线和第2个1/4圆弧
    CGContextAddArc(context, width - radius, height - radius, radius - strokeWidth, 0.0, 0.5 * M_PI, 0);
    // 绘制第3条线和第3个1/4圆弧
    CGContextAddArc(context, radius, height - radius, radius - strokeWidth, 0.5 * M_PI, M_PI, 0);
    // 绘制第4条线和第4个1/4圆弧
    CGContextAddArc(context, radius, radius, radius - strokeWidth, M_PI, 1.5 * M_PI, 0);
//    CGContextClosePath(context);// 闭合路径
//    [color setFill];//边框色
    //    [[UIColor blackColor] setStroke];
    CGContextDrawPath(context, kCGPathFill);
}


@end
