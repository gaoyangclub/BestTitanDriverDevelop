//
//  FlatButton.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FlatButton.h"
#import "RoundRectNode.h"

@interface FlatButton()

@property(nonatomic,retain) RoundRectNode* backArea;
@property(nonatomic,retain) ASTextNode* titleLabel;//去这里

@end

@implementation FlatButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepare];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepare];
    }
    return self;
}

-(void)prepare{
    //        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
    self.titleColor = [UIColor whiteColor];
    self.fillColor = [UIColor grayColor];
    self.titleSize = 12;
    self.cornerRadius = 5;
//    self.angle = -30;
    self.title = @"";
    [self setShowTouch:YES];
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

-(void)setTitleFontName:(NSString *)titleFontName{
    _titleFontName = titleFontName;
    [self setNeedsLayout];
}

-(void)setFillColor:(UIColor *)fillColor{
    _fillColor = fillColor;
    [self setNeedsLayout];
}

-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    [self setNeedsLayout];
}

-(RoundRectNode *)backArea{
    if (!_backArea) {
        _backArea = [[RoundRectNode alloc]init];
        _backArea.layerBacked = YES;
        [self.layer addSublayer:_backArea.layer];
    }
    return _backArea;
}

-(ASTextNode *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[ASTextNode alloc]init];
        _titleLabel.layerBacked = YES;
        [self.layer addSublayer:_titleLabel.layer];
    }
    return _titleLabel;
}

-(void)layoutSubviews{
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.bounds);
    
    self.backArea.cornerRadius = self.cornerRadius;
    self.backArea.strokeColor = self.strokeColor;
    self.backArea.strokeWidth = self.strokeWidth;
    self.backArea.fillColor = self.fillColor;
    self.backArea.frame = self.bounds;
    
    if (self.titleFontName) {
        self.titleLabel.attributedString = [NSString simpleAttributedString:self.titleFontName color:self.titleColor  size:self.titleSize content:self.title];
    }else{
        self.titleLabel.attributedString = [NSString simpleAttributedString:self.titleColor  size:self.titleSize content:self.title];
    }
    CGSize titleSize = [self.titleLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.titleLabel.frame = (CGRect){ CGPointMake((viewWidth - titleSize.width) / 2.,(viewHeight - titleSize.height) / 2.),titleSize};
    if(self.angle){
        CATransform3D transform = CATransform3DMakeRotation(self.angle * M_PI / 180,0,0,1);
        self.backArea.transform = self.titleLabel.transform = transform;
    }
}


@end
