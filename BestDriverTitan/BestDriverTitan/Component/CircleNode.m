//
//  CircleNode.m
//  BestDriverTitan
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CircleNode.h"

@interface CircleNode(){
    UIColor* _fillColor;
    //    CGFloat _cornerRadius;
}

@end

@implementation CircleNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
    }
    return self;
}

-(void)setStrokeColor:(UIColor *)strokeColor{
    _strokeColor = strokeColor;
    [self setNeedsDisplay];
}

-(void)setStrokeWidth:(CGFloat)strokeWidth{
    _strokeWidth = strokeWidth;
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
    NSDictionary * dictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                 self.fillColor,@"fillColor",
                                 self.strokeColor,@"strokeColor",
                                 [NSNumber numberWithFloat:self.strokeWidth],@"strokeWidth",
                                 nil];
    return dictionary;
}

+(void)drawRect:(CGRect)bounds withParameters:(id<NSObject>)parameters isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock isRasterizing:(BOOL)isRasterizing{
    
    NSDictionary * dictionary = (NSDictionary *)parameters;
    UIColor* color = [dictionary objectForKey:@"fillColor"];
    NSNumber *strokeValue = [dictionary objectForKey:@"strokeWidth"];
    
    CGFloat width = bounds.size.width;
    CGFloat height = bounds.size.height;
    CGFloat radius = MIN(width / 2., height / 2.);
    
    // 获取CGContext，注意UIKit里用的是一个专门的函数
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextAddArc(context, width / 2., height / 2., radius, 0, M_PI * 2, 0);
    [color setFill];
    CGContextDrawPath(context, kCGPathFill);
    
    if (strokeValue.floatValue) {
        CGFloat strokeWidth = strokeValue.floatValue;
        UIColor* strokeColor = [dictionary objectForKey:@"strokeColor"];
        //    CGContextSetAllowsAntialiasing(context,NO);//关闭抗锯齿
        CGContextSetLineWidth(context,strokeWidth);
        CGContextSetStrokeColorWithColor(context,strokeColor.CGColor);//
        
        CGContextAddArc(context, width / 2., height / 2., radius - strokeWidth / 2., 0, M_PI * 2, 0);
        // 闭合路径
        //    CGContextClosePath(context);
        //    [color setStroke];
        CGContextStrokePath(context);
    }
}

@end
