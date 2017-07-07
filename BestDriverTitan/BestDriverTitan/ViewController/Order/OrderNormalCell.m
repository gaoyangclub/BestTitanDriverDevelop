//
//  OrderNormalCell.m
//  BestDriverTitan
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderNormalCell.h"
#import "DiyNumberAddView.h"

@interface OrderNormalCell()

@property(nonatomic,retain)ASTextNode* titleLabel;//标题

@property(nonatomic,retain)DiyNumberAddView* packageNumberView;//
@property(nonatomic,retain)ASTextNode* packageLabel;//包装数

@property(nonatomic,retain)DiyNumberAddView* pieceNumberView;
@property(nonatomic,retain)ASTextNode* pieceLabel;//内件数

@property(nonatomic,retain)ASTextNode* weightLabel;//重量

@property(nonatomic,retain)ASTextNode* volumeLabel;//体积

@property(nonatomic,retain)ASDisplayNode* bottomLine;//底部中线

@end

@implementation OrderNormalCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(ASTextNode *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[ASTextNode alloc]init];
        _titleLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_titleLabel.layer];
    }
    return _titleLabel;
}

-(ASTextNode *)packageLabel{
    if(!_packageLabel){
        _packageLabel = [[ASTextNode alloc]init];
        _packageLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_packageLabel.layer];
    }
    return _packageLabel;
}

-(DiyNumberAddView *)packageNumberView{
    if (!_packageNumberView) {
        _packageNumberView = [[DiyNumberAddView alloc]init];
        [self.contentView addSubview:_packageNumberView];
        _packageNumberView.cornerRadius = 5;
        _packageNumberView.fillColor = [UIColor whiteColor];
        _packageNumberView.strokeWidth = 1;
        _packageNumberView.strokeColor = COLOR_LINE;
    }
    return _packageNumberView;
}

-(ASTextNode *)pieceLabel{
    if(!_pieceLabel){
        _pieceLabel = [[ASTextNode alloc]init];
        _pieceLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_pieceLabel.layer];
    }
    return _pieceLabel;
}

-(DiyNumberAddView *)pieceNumberView{
    if (!_pieceNumberView) {
        _pieceNumberView = [[DiyNumberAddView alloc]init];
        [self.contentView addSubview:_pieceNumberView];
        _pieceNumberView.cornerRadius = 5;
        _pieceNumberView.fillColor = [UIColor whiteColor];
        _pieceNumberView.strokeWidth = 1;
        _pieceNumberView.strokeColor = COLOR_LINE;
    }
    return _pieceNumberView;
}


-(ASTextNode *)weightLabel{
    if(!_weightLabel){
        _weightLabel = [[ASTextNode alloc]init];
        _weightLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_weightLabel.layer];
    }
    return _weightLabel;
}

-(ASTextNode *)volumeLabel{
    if(!_volumeLabel){
        _volumeLabel = [[ASTextNode alloc]init];
        _volumeLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_volumeLabel.layer];
    }
    return _volumeLabel;
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

-(void)showSubviews{
    
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat viewWidth = CGRectGetWidth(self.contentView.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.contentView.bounds);
    
    CGFloat lefftpadding = 10;
    CGFloat titleHeight = 30;
    CGFloat offsetY = titleHeight - 10;
    
    CGFloat gapWidth = viewWidth / 2.;
    CGFloat gapHeight = (viewHeight - titleHeight) / 2.;
    CGFloat numberWidth = 100;
    CGFloat numberHeight = 30;
    
    self.titleLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:14 content:@"阿迪达斯毛巾啊"];
//    self.titleLabel.backgroundColor = [UIColor brownColor];
    CGSize titleSize = [self.titleLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleLabel.frame = (CGRect){ CGPointMake(lefftpadding,(titleHeight - titleSize.height) / 2.), titleSize};
    
    self.packageLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:12 content:ConcatStrings(ICON_BAO_ZHUANG,@"包装数(箱)")];
    CGSize packageSize = [self.packageLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.packageLabel.frame = (CGRect){ CGPointMake(gapWidth * 0 + (gapWidth - packageSize.width) / 2., offsetY + gapHeight * 0 + (gapHeight / 2. - packageSize.height)), packageSize};
    self.packageNumberView.frame = CGRectMake(gapWidth * 0 + (gapWidth - numberWidth) / 2., offsetY + gapHeight * 0 + (gapHeight / 2.), numberWidth, numberHeight);
    
    self.pieceLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:12 content:ConcatStrings(ICON_JIAN_SHU,@"内件数量")];
    CGSize pieceSize = [self.pieceLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.pieceLabel.frame = (CGRect){ CGPointMake(gapWidth * 1 + (gapWidth - pieceSize.width) / 2., offsetY + gapHeight * 0 + (gapHeight / 2. - pieceSize.height)), pieceSize};
    self.pieceNumberView.frame = CGRectMake(gapWidth * 1 + (gapWidth - numberWidth) / 2., offsetY + gapHeight * 0 + (gapHeight / 2.), numberWidth, numberHeight);
    
    
    self.weightLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:12 content:ConcatStrings(ICON_ZHONG_LIANG,@"重量(kg)")];
    CGSize weightSize = [self.weightLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.weightLabel.frame = (CGRect){ CGPointMake(gapWidth * 0 + (gapWidth - weightSize.width) / 2., offsetY + gapHeight * 1 + (gapHeight / 2. - weightSize.height)), weightSize};
    
    
    self.volumeLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:12 content:ConcatStrings(ICON_TI_JI,@"体积(m³)")];
    CGSize volumeSize = [self.volumeLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.volumeLabel.frame = (CGRect){ CGPointMake(gapWidth * 1 + (gapWidth - volumeSize.width) / 2., offsetY + gapHeight * 1 + (gapHeight / 2. - volumeSize.height)), volumeSize};
    
    self.bottomLine.frame = CGRectMake(lefftpadding, titleHeight, viewWidth - lefftpadding * 2, 1);
    
}

-(BOOL)showSelectionStyle{
    return NO;
}

@end
