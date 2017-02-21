
//
//  UIArrowView.m
//  BestDriverTitan
//
//  Created by admin on 16/12/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIArrowView.h"

@interface UIArrowView(){
    ArrowDirect _arrowDirect;
    UIColor* _lineColor;
    UIColor* _fillColor;
    CGFloat _lineThinkness;
    CGFloat _arrowHeightRate;
}
@end

@implementation UIArrowView



-(void)layoutSubviews{
    self.backgroundColor = [UIColor clearColor];
    [super layoutSubviews];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath* linePath = [[UIBezierPath alloc]init];
    linePath.lineWidth = self.lineThinkness;
    linePath.lineCapStyle = kCGLineCapRound;
    
    CGFloat rectWidth = CGRectGetWidth(rect);
    CGFloat rectHeight = CGRectGetHeight(rect);
    if (self.direction == ArrowDirectLeft) {
        CGFloat xOffSet = rectWidth * (1 - self.arrowHeightRate);
        [linePath moveToPoint:CGPointMake(rectWidth - self.lineThinkness / 2. - xOffSet, self.lineThinkness / 2.)];
        [linePath addLineToPoint:CGPointMake(self.lineThinkness / 2., rectHeight / 2.)];
        [linePath addLineToPoint:CGPointMake(rectWidth - self.lineThinkness / 2. - xOffSet, rectHeight - self.lineThinkness / 2.)];
        if(self.isGuide){
            [linePath moveToPoint:CGPointMake(self.lineThinkness / 2., rectHeight / 2.)];
            [linePath addLineToPoint:CGPointMake(rectWidth - self.lineThinkness / 2., rectHeight / 2.)];
        }
    }else if(self.direction == ArrowDirectRight){
        CGFloat xOffSet = rectWidth * (1 - self.arrowHeightRate);
        [linePath moveToPoint:CGPointMake(self.lineThinkness / 2. + xOffSet, self.lineThinkness / 2.)];
        [linePath addLineToPoint:CGPointMake(rectWidth - self.lineThinkness / 2., rectHeight / 2.)];
        [linePath addLineToPoint:CGPointMake(self.lineThinkness / 2. + xOffSet, rectHeight - self.lineThinkness / 2.)];
        if(self.isGuide){
            [linePath moveToPoint:CGPointMake(rectWidth - self.lineThinkness / 2., rectHeight / 2.)];
            [linePath addLineToPoint:CGPointMake(self.lineThinkness / 2., rectHeight / 2.)];
        }
    }else if(self.direction == ArrowDirectUp){
        CGFloat yOffSet = rectHeight * (1 - self.arrowHeightRate);
        [linePath moveToPoint:CGPointMake(self.lineThinkness / 2., rectHeight - self.lineThinkness / 2. - yOffSet)];
        [linePath addLineToPoint:CGPointMake(rectWidth / 2., self.lineThinkness / 2.)];
        [linePath addLineToPoint:CGPointMake(rectWidth - self.lineThinkness / 2., rectHeight - self.lineThinkness / 2. - yOffSet)];
        if(self.isGuide){
            [linePath moveToPoint:CGPointMake(rectWidth / 2., self.lineThinkness / 2.)];
            [linePath addLineToPoint:CGPointMake(rectWidth / 2., rectHeight - self.lineThinkness / 2.)];
        }
    }else if(self.direction == ArrowDirectDown){
        CGFloat yOffSet = rectHeight * (1 - self.arrowHeightRate);
        [linePath moveToPoint:CGPointMake(self.lineThinkness / 2., self.lineThinkness / 2. + yOffSet)];
        [linePath addLineToPoint:CGPointMake(rectWidth / 2., rectHeight - self.lineThinkness / 2.)];
        [linePath addLineToPoint:CGPointMake(rectWidth - self.lineThinkness / 2., self.lineThinkness / 2. + yOffSet)];
        if(self.isGuide){
            [linePath moveToPoint:CGPointMake(rectWidth / 2., rectHeight - self.lineThinkness / 2.)];
            [linePath addLineToPoint:CGPointMake(rectWidth / 2., self.lineThinkness / 2.)];
        }
    }
    
    if(self.isClosed && !self.isGuide){
        [linePath closePath]; //封闭图形
    }
    [self.lineColor setStroke];
    [linePath stroke]; //绘制线条
    
    CGFloat fillAlpha = CGColorGetAlpha(self.fillColor.CGColor);
    if(fillAlpha != 0){
        UIBezierPath* fillPath = [linePath copy];
        [fillPath closePath]; //封闭图形
        
        [self.fillColor setFill];
        [fillPath fill];
    }
    
}

-(void)setDirection:(ArrowDirect)direction{
    _arrowDirect = direction;
    [self setNeedsLayout];
}

-(ArrowDirect)direction{
    if (!_arrowDirect) {
        _arrowDirect = ArrowDirectLeft;//默认向左
    }
    return _arrowDirect;
}

-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    [self setNeedsLayout];
}

-(UIColor *)lineColor{
    if (!_lineColor) {
        _lineColor = [UIColor blackColor];
    }
    return _lineColor;
}

-(void)setLineThinkness:(CGFloat)lineThinkness{
    _lineThinkness = lineThinkness;
    [self setNeedsLayout];
}

-(CGFloat)lineThinkness{
    if (!_lineThinkness) {
        _lineThinkness = 1;
    }
    return _lineThinkness;
}

-(void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    [self setNeedsLayout];
}

-(UIColor *)fillColor{
    if (!_fillColor) {
        _fillColor = [UIColor clearColor];
    }
    return _fillColor;
}

-(void)setIsClosed:(BOOL)isClosed{
    _isClosed = isClosed;
    [self setNeedsLayout];
}

-(void)setIsGuide:(BOOL)isGuide{
    _isGuide = isGuide;
    [self setNeedsLayout];
}

-(void)setArrowHeightRate:(CGFloat)arrowHeightRate{
    _arrowHeightRate = arrowHeightRate;
    [self setNeedsLayout];
}

-(CGFloat)arrowHeightRate{
    if (!_arrowHeightRate) {
        _arrowHeightRate = 1;
    }
    return _arrowHeightRate;
}




@end
