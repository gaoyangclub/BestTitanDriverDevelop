//
//  TaskViewSection.m
//  BestDriverTitan
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskViewSection.h"

@implementation TaskViewSectionVo

@end

@interface TaskViewSection(){
    
}

@property(nonatomic,retain)ASDisplayNode* square;

@property(nonatomic,retain)ASTextNode* title;
@property(nonatomic,retain)ASTextNode* desLabel;

@property (nonatomic,retain)ASTextNode* iconText;//未完成已完成状态图标

@end

@implementation TaskViewSection

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
    TaskViewSectionVo* hvo = self.data;
    if(!hvo){
        return;
    }
    
    self.backgroundColor = COLOR_BACKGROUND;
    
    CGFloat sectionWidth = self.bounds.size.width;
    CGFloat sectionHeight = self.bounds.size.height;
    
    CGFloat squareHeight = sectionHeight - 5;
    
    CGFloat leftpadding = 10;
    
    UIColor* iconColor;
    NSString* iconName;
    
//    int count = (arc4random() % 3); //生成0-2范围的随机数
    if (hvo.isComplete) {
        //    if (self.indexPath.row % 2 == 0) {
        iconColor = COLOR_YI_WAN_CHENG;
        iconName = ICON_YI_WAN_CHENG;
    }else{
        iconColor = COLOR_DAI_WAN_CHENG;
        iconName = ICON_DAI_WAN_CHENG;
    }
    
    NSDate* dateNow = [[NSDate alloc]init];
    NSString* timeContent = nil;
    if (dateNow.timeIntervalSince1970 - hvo.dateTime.timeIntervalSince1970 < 24 * 3600) {
        timeContent = @"今天";
    }else if(dateNow.timeIntervalSince1970 - hvo.dateTime.timeIntervalSince1970 < 24 * 3600 * 2){
        timeContent = @"昨天";
    }else if(dateNow.timeIntervalSince1970 - hvo.dateTime.timeIntervalSince1970 < 24 * 3600 * 3){
        timeContent = @"前天";
    }else{
        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];//"yyyy-MM-dd HH:mm:ss"
        timeContent = [dateFormatter stringFromDate:hvo.dateTime];
    }
    
    self.square.frame = CGRectMake(0,0, sectionWidth, squareHeight);
    
    self.iconText.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:24 content:iconName];
    CGSize iconSize = [self.iconText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconText.frame = (CGRect){ CGPointMake(leftpadding,(squareHeight - iconSize.height) / 2. + 2),iconSize};
    
    self.title.attributedString = [NSString simpleAttributedString:[UIColor flatBlackColor] size:14 content:timeContent];
    CGSize titleSize = [self.title measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.title.frame = (CGRect){CGPointMake(self.iconText.frame.origin.x + self.iconText.frame.size.width + 5, sectionHeight / 2. - 15),titleSize};
    
    self.desLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColor] size:12 content:ConcatStrings(@"运单",[NSString stringWithFormat:@"%lu",(unsigned long)hvo.toCount],@"个")];
    CGSize desSize = [self.desLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.desLabel.frame = (CGRect){CGPointMake(self.iconText.frame.origin.x + self.iconText.frame.size.width + 5, sectionHeight / 2. + 2),desSize};
}

@end
