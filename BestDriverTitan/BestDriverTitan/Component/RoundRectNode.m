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

-(id<NSObject>)drawParametersForAsyncLayer:(_ASDisplayLayer *)layer{
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.fillColor,@"fillColor",[NSNumber numberWithFloat:self.cornerRadius],@"cornerRadius",nil];
    return dictionary;
}

+(void)drawRect:(CGRect)bounds withParameters:(id<NSObject>)parameters isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock isRasterizing:(BOOL)isRasterizing{

    NSDictionary * dictionary = (NSDictionary *)parameters;
    UIColor* color = [dictionary objectForKey:@"fillColor"];
    
    NSNumber *radiusValue = [dictionary objectForKey:@"cornerRadius"];
    
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    // 简便起见，这里把圆角半径设置为长和宽平均值的1/10
    CGFloat radius = (width + height) * 0.05;
    if (radiusValue.floatValue) {
        radius = radiusValue.floatValue;
    }
    
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 移动到初始点
    CGContextMoveToPoint(context, radius, 0);
    
    // 绘制第1条线和第1个1/4圆弧
    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArc(context, width - radius, radius, radius, -0.5 * M_PI, 0.0, 0);
    
    // 绘制第2条线和第2个1/4圆弧
    CGContextAddLineToPoint(context, width, height - radius);
    CGContextAddArc(context, width - radius, height - radius, radius, 0.0, 0.5 * M_PI, 0);
    
    // 绘制第3条线和第3个1/4圆弧
    CGContextAddLineToPoint(context, radius, height);
    CGContextAddArc(context, radius, height - radius, radius, 0.5 * M_PI, M_PI, 0);
    
    // 绘制第4条线和第4个1/4圆弧
    CGContextAddLineToPoint(context, 0, radius);
    CGContextAddArc(context, radius, radius, radius, M_PI, 1.5 * M_PI, 0);
    
    // 闭合路径
    CGContextClosePath(context);
    // 填充半透明黑色
//    CGContextSetRGBFillColor(context, 0.0, 0.0, 50.0, 1);
    
    [color setFill];
    
    CGContextDrawPath(context, kCGPathFill);
}

@end
