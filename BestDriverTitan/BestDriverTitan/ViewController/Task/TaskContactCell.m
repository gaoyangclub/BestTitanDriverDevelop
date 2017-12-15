//
//  TaskContactCell.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskContactCell.h"
#import "FlatButton.h"
#import "ContactBean.h"
#import "OpenUrlUtils.h"

@interface TaskContactCell()

@property(nonatomic,retain) ASTextNode* titleLabel;
@property(nonatomic,retain) ASTextNode* titleIcon;
@property(nonatomic,retain) ASTextNode* phoneLabel;
@property (nonatomic,retain) FlatButton* phoneButton;//联系电话

@end

@implementation TaskContactCell

-(ASTextNode *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[ASTextNode alloc]init];
        _titleLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_titleLabel.layer];
    }
    return _titleLabel;
}

-(ASTextNode *)titleIcon{
    if (!_titleIcon) {
        _titleIcon = [[ASTextNode alloc]init];
        _titleIcon.layerBacked = YES;
        [self.contentView.layer addSublayer:_titleIcon.layer];
    }
    return _titleIcon;
}

-(ASTextNode *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [[ASTextNode alloc]init];
        _phoneLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_phoneLabel.layer];
    }
    return _phoneLabel;
}

-(FlatButton *)phoneButton{
    if (!_phoneButton) {
        _phoneButton = [[FlatButton alloc]init];
        _phoneButton.fillColor = COLOR_ACCENT;
        _phoneButton.titleColor = [UIColor whiteColor];
        _phoneButton.titleFontName = ICON_FONT_NAME;
        _phoneButton.titleSize = rpx(18);
        _phoneButton.title = ICON_DIAN_HUA;
        CGFloat radius = rpx(15);
        _phoneButton.width = _phoneButton.height = radius * 2;
        _phoneButton.cornerRadius = radius;
        [_phoneButton addTarget:self action:@selector(clickPhoneButton) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_phoneButton];
    }
    return _phoneButton;
}

-(void)clickPhoneButton{//调用打电话功能
    ContactBean* bean = self.data;
    [OpenUrlUtils openTelephone:[bean getPhoneCall]];
}

-(void)showSubviews{
    
    ContactBean* bean = self.data;
    
    CGFloat margin = rpx(15);
    
    self.titleIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_ACCENT size:rpx(20) content:ICON_WO_DE];
    self.titleIcon.size = [self.titleIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleIcon.x = margin;
    
    self.titleLabel.attributedString = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:bean.name];
    self.titleLabel.size = [self.titleLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleLabel.x = self.titleIcon.maxX;
    
//    self.phoneButton.width = self.phoneButton.height = 30;
    self.phoneButton.maxX = self.contentView.width - margin;
    
    self.phoneLabel.attributedString = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:[bean getPhoneCall]];
    self.phoneLabel.size = [self.phoneLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.phoneLabel.maxX = self.phoneButton.x - margin;
    
    self.titleIcon.centerY = self.titleLabel.centerY = self.phoneButton.centerY = self.phoneLabel.centerY = self.contentView.centerY;
}

-(BOOL)showSelectionStyle{
    return NO;
}


@end
