//
//  TaskTripSection.m
//  BestDriverTitan
//
//  Created by admin on 17/2/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskTripSection.h"

@interface TaskTripSection()

@property(nonatomic,retain) ASDisplayNode* backView;

@property (nonatomic,retain) ASTextNode* iconStart;//起点图标
@property (nonatomic,retain) ASTextNode* iconEnd;//终点
@property (nonatomic,retain) ASTextNode* textStart;//起点图标
@property (nonatomic,retain) ASTextNode* textEnd;//终点

@end


@implementation TaskTripSection

-(ASDisplayNode *)backView{
    if (!_backView) {
        _backView = [[ASDisplayNode alloc]init];
        _backView.layerBacked = YES;
        _backView.backgroundColor = [UIColor whiteColor];
        [self.layer addSublayer:_backView.layer];
    }
    return _backView;
}

-(ASTextNode *)iconStart{
    if (!_iconStart) {
        _iconStart = [[ASTextNode alloc]init];
        _iconStart.layerBacked = YES;
        [self.backView addSubnode:_iconStart];
    }
    return _iconStart;
}

-(ASTextNode *)iconEnd{
    if (!_iconEnd) {
        _iconEnd = [[ASTextNode alloc]init];
        _iconEnd.layerBacked = YES;
        [self.backView addSubnode:_iconEnd];
    }
    return _iconEnd;
}

-(ASTextNode *)textStart{
    if (!_textStart) {
        _textStart = [[ASTextNode alloc]init];
        _textStart.maximumNumberOfLines = 1;
        _textStart.truncationMode = NSLineBreakByTruncatingTail;
        _textStart.layerBacked = YES;
        [self.backView addSubnode:_textStart];
    }
    return _textStart;
}

-(ASTextNode *)textEnd{
    if (!_textEnd) {
        _textEnd = [[ASTextNode alloc]init];
        _textEnd.maximumNumberOfLines = 1;
        _textEnd.truncationMode = NSLineBreakByTruncatingTail;
        _textEnd.layerBacked = YES;
        [self.backView addSubnode:_textEnd];
    }
    return _textEnd;
}

-(void)layoutSubviews{
    self.backgroundColor = COLOR_BACKGROUND;

    CGFloat sectionWidth = self.bounds.size.width;
    CGFloat sectionHeight = self.bounds.size.height;
    
    CGFloat squareHeight = sectionHeight - 5;
    
    CGFloat leftpadding = 10;
    
    self.backView.frame = CGRectMake(0, 0, sectionWidth, squareHeight);
    
    self.iconStart.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatGreenDark size:24 context:ICON_QI_DIAN];
    CGSize iconStartSize = [self.iconStart measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconStart.frame = (CGRect){ CGPointMake(leftpadding,(squareHeight / 2. - iconStartSize.height) / 2.),iconStartSize};
    self.textStart.attributedString = [NSString simpleAttributedString:FlatBlack size:14 context:@"浙江省杭州市下沙区乔司仓库xx地方xx号xx巷子"];
    CGFloat maxStartWidth = sectionWidth - leftpadding * 2 - iconStartSize.width;
    
    CGSize textStartSize = [self.textStart measure:CGSizeMake(maxStartWidth, FLT_MAX)];
    self.textStart.frame = (CGRect){ CGPointMake(leftpadding + iconStartSize.width + leftpadding / 2.,(squareHeight / 2. - textStartSize.height) / 2.),textStartSize};
    
    self.iconEnd.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatOrange size:24 context:ICON_ZHONG_DIAN];
    CGSize iconEndSize = [self.iconEnd measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconEnd.frame = (CGRect){ CGPointMake(leftpadding,squareHeight / 2. + (squareHeight / 2. - iconEndSize.height) / 2.),iconEndSize};
    
    self.textEnd.attributedString = [NSString simpleAttributedString:FlatBlack size:14 context:@"浙江省杭州市西湖区万塘路xxx号支付宝大楼百世店家"];
    CGFloat maxEndWidth = sectionWidth - leftpadding * 2 - iconEndSize.width;
    CGSize textEndSize = [self.textEnd measure:CGSizeMake(maxEndWidth, FLT_MAX)];
    self.textEnd.frame = (CGRect){ CGPointMake(leftpadding + iconEndSize.width + leftpadding / 2.,squareHeight / 2. + (squareHeight / 2. - textEndSize.height) / 2.),textEndSize};
}





@end
