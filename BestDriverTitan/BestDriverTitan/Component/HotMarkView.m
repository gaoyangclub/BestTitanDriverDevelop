//
//  HotMarkView.m
//  BestDriverTitan
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HotMarkView.h"
#import "MathUtils.h"

@interface HotMarkView()

@property(nonatomic,retain)CAShapeLayer* arrowLayer;//三角形标签层
@property(nonatomic,retain)ASTextNode* markLabel;//标签文字

@end

@implementation HotMarkView

-(CAShapeLayer *)arrowLayer{
    if (!_arrowLayer) {
        _arrowLayer = [[CAShapeLayer alloc]init];
        [self.layer addSublayer:_arrowLayer];
    }
    return _arrowLayer;
}

-(ASTextNode *)markLabel{
    if (!_markLabel) {
        _markLabel = [[ASTextNode alloc]init];
        _markLabel.layerBacked = YES;
        [self.layer addSublayer:_markLabel.layer];
    }
    return _markLabel;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self setNeedsLayout];
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self setNeedsLayout];
}

-(void)setTitleSize:(CGFloat)titleSize{
    _titleSize = titleSize;
    [self setNeedsLayout];
}

-(void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    UIBezierPath* linePath = [UIBezierPath bezierPath];
    
    CGPoint point1 = (CGPoint){0,0};
    CGPoint point2 = (CGPoint){0,self.height};
    CGPoint point3 = (CGPoint){self.width,0};
    
    //左上角绘制
    [linePath moveToPoint:point1];
    [linePath addLineToPoint:point2];
    [linePath addLineToPoint:point3];
    [linePath closePath]; //封闭图形
    
    self.arrowLayer.path = linePath.CGPath;
    self.arrowLayer.fillColor = self.fillColor.CGColor;
    
    self.markLabel.attributedString = [NSString simpleAttributedString:self.titleColor size:self.titleSize content:self.title];
    self.markLabel.size = [self.markLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    CGPoint centerPoint = [MathUtils getTriangleInnerCenter:point1.x _:point1.y _:point2.x _:point2.y _:point3.x _:point3.y];
//    CGPoint centerPoint = (CGPoint){
//        (0 + 0 + self.width) / 3. , (0 + self.height + 0) / 3.
//    };
    self.markLabel.centerY = centerPoint.x;//self.height / 2.;
    self.markLabel.centerX = centerPoint.y;//self.width / 4.;
    
    [self.markLabel setTransform:CATransform3DMakeRotation(-45 * M_PI / 180,0,0,1)];
//    CGAffineTransform transform = CGAffineTransformMakeRotation(-45 * M_PI/180.0);
//    [self.markLabel setTransform:transform];
//    self.markLabel.centerY = self.height / 2.;
//    self.markLabel.centerX = self.width / 4.;
}




@end
