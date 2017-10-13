//
//  MessageViewSection.m
//  BestDriverTitan
//
//  Created by admin on 2017/10/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MessageViewSection.h"
#import "DateUtils.h"

@implementation MessageViewSectionVo

@end

@interface MessageViewSection()

@property(nonatomic,retain)ASTextNode* titleNode;

@end

@implementation MessageViewSection

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        [self.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

-(void)layoutSubviews{
    MessageViewSectionVo* mvo = self.data;
    if(!mvo){
        return;
    }
    
    self.backgroundColor = COLOR_BACKGROUND;
    
    NSString* timeContent;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    NSString* timeUTCName = [DateUtils getUTCFormateName:mvo.dateTime];
    if (timeUTCName) {
        [dateFormatter setDateFormat:@"HH:mm"];//"yyyy-MM-dd HH:mm:ss"
        timeContent = ConcatStrings(timeUTCName,@" ",[dateFormatter stringFromDate:mvo.dateTime]);
    }else{
        [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];//"yyyy-MM-dd :ss"
        timeContent = [dateFormatter stringFromDate:mvo.dateTime];
    }
    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:timeContent];
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleNode.centerX = self.width / 2.;
    self.titleNode.centerY = self.height * 2. / 3.;
}

@end
