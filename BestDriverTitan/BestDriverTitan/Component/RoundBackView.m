//
//  RoundBackView.m
//  BestDriverTitan
//
//  Created by admin on 2017/10/12.
//  Copyright © 2017年 admin. All rights reserved.
//


#import "RoundBackView.h"
#import "RoundRectNode.h"

@interface RoundBackView(){
    UIColor* _fillColor;
}

@property (nonatomic,retain)RoundRectNode* backNode;

@end

@implementation RoundBackView

-(RoundRectNode *)backNode{
    if (!_backNode) {
        _backNode = [[RoundRectNode alloc]init];
//        _backNode.fillColor = [UIColor whiteColor];
//        back.cornerRadius = 0;//5;
        _backNode.layerBacked = YES;
        [self.layer addSublayer:_backNode.layer];
    }
    return _backNode;
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    [self setNeedsLayout];
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

-(void)layoutSubviews{
    
    self.backNode.cornerRadius = self.cornerRadius;
    self.backNode.fillColor = self.fillColor;
    
    self.backNode.frame = CGRectMake(self.paddingLeft, self.paddingTop, self.width - self.paddingLeft - self.paddingRight, self.height - self.paddingTop - self.paddingBottom);
    
}


@end
