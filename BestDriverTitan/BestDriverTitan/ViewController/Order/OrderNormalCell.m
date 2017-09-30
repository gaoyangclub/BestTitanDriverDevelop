//
//  OrderNormalCell.m
//  BestDriverTitan
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderNormalCell.h"
#import "DiyNumberAddView.h"
#import "FlatButton.h"
#import "OrderEditModelView.h"
#import "UIArrowView.h"
#import "ShipmentActivityShipUnitBean.h"

@interface OrderNormalCell()

@property(nonatomic,retain)ASTextNode* orderIcon;//标签图标

@property(nonatomic,retain)ASTextNode* titleLabel;//标题

//@property(nonatomic,retain)DiyNumberAddView* packageNumberView;//
@property(nonatomic,retain)ASTextNode* packageLabel;//包装数

//@property(nonatomic,retain)DiyNumberAddView* pieceNumberView;
@property(nonatomic,retain)ASTextNode* pieceLabel;//内件数

//@property(nonatomic,retain)FlatButton* editButton;//编辑 铅笔

@property(nonatomic,retain)ASTextNode* weightLabel;//重量

@property(nonatomic,retain)ASTextNode* volumeLabel;//体积

@property(nonatomic,retain)ASDisplayNode* bottomLine;//底部线

@property(nonatomic,retain)UIArrowView* rightArrow;//向右箭头

//@property(nonatomic,assign)double weightValue;

@property(nonatomic,retain)__block RACDisposable *weightHandler;
@property(nonatomic,retain)__block RACDisposable *volumeHandler;
@property(nonatomic,retain)__block RACDisposable *packageHandler;
@property(nonatomic,retain)__block RACDisposable *itemHandler;

@end

@implementation OrderNormalCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(ASTextNode *)orderIcon{
    if (!_orderIcon) {
        _orderIcon = [[ASTextNode alloc]init];
        _orderIcon.layerBacked = YES;
        [self.contentView.layer addSublayer:_orderIcon.layer];
    }
    return _orderIcon;
}

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

//-(DiyNumberAddView *)packageNumberView{
//    if (!_packageNumberView) {
//        _packageNumberView = [[DiyNumberAddView alloc]init];
//        [self.contentView addSubview:_packageNumberView];
//        _packageNumberView.cornerRadius = 5;
//        _packageNumberView.fillColor = [UIColor whiteColor];
//        _packageNumberView.strokeWidth = 1;
//        _packageNumberView.strokeColor = COLOR_LINE;
//    }
//    return _packageNumberView;
//}

-(ASTextNode *)pieceLabel{
    if(!_pieceLabel){
        _pieceLabel = [[ASTextNode alloc]init];
        _pieceLabel.layerBacked = YES;
        [self.contentView.layer addSublayer:_pieceLabel.layer];
    }
    return _pieceLabel;
}

//-(FlatButton *)editButton{
//    if (!_editButton) {
//        _editButton = [[FlatButton alloc]init];
//        _editButton.fillColor = [UIColor clearColor];
//        _editButton.titleFontName = ICON_FONT_NAME;
//        _editButton.titleSize = 24;
//        _editButton.titleColor = COLOR_ACCENT;
//        _editButton.title = ICON_BIAN_JI;
////        [_editButton setShowTouch:YES];
//        [_editButton addTarget:self action:@selector(clickEditButton) forControlEvents:UIControlEventTouchUpInside];
//        [self.contentView addSubview:_editButton];
//    }
//    return _editButton;
//}

//-(void)clickEditButton{
//    OrderEditModelView* editView = [[OrderEditModelView alloc]init];
//    [editView show];
//}

-(UIArrowView *)rightArrow{
    if (!_rightArrow) {
        _rightArrow = [[UIArrowView alloc]init];
        _rightArrow.direction = ArrowDirectRight;
        _rightArrow.lineColor = COLOR_LINE;
        _rightArrow.lineThinkness = 2;
        _rightArrow.size = CGSizeMake(8 , 14);
        [self.contentView addSubview:_rightArrow];
    }
    return _rightArrow;
}

//-(DiyNumberAddView *)pieceNumberView{
//    if (!_pieceNumberView) {
//        _pieceNumberView = [[DiyNumberAddView alloc]init];
//        [self.contentView addSubview:_pieceNumberView];
//        _pieceNumberView.cornerRadius = 5;
//        _pieceNumberView.fillColor = [UIColor whiteColor];
//        _pieceNumberView.strokeWidth = 1;
//        _pieceNumberView.strokeColor = COLOR_LINE;
//    }
//    return _pieceNumberView;
//}

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

//-(void)showSubviews{
//    
//    self.backgroundColor = [UIColor whiteColor];
//    
//    CGFloat viewWidth = CGRectGetWidth(self.contentView.bounds);
//    CGFloat viewHeight = CGRectGetHeight(self.contentView.bounds);
//    
//    CGFloat lefftpadding = 10;
//    CGFloat titleHeight = 30;
//    CGFloat offsetY = titleHeight - 10;
//    
//    CGFloat gapWidth = viewWidth / 2.;
//    CGFloat gapHeight = (viewHeight - titleHeight) / 2.;
//    CGFloat numberWidth = 100;
//    CGFloat numberHeight = 30;
//    
//    self.titleLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:14 content:@"阿迪达斯毛巾啊"];
////    self.titleLabel.backgroundColor = [UIColor brownColor];
//    CGSize titleSize = [self.titleLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    self.titleLabel.frame = (CGRect){ CGPointMake(lefftpadding,(titleHeight - titleSize.height) / 2.), titleSize};
//    
//    self.packageLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:12 content:ConcatStrings(ICON_BAO_ZHUANG,@"包装数(箱)")];
//    CGSize packageSize = [self.packageLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    self.packageLabel.frame = (CGRect){ CGPointMake(gapWidth * 0 + (gapWidth - packageSize.width) / 2., offsetY + gapHeight * 0 + (gapHeight / 2. - packageSize.height)), packageSize};
//    self.packageNumberView.frame = CGRectMake(gapWidth * 0 + (gapWidth - numberWidth) / 2., offsetY + gapHeight * 0 + (gapHeight / 2.), numberWidth, numberHeight);
//    
//    self.pieceLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:12 content:ConcatStrings(ICON_JIAN_SHU,@"内件数量")];
//    CGSize pieceSize = [self.pieceLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    self.pieceLabel.frame = (CGRect){ CGPointMake(gapWidth * 1 + (gapWidth - pieceSize.width) / 2., offsetY + gapHeight * 0 + (gapHeight / 2. - pieceSize.height)), pieceSize};
//    self.pieceNumberView.frame = CGRectMake(gapWidth * 1 + (gapWidth - numberWidth) / 2., offsetY + gapHeight * 0 + (gapHeight / 2.), numberWidth, numberHeight);
//    
//    
//    self.weightLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:12 content:ConcatStrings(ICON_ZHONG_LIANG,@"重量(kg)")];
//    CGSize weightSize = [self.weightLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    self.weightLabel.frame = (CGRect){ CGPointMake(gapWidth * 0 + (gapWidth - weightSize.width) / 2., offsetY + gapHeight * 1 + (gapHeight / 2. - weightSize.height)), weightSize};
//    
//    self.volumeLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor] size:12 content:ConcatStrings(ICON_TI_JI,@"体积(m³)")];
//    CGSize volumeSize = [self.volumeLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    self.volumeLabel.frame = (CGRect){ CGPointMake(gapWidth * 1 + (gapWidth - volumeSize.width) / 2., offsetY + gapHeight * 1 + (gapHeight / 2. - volumeSize.height)), volumeSize};
//    
//    self.bottomLine.hidden = self.isFirst;
//    if (!self.isFirst) {
//        self.bottomLine.frame = CGRectMake(lefftpadding, 0, viewWidth - lefftpadding * 2, LINE_WIDTH);
//    }
//}

-(void)showSubviews{
    self.backgroundColor = [UIColor whiteColor];
    
    ShipmentActivityShipUnitBean* shipUnitBean = (ShipmentActivityShipUnitBean*)self.data;
    
    CGFloat viewWidth = CGRectGetWidth(self.contentView.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.contentView.bounds);
    
    CGFloat leftpadding = 5;
    
    self.orderIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_BLACK_ORIGINAL size:20 content:ICON_BIAO_QIAN_DOWN];
    CGSize iconSize = [self.orderIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.orderIcon.frame = (CGRect){
        CGPointMake(leftpadding, (viewHeight  - iconSize.height) / 2.),iconSize
    };
    
    CGFloat labelLeftMargin = CGRectGetMaxX(self.orderIcon.frame) + 5;
    
    self.titleLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_BLACK_ORIGINAL size:14 content:shipUnitBean.itemName];
    CGSize titleSize = [self.titleLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleLabel.frame = (CGRect){
        CGPointMake(labelLeftMargin, viewHeight / 2. - 15),titleSize
    };
    
    CGFloat bottomY = viewHeight / 2. + 1;
    
    __weak __typeof(self) weakSelf = self;
//    [RACObserve(cell.textLabel, text) takeUntil:cell.rac_prepareForReuseSignal]
    
    
//    [shipUnitBean rac_valuesForKeyPath:@"pacakageUnitCount" observer:nil] takeUntil:deallocSignal]
    if (self.packageHandler) {
        [self.packageHandler dispose];
    }
    self.packageHandler = [[shipUnitBean rac_valuesForKeyPath:@"pacakageUnitCount" observer:nil] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIColor* labelColor = shipUnitBean.orgPacakageUnitCount != shipUnitBean.pacakageUnitCount ? FlatOrange : FlatGray;
        strongSelf.packageLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:labelColor size:12 content:[NSString stringWithFormat:@"包装%ld箱",(long)shipUnitBean.pacakageUnitCount]];
        CGSize packageSize = [strongSelf.packageLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        strongSelf.packageLabel.frame = (CGRect){ CGPointMake(labelLeftMargin, bottomY), packageSize};
    }];
    
    if (self.itemHandler) {
        [self.itemHandler dispose];
    }
    self.itemHandler = [[shipUnitBean rac_valuesForKeyPath:@"itemCount" observer:nil] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIColor* labelColor = shipUnitBean.orgItemCount != shipUnitBean.itemCount ? FlatOrange : FlatGray;
        strongSelf.pieceLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:labelColor size:12 content:[NSString stringWithFormat:@"内件%ld件",(long)shipUnitBean.itemCount]];
        CGSize pieceSize = [self.pieceLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        strongSelf.pieceLabel.frame = (CGRect){ CGPointMake(CGRectGetMaxX(strongSelf.packageLabel.frame) + leftpadding, CGRectGetMidY(strongSelf.packageLabel.frame) - pieceSize.height / 2.), pieceSize};
    }];
    
//    __block RACDisposable *handler = [RACObserve(self, username) subscribeNext:^(NSString *newName) {
//        if ([newName isEqualToString:@"Stop"]) {
//            //Do not observe any more
//            [handler dispose]
//        }
//    }];
    
    if (self.weightHandler) {
        [self.weightHandler dispose];
    }
    self.weightHandler = [[shipUnitBean rac_valuesForKeyPath:@"actualReceivedWeight" observer:nil] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIColor* labelColor = [shipUnitBean.orgWeight isEqualToString:shipUnitBean.actualReceivedWeight] ? FlatGray : FlatOrange;
        strongSelf.weightLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:labelColor size:12 content:[NSString stringWithFormat:@"重量%@kg",shipUnitBean.actualReceivedWeight]];
        strongSelf.weightLabel.size = [strongSelf.weightLabel measure:(CGSizeMake(FLT_MAX, FLT_MAX))];
        strongSelf.weightLabel.x = strongSelf.pieceLabel.maxX + leftpadding;
        strongSelf.weightLabel.centerY = strongSelf.packageLabel.centerY;
    }];
    
//    RAC(self,weightValue) = [RACObserve(shipUnitBean, actualReceivedWeight) takeUntilReplacement:self.rac_prepareForReuseSignal];
    if (self.volumeHandler) {
        [self.volumeHandler dispose];
    }
    self.volumeHandler = [[shipUnitBean rac_valuesForKeyPath:@"actualReceivedVolume" observer:nil] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIColor* labelColor = [shipUnitBean.orgVolume isEqualToString:shipUnitBean.actualReceivedVolume] ? FlatGray : FlatOrange;
        strongSelf.volumeLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:labelColor size:12 content:[NSString stringWithFormat:@"体积%@m³",shipUnitBean.actualReceivedVolume]];
        strongSelf.volumeLabel.size = [strongSelf.volumeLabel measure:(CGSizeMake(FLT_MAX, FLT_MAX))];
        strongSelf.volumeLabel.x = strongSelf.weightLabel.maxX + leftpadding;
        strongSelf.volumeLabel.centerY = strongSelf.packageLabel.centerY;
    }];
    
//    CGFloat buttonWidth = viewHeight - 10;
//    CGFloat buttonHeight = buttonWidth;
//    self.editButton.frame = CGRectMake(viewWidth - buttonWidth - lefftpadding, (viewHeight - buttonHeight) / 2., buttonWidth, buttonHeight);
    
    self.rightArrow.x = viewWidth - self.rightArrow.width - leftpadding;
    self.rightArrow.centerY = self.contentView.centerY;
//    self.rightArrow.frame = CGRectMake(viewWidth - buttonWidth - lefftpadding, (viewHeight - buttonHeight) / 2., buttonWidth, buttonHeight);
    
    self.bottomLine.frame = CGRectMake(leftpadding, viewHeight - LINE_WIDTH, viewWidth - leftpadding * 2, LINE_WIDTH);
}

//-(void)setWeightValue:(double)weightValue{
//    _weightValue = weightValue;
//    CGFloat leftpadding = 5;
//    //        __strong typeof(weakSelf) strongSelf = weakSelf;
//    ShipmentActivityShipUnitBean* shipUnitBean = (ShipmentActivityShipUnitBean*)self.data;
//    UIColor* labelColor = shipUnitBean.orgWeight != shipUnitBean.actualReceivedWeight ? FlatOrange : FlatGray;
//    self.weightLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:labelColor size:12 content:[NSString stringWithFormat:@"重量%gkg",shipUnitBean.actualReceivedWeight]];
//    self.weightLabel.size = [self.weightLabel measure:(CGSizeMake(FLT_MAX, FLT_MAX))];
//    self.weightLabel.x = self.pieceLabel.maxX + leftpadding;
//    self.weightLabel.centerY = self.packageLabel.centerY;
//}

//-(BOOL)showSelectionStyle{
//    return NO;
//}

@end
