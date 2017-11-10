//
//  ScanTaskOrderCell.m
//  BestDriverTitan
//
//  Created by admin on 2017/11/3.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ScanTaskOrderCell.h"
#import "ScanTaskResultBean.h"

@interface ScanTaskOrderCell()

@property(nonatomic,retain) ASTextNode* iconText;//订单图标
@property(nonatomic,retain) ASTextNode* titleNode;//订单号
@property(nonatomic,retain) ASDisplayNode* bottomLine;//底部中线
@property(nonatomic,retain) ASTextNode* scanCodeLabel;//已扫描
@property(nonatomic,retain) ASTextNode* notScanCodeLabel;//未扫描
@property(nonatomic,retain) ASTextNode* scanCodeText;//已扫描 多行数据
@property(nonatomic,retain) ASTextNode* notScanCodeText;//未扫描 多行数据

@end

@implementation ScanTaskOrderCell


-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

-(ASTextNode *)iconText{
    if(!_iconText){
        _iconText = [[ASTextNode alloc]init];
        _iconText.layerBacked = YES;
        [self.contentView.layer addSublayer:_iconText.layer];
    }
    return _iconText;
}

-(ASDisplayNode *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[ASDisplayNode alloc]init];
        _bottomLine.layerBacked = YES;
        _bottomLine.backgroundColor = COLOR_LINE;
        [self.contentView.layer addSublayer:_bottomLine.layer];
    }
    return _bottomLine;
}

-(ASTextNode *)scanCodeLabel{
    if (!_scanCodeLabel) {
        _scanCodeLabel = [[ASTextNode alloc]init];
        _scanCodeLabel.layerBacked = YES;
        _scanCodeLabel.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:16 content:@"已扫描"];
        _scanCodeLabel.size = [_scanCodeLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.contentView.layer addSublayer:_scanCodeLabel.layer];
    }
    return _scanCodeLabel;
}

-(ASTextNode *)notScanCodeLabel{
    if (!_notScanCodeLabel) {
        _notScanCodeLabel = [[ASTextNode alloc]init];
        _notScanCodeLabel.layerBacked = YES;
        _notScanCodeLabel.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:16 content:@"未扫描"];
        _notScanCodeLabel.size = [_notScanCodeLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        [self.contentView.layer addSublayer:_notScanCodeLabel.layer];
    }
    return _notScanCodeLabel;
}

-(ASTextNode *)scanCodeText{
    if(!_scanCodeText){
        _scanCodeText = [[ASTextNode alloc]init];
        _scanCodeText.layerBacked = YES;
        _scanCodeText.maximumNumberOfLines = 0;//无限显示
//        _scanCodeText.truncationMode = NSLineBreakByTruncatingTail;
        [self.contentView.layer addSublayer:_scanCodeText.layer];
    }
    return _scanCodeText;
}

-(ASTextNode *)notScanCodeText{
    if (!_notScanCodeText) {
        _notScanCodeText =  [[ASTextNode alloc]init];
        _notScanCodeText.layerBacked = YES;
        _notScanCodeText.maximumNumberOfLines = 0;//无限显示
//        _notScanCodeText.truncationMode = NSLineBreakByTruncatingTail;
        [self.contentView.layer addSublayer:_notScanCodeText.layer];
    }
    return _notScanCodeText;
}

-(CGFloat)getCellHeight:(CGFloat)cellWidth{
    ScanTaskOrderBean* orderBean = self.data;
    if (!orderBean) {
        return 0;
    }
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    CGFloat const leftMargin = 10;
    CGFloat const topMargin = 16;
    CGFloat const topHeight = 50;
    
    [self initTopArea:leftMargin topHeight:topHeight topWidth:cellWidth];
    [self initCenterArea:leftMargin topMargin:topMargin centerY:topHeight centerWidth:cellWidth];
    
    return self.notScanCodeText.maxY + topMargin;
}

-(void)initTopArea:(CGFloat)leftMargin topHeight:(CGFloat)topHeight topWidth:(CGFloat)topWidth{
    ScanTaskOrderBean* orderBean = self.data;
    
    self.iconText.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_BLACK_ORIGINAL size:24 content:ICON_DING_DAN];
    self.iconText.size = [self.iconText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconText.x = leftMargin;
    
    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:16 content:orderBean.orderbaseCode];
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.titleNode.x = self.iconText.maxX + leftMargin;
    
    self.titleNode.centerY = self.iconText.centerY = topHeight / 2.;
    
    self.bottomLine.frame = CGRectMake(leftMargin, topHeight - LINE_WIDTH, topWidth - leftMargin * 2, LINE_WIDTH);
}

-(void)initCenterArea:(CGFloat)leftMargin topMargin:(CGFloat)topMargin centerY:(CGFloat)centerY centerWidth:(CGFloat)centerWidth{
    ScanTaskOrderBean* orderBean = self.data;
    
    CGFloat const gap = 10;
    
    self.scanCodeLabel.x = leftMargin;
    self.scanCodeLabel.y = centerY + gap;
    
    CGFloat maxTextWidth = centerWidth - leftMargin * 2;
    
    NSString* scanCodeContent = [orderBean.reportedPickupCodes componentsJoinedByString:@","];
    NSMutableAttributedString* scanCodeString = (NSMutableAttributedString*)[NSString simpleAttributedString:FlatGray size:14 content:scanCodeContent];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    [scanCodeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, scanCodeContent.length)];
    self.scanCodeText.attributedString = scanCodeString;
    self.scanCodeText.size = [self.scanCodeText measure:CGSizeMake(maxTextWidth, FLT_MAX)];
    self.scanCodeText.x = leftMargin;
    self.scanCodeText.y = self.scanCodeLabel.maxY;
    
    self.notScanCodeLabel.x = leftMargin;
    self.notScanCodeLabel.y = self.scanCodeText.maxY + gap;
    
    NSString* notScanCodeContent = orderBean.penddingReportPickupCodes.count > 0 ? [orderBean.penddingReportPickupCodes componentsJoinedByString:@","] : @"无";
    NSMutableAttributedString* notScanCodeString = (NSMutableAttributedString*)[NSString simpleAttributedString:FlatOrange size:14 content:notScanCodeContent];
    [notScanCodeString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, notScanCodeContent.length)];
    self.notScanCodeText.attributedString = notScanCodeString;
    self.notScanCodeText.size = [self.notScanCodeText measure:CGSizeMake(maxTextWidth, FLT_MAX)];
    self.notScanCodeText.x = leftMargin;
    self.notScanCodeText.y = self.notScanCodeLabel.maxY;
}


-(BOOL)showSelectionStyle{
    return NO;
}

@end
