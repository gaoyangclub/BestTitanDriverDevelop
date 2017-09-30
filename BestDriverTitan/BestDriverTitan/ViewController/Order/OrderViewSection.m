//
//  OrderViewSection.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/3/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderViewSection.h"
#import "FlatButton.h"
#import "RoundRectNode.h"
#import "ShipmentTaskBean.h"
#import "UIArrowView.h"
#import "OrderDetailController.h"
#import "OwnerViewController.h"

@interface OrderViewSection()

@property(nonatomic,retain) UIControl* square;

@property(nonatomic,retain) ASTextNode* title;
@property(nonatomic,retain) ASTextNode* desLabel;

@property(nonatomic,retain) ASTextNode* iconText;//订单图标

//@property(nonatomic,retain) FlatButton* pageButton;

@property (nonatomic,retain) FlatButton* stateArea;//未完成已完成

@property(nonatomic,retain) ASDisplayNode* bottomLine;//底部中线

@property(nonatomic,retain) UIArrowView* rightArrow;//向右箭头

@property(nonatomic,retain) ASTextNode* detailLabel;//详情两个字

@property(nonatomic,retain) ASTextNode* shipUintTotalLabel;//预计(实际)提送货量

@property(nonatomic,retain)__block RACDisposable *statusHandler;

@end

@implementation OrderViewSection

-(UIControl *)square{
    if (!_square) {
        _square = [[UIControl alloc]init];
        _square.backgroundColor = [UIColor whiteColor];
        [_square setShowTouch:YES];
        [self addSubview:_square];
    }
    return _square;
}

-(ASTextNode *)desLabel{
    if (!_desLabel) {
        _desLabel = [[ASTextNode alloc]init];
        _desLabel.layerBacked = YES;
        [self.square.layer addSublayer:_desLabel.layer];
    }
    return _desLabel;
}

-(ASTextNode *)title{
    if (!_title) {
        _title = [[ASTextNode alloc]init];
        _title.layerBacked = YES;
        [self.square.layer addSublayer:_title.layer];
    }
    return _title;
}

-(ASTextNode *)iconText{
    if(!_iconText){
        _iconText = [[ASTextNode alloc]init];
        _iconText.layerBacked = YES;
        //        _iconText.backgroundColor = [UIColor flatBrownColor];
        [self.square.layer addSublayer:_iconText.layer];
    }
    return _iconText;
}

-(ASTextNode *)shipUintTotalLabel{
    if (!_shipUintTotalLabel) {
        _shipUintTotalLabel = [[ASTextNode alloc]init];
        _shipUintTotalLabel.layerBacked = YES;
        [self.square.layer addSublayer:_shipUintTotalLabel.layer];
    }
    return _shipUintTotalLabel;
}

-(ASDisplayNode *)bottomLine{
    if (!_bottomLine) {
        _bottomLine = [[ASDisplayNode alloc]init];
        _bottomLine.layerBacked = YES;
        _bottomLine.backgroundColor = COLOR_LINE;
        [self.square.layer addSublayer:_bottomLine.layer];
    }
    return _bottomLine;
}

//-(FlatButton *)pageButton{
//    if (!_pageButton) {
//        _pageButton = [[FlatButton alloc]init];
////        _pageButton.strokeWidth = 1;
////        _pageButton.strokeColor = COLOR_PRIMARY;
//        _pageButton.titleSize = 14;
//        _pageButton.titleColor = [UIColor whiteColor];//COLOR_PRIMARY;
////        _pageButton.fillColor = [UIColor whiteColor];
//        [_pageButton addTarget:self action:@selector(clickPageButton) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_pageButton];
//    }
//    return _pageButton;
//}

-(FlatButton *)stateArea{
    if (!_stateArea) {
        _stateArea = [[FlatButton alloc]init];
        _stateArea.userInteractionEnabled = NO;
        _stateArea.cornerRadius = 3;
        _stateArea.fillColor = [UIColor whiteColor];
        _stateArea.strokeWidth = 1;
        //        _stateArea.fillColor = COLOR_DAI_WAN_CHENG;
        [self.square addSubview:_stateArea];
    }
    return _stateArea;
}

-(ASTextNode *)detailLabel{
    if (!_detailLabel) {
        _detailLabel = [[ASTextNode alloc]init];
        _detailLabel.layerBacked = YES;
        [self.square.layer addSublayer:_detailLabel.layer];
    }
    return _detailLabel;
}

-(UIArrowView *)rightArrow{
    if (!_rightArrow) {
        _rightArrow = [[UIArrowView alloc]init];
        _rightArrow.direction = ArrowDirectRight;
        _rightArrow.lineColor = COLOR_LINE;
        _rightArrow.lineThinkness = 2;
        _rightArrow.size = CGSizeMake(8 , 14);
        [self.square addSubview:_rightArrow];
    }
    return _rightArrow;
}

//-(void)clickPageButton{
//    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_ORDER_PAGE_CHANGE object:@(self.itemIndex)];
//}

-(void)layoutSubviews{
    
    CGFloat leftpadding = 5;
    
    CGFloat sectionWidth = self.bounds.size.width;
    CGFloat sectionHeight = self.bounds.size.height;
    
    self.square.frame = CGRectMake(0,0, sectionWidth, sectionHeight);
    self.bottomLine.frame = CGRectMake(leftpadding, sectionHeight - LINE_WIDTH, sectionWidth - leftpadding * 2, LINE_WIDTH);
    CGFloat topHeight = ORDER_VIEW_SECTION_HEIGHT * 2 / 3;
    [self initTopArea:leftpadding topWidth:sectionWidth topHeight:topHeight];
    
    CGFloat bottomHeight = sectionHeight - topHeight;
    [self initBottomArea:leftpadding bottomY:topHeight bottomWidth:sectionWidth bottomHeight:bottomHeight];
    
    [self initRightArea:leftpadding sectionWidth:sectionWidth];
}

-(void)initTopArea:(CGFloat)leftpadding topWidth:(CGFloat)topWidth topHeight:(CGFloat)topHeight{
    ShipmentTaskBean* taskBean = (ShipmentTaskBean*)self.data;
    
    NSString* iconName = ICON_DING_DAN;
    
    NSString* content = taskBean.orderBaseCode;
    NSString* customer = ConcatStrings(@"客户单号",taskBean.customCode);
    
    self.iconText.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:24 content:iconName];
    CGSize iconSize = [self.iconText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconText.frame = (CGRect){ CGPointMake(leftpadding,(topHeight - iconSize.height) / 2. + 2),iconSize};
    
    self.title.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:content];
    CGSize titleSize = [self.title measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.title.frame = (CGRect){CGPointMake(self.iconText.frame.origin.x + self.iconText.frame.size.width + 3, topHeight / 2. - 15),titleSize};
    
    self.desLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColor] size:12 content:customer];
    CGSize desSize = [self.desLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.desLabel.frame = (CGRect){CGPointMake(self.iconText.frame.origin.x + self.iconText.frame.size.width + 3, topHeight / 2.),desSize};
    
    __weak __typeof(self) weakSelf = self;
    if (self.statusHandler) {
        [self.statusHandler dispose];
    }
    self.statusHandler = [[taskBean rac_valuesForKeyPath:@"status" observer:nil] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        BOOL isComplete = [taskBean hasReport];
        UIColor* iconColor;
        if(isComplete){
            iconColor = COLOR_YI_WAN_CHENG;
        }else{
            iconColor = COLOR_DAI_WAN_CHENG;
        }
        strongSelf.stateArea.frame = CGRectMake(CGRectGetMaxX(self.title.frame) + leftpadding, 0, 50, 20);
        strongSelf.stateArea.centerY = topHeight / 2.;
        strongSelf.stateArea.titleColor = strongSelf.stateArea.strokeColor = iconColor;
        strongSelf.stateArea.title = isComplete ? @"已上报":@"未上报";
        
        strongSelf.iconText.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:24 content:iconName];
    }];
    
    
}

-(void)initBottomArea:(CGFloat)leftpadding bottomY:(CGFloat)bottomY bottomWidth:(CGFloat)bottomWidth bottomHeight:(CGFloat)bottomHeight{
    ShipmentTaskBean* taskBean = (ShipmentTaskBean*)self.data;
    
//    int actualCount = 0;
//    for (ShipmentActivityShipUnitBean* shipunitBean in taskBean.shipUnits) {
//        actualCount += shipunitBean.pacakageUnitCount;
//    }
    __weak __typeof(self) weakSelf = self;
    [[taskBean rac_valuesForKeyPath:@"actualPackageCount" observer:nil] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.shipUintTotalLabel.attributedString = [strongSelf generateShipUnitString:12 color:FlatOrange activityTypeLabel:[Config getActivityTypeName:taskBean.activityDefinitionCode] expectedCount:[taskBean.expectedPackageCount integerValue] actualCount:taskBean.actualPackageCount];
        strongSelf.shipUintTotalLabel.size = [strongSelf.shipUintTotalLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        strongSelf.shipUintTotalLabel.y = bottomY;
        strongSelf.shipUintTotalLabel.x = leftpadding;
    }];
    
}

-(NSAttributedString *)generateShipUnitString:(CGFloat)size color:(UIColor*)color activityTypeLabel:(NSString*)activityTypeLabel expectedCount:(NSInteger)expectedCount actualCount:(NSInteger)actualCount{
    const NSString* gapString = @" ";
    const NSString* expecteTailString = @" 箱 | ";
    NSString* expectedString = NULL;
    NSString* expectedTag = NULL;
    if (expectedCount) {
        expectedTag = ConcatStrings(@"预计",activityTypeLabel,gapString);
        expectedString = ConcatStrings(expectedTag,@(expectedCount),expecteTailString);
    }
    NSString* actualString = NULL;
    NSString* actualTag = NULL;
    if (actualCount) {
        actualTag = ConcatStrings(@"实际",activityTypeLabel,gapString);
        actualString = ConcatStrings(actualTag,@(actualCount),@" 箱");
    }
    NSString* context = ConcatStrings(expectedString ? expectedString : @"", actualString ? actualString : @"");
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc]initWithString:context];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(0, context.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:FlatGray range:NSMakeRange(0, context.length)];
    NSUInteger loc = 0;
    if (expectedCount) {
        loc += expectedTag.length;
        NSUInteger pickupLength = [NSString stringWithFormat:@"%li", (long)expectedCount].length;
        [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(loc, pickupLength)];
        loc += pickupLength + expecteTailString.length;
    }
    if (actualCount) {
        loc += actualTag.length;
        NSUInteger deliverLength = [NSString stringWithFormat:@"%li", (long)actualCount].length;
        [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(loc, deliverLength)];
    }
    return attrString;
}

-(void)initRightArea:(CGFloat)rightpadding sectionWidth:(CGFloat)sectionWidth{
    if(self.itemCount > 1){//改成点击进入item详情页
        
        self.rightArrow.x = sectionWidth - self.rightArrow.width - rightpadding;
        self.rightArrow.centerY = self.square.centerY;
        self.rightArrow.hidden = NO;
        
        self.detailLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatOrange size:14 content:@"详情"];
        self.detailLabel.size = [self.detailLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        self.detailLabel.maxX = self.rightArrow.x - rightpadding;
        self.detailLabel.centerY = self.rightArrow.centerY;
        self.detailLabel.hidden = NO;
        
        self.square.userInteractionEnabled = YES;//可以点击
        [self.square addTarget:self action:@selector(clickOrderSquare) forControlEvents:UIControlEventTouchUpInside];
        
        //        CGFloat buttonWidth = 65;
        //        CGFloat buttonHeight = 30;
        //        self.pageButton.frame = CGRectMake(sectionWidth - leftpadding - buttonWidth, (sectionHeight - buttonHeight) / 2., buttonWidth,buttonHeight);
        //        self.pageButton.fillColor = COLOR_ACCENT;// iconColor;
        //        if (self.isLast) {
        //            self.pageButton.title = @"回顶部";
        //        }else{
        //            self.pageButton.title = @"下一个";
        //        }
    }else{
        self.square.userInteractionEnabled = NO;
        self.rightArrow.hidden = YES;
        self.detailLabel.hidden = YES;
    }
}

-(void)clickOrderSquare{
    OrderDetailController* detailController = [[OrderDetailController alloc]init];
    detailController.taskBean = self.data;
    [[OwnerViewController sharedInstance]pushViewController:detailController animated:YES];
}


@end
