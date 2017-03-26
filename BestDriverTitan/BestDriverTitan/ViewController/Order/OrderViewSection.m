//
//  OrderViewSection.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/3/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderViewSection.h"

@interface OrderViewSection()

@property(nonatomic,retain)ASDisplayNode* square;

@property(nonatomic,retain)ASTextNode* title;
@property(nonatomic,retain)ASTextNode* desLabel;

@property (nonatomic,retain)ASTextNode* iconText;//未完成已完成

@end

@implementation OrderViewSection

-(ASDisplayNode *)square{
    if (!_square) {
        _square = [[ASDisplayNode alloc]init];
        _square.backgroundColor = [UIColor whiteColor];
        _square.layerBacked = YES;
        [self.layer addSublayer:_square.layer];
    }
    return _square;
}

-(ASTextNode *)desLabel{
    if (!_desLabel) {
        _desLabel = [[ASTextNode alloc]init];
        _desLabel.layerBacked = YES;
        [self.square addSubnode:_desLabel];
    }
    return _desLabel;
}

-(ASTextNode *)title{
    if (!_title) {
        _title = [[ASTextNode alloc]init];
        _title.layerBacked = YES;
        [self.square addSubnode:_title];
    }
    return _title;
}

-(ASTextNode *)iconText{
    if(!_iconText){
        _iconText = [[ASTextNode alloc]init];
        _iconText.layerBacked = YES;
        //        _iconText.backgroundColor = [UIColor flatBrownColor];
        [self.square addSubnode:_iconText];
    }
    return _iconText;
}

-(void)layoutSubviews{
//    TaskViewSectionVo* hvo = self.data;
//    if(!hvo){
//        return;
//    }
    
    CGFloat leftpadding = 10;
    
    CGFloat sectionWidth = self.bounds.size.width;
    CGFloat sectionHeight = self.bounds.size.height;
    
    UIColor* iconColor = COLOR_YI_WAN_CHENG;
    NSString* iconName = ICON_DING_DAN;
    
    NSString* content = ConcatStrings(@"SO1051160168080_",@(self.itemIndex));
    NSString* customer = @"客户单号 6742626737";
    
    self.square.frame = CGRectMake(0,0, sectionWidth, sectionHeight);
    
    self.iconText.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:24 content:iconName];
    CGSize iconSize = [self.iconText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconText.frame = (CGRect){ CGPointMake(leftpadding,(sectionHeight - iconSize.height) / 2. + 2),iconSize};
    
    self.title.attributedString = [NSString simpleAttributedString:[UIColor flatBlackColor] size:14 content:content];
    CGSize titleSize = [self.title measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.title.frame = (CGRect){CGPointMake(self.iconText.frame.origin.x + self.iconText.frame.size.width + 5, sectionHeight / 2. - 15),titleSize};
    
    self.desLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColor] size:12 content:customer];
    CGSize desSize = [self.desLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.desLabel.frame = (CGRect){CGPointMake(self.iconText.frame.origin.x + self.iconText.frame.size.width + 5, sectionHeight / 2. + 2),desSize};
    
}


@end
