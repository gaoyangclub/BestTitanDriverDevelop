//
//  CustomAnnotationView.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomAnnotationView.h"
#import "RoundRectNode.h"
#import "FlatButton.h"

@interface CustomAnnotationView(){
    NSInteger _titleSize;
    UIColor* _titleColor;
    UIColor* _backColor;
}

//@property(nonatomic,retain) ASTextNode* titleLabel;
@property(nonatomic,retain) ASTextNode* iconBack;
@property(nonatomic,retain) FlatButton* titleArea;

@end

@implementation CustomAnnotationView

//-(ASTextNode *)titleLabel{
//    if (!_titleLabel) {
//        _titleLabel = [[ASTextNode alloc]init];
//        _titleLabel.layerBacked = YES;
//        [self.layer addSublayer:_titleLabel.layer];
//    }
//    return _titleLabel;
//}

-(FlatButton *)titleArea{
    if (!_titleArea) {
        _titleArea = [[FlatButton alloc]init];
        _titleArea.userInteractionEnabled = NO;
        [self addSubview:_titleArea];
    }
    return _titleArea;
}

-(ASTextNode *)iconBack{
    if (!_iconBack) {
        _iconBack = [[ASTextNode alloc]init];
        _iconBack.layerBacked = YES;
        [self.layer addSublayer:_iconBack.layer];
    }
    return _iconBack;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self setNeedsLayout];
}

-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    [self setNeedsLayout];
}

-(UIColor *)titleColor{
    if (!_titleColor) {
        _titleColor = [UIColor whiteColor];
    }
    return _titleColor;
}

-(void)setTitleSize:(NSInteger)titleSize{
    _titleSize = titleSize;
    [self setNeedsLayout];
}

-(NSInteger)titleSize{
    if (!_titleSize) {
        _titleSize = 18;
    }
    return _titleSize;
}

-(void)setBackColor:(UIColor *)backColor{
    _backColor = backColor;
    [self setNeedsLayout];
}

-(UIColor*)backColor{
    if (!_backColor) {
        _backColor = [UIColor lightGrayColor];
    }
    return _backColor;
}

-(void)layoutSubviews{
//    self.image = nil;
    
    [super layoutSubviews];
    
    self.iconBack.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:self.backColor size:44 content:ICON_MAP_MARK];
    self.iconBack.size = [self.iconBack measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconBack.centerX = self.width / 2.;
    self.iconBack.y = -3;
    
    if (self.title) {
        CGFloat const cornerRadius = 10;
        self.titleArea.title = self.title;
        self.titleArea.titleColor = self.backColor;
        self.titleArea.titleSize = self.titleSize;
        self.titleArea.fillColor = [UIColor whiteColor];//self.titleColor;
        self.titleArea.cornerRadius = cornerRadius;
        self.titleArea.size = CGSizeMake(cornerRadius * 2, cornerRadius * 2);
//        self.titleLabel.attributedString = [NSString simpleAttributedString:self.titleColor size:self.titleSize content:self.title];
//        self.titleLabel.size = [self.titleLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        self.titleArea.centerX = self.width / 2.;
        self.titleArea.centerY = self.iconBack.y + self.iconBack.height / 2. - 5;
        self.titleArea.hidden = NO;
    }else if(self->_titleArea){
        self->_titleArea.hidden = YES;
    }
}


@end
