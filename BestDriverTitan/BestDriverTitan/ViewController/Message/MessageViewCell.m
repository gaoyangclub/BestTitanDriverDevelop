//
//  MessageViewCell.m
//  BestDriverTitan
//
//  Created by admin on 2017/10/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MessageViewCell.h"
#import "AppPushMsg.h"
#import "RoundBackView.h"
#import "CircleNode.h"

@interface MessageViewCell()

@property(nonatomic,retain)ASTextNode* titleNode;
@property(nonatomic,retain)ASTextNode* describeNode;
@property(nonatomic,retain)ASDisplayNode* backNode;

@property(nonatomic,retain)CircleNode* readStatusNode;//是否已读的标志

@property (nonatomic,retain) RoundBackView* normalBackView;
@property (nonatomic,retain) RoundBackView* selectBackView;

@end

@implementation MessageViewCell

-(CircleNode *)readStatusNode{
    if (!_readStatusNode) {
        _readStatusNode = [[CircleNode alloc]init];
        _readStatusNode.layerBacked = YES;
        _readStatusNode.fillColor = FlatRed;
        _readStatusNode.cornerRadius = rpx(5);
        _readStatusNode.width = _readStatusNode.height = _readStatusNode.cornerRadius * 2;
        [self.backNode addSubnode:_readStatusNode];
    }
    return _readStatusNode;
}

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
//        _titleNode.maximumNumberOfLines = 1;//最多一行
//        _titleNode.truncationMode = NSLineBreakByTruncatingTail;
//        [self.contentView.layer addSublayer:_titleNode.layer];
        [self.backNode addSubnode:_titleNode];
    }
    return _titleNode;
}

-(ASTextNode *)describeNode{
    if (!_describeNode) {
        _describeNode = [[ASTextNode alloc]init];
        _describeNode.layerBacked = YES;
        _describeNode.maximumNumberOfLines = 5;//最多5行
        _describeNode.truncationMode = NSLineBreakByTruncatingTail;
//        [self.contentView.layer addSublayer:_describeNode.layer];
        [self.backNode addSubnode:_describeNode];
    }
    return _describeNode;
}

-(ASDisplayNode *)backNode{
    if (!_backNode) {
        _backNode = [[ASDisplayNode alloc]init];
//        _backNode.fillColor = [UIColor whiteColor];
//        _backNode.cornerRadius = 5;
        _backNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_backNode.layer];
    }
    return _backNode;
}

-(RoundBackView *)normalBackView{
    if (!_normalBackView) {
        _normalBackView = [[RoundBackView alloc]init];
        _normalBackView.fillColor = [UIColor whiteColor];
        _normalBackView.cornerRadius = rpx(5);
//                [self.contentView addSubview:_normalBackView];
    }
    return _normalBackView;
}

-(RoundBackView *)selectBackView{
    if (!_selectBackView) {
        _selectBackView = [[RoundBackView alloc]init];
        _selectBackView.fillColor = FlatWhite;
//        RoundRectNode* back = _selectBackView.backNode = [[RoundRectNode alloc]init];
//        back.fillColor = FlatWhite;
//        back.cornerRadius = 0;//5;
//        back.layerBacked = YES;
//        [_selectBackView.layer addSublayer:back.layer];
    }
    return _selectBackView;
}

-(CGFloat)getCellHeight:(CGFloat)cellWidth{
    
    self.backgroundView = self.normalBackView;
    self.selectedBackgroundView = self.selectBackView;
    
    AppPushMsg* pushMsg = self.data;
    
    CGFloat const leftMargin = rpx(10);
    CGFloat const topMargin = rpx(16);
    CGFloat const backWidth = cellWidth - leftMargin * 2;
    
    self.normalBackView.paddingLeft = self.normalBackView.paddingRight = leftMargin;
    self.normalBackView.paddingTop = self.normalBackView.paddingBottom = 0;
    
    NSString* titleContent = [Config getPushTypeTitle:pushMsg.type];
//    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:16 content:titleContent];
//    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
//    style.alignment = NSTextAlignmentLeft;
//    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, titleContent)];

    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_LARGE content:titleContent];;
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleNode.x = leftMargin;
    self.titleNode.y = topMargin;
    
    NSString* msgContent = pushMsg.msg;
    NSMutableAttributedString* msgString = (NSMutableAttributedString*)[NSString simpleAttributedString:FlatGray size:SIZE_TEXT_PRIMARY content:msgContent];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    [msgString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, msgContent.length)];
    
    self.describeNode.attributedString = msgString;
    CGFloat maxStartWidth = backWidth - leftMargin * 2;
    self.describeNode.size = [self.describeNode measure:CGSizeMake(maxStartWidth, FLT_MAX)];//CGSize textStartSize =
    self.describeNode.x = leftMargin;
    self.describeNode.y = self.titleNode.maxY + leftMargin;
    
    self.readStatusNode.hidden = pushMsg.isRead;
    if (!pushMsg.isRead) {//未读
        self.readStatusNode.centerY = self.titleNode.centerY;
        self.readStatusNode.maxX = backWidth - leftMargin;
    }
    
    CGFloat const backHeight = self.describeNode.maxY + topMargin;

//    if (self.isFirst) {//第一个顶部没有空隙
        self.backNode.frame = CGRectMake(leftMargin, 0, backWidth, backHeight);
    
        return backHeight;
//    }else{
//        self.backNode.frame = CGRectMake(leftMargin, topMargin, cellWidth - leftMargin * 2, backHeight);
//        return backHeight + topMargin;
//    }
}

@end
