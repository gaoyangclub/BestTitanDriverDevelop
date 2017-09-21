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
    ShipmentTaskBean* taskBean = (ShipmentTaskBean*)self.data;
//    if(!hvo){
//        return;
//    }
    BOOL isComplete = [taskBean hasReport];
    
    CGFloat leftpadding = 5;
    
    CGFloat sectionWidth = self.bounds.size.width;
    CGFloat sectionHeight = self.bounds.size.height;
    
    UIColor* iconColor;
    if(isComplete){
        iconColor = COLOR_YI_WAN_CHENG;
    }else{
        iconColor = COLOR_DAI_WAN_CHENG;
    }
    NSString* iconName = ICON_DING_DAN;
    
    NSString* content = taskBean.orderBaseCode;
    NSString* customer = ConcatStrings(@"客户单号",taskBean.customCode);
    
    self.square.frame = CGRectMake(0,0, sectionWidth, sectionHeight);
    
    self.bottomLine.frame = CGRectMake(leftpadding, sectionHeight - LINE_WIDTH, sectionWidth - leftpadding * 2, LINE_WIDTH);
    
    self.iconText.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:24 content:iconName];
    CGSize iconSize = [self.iconText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconText.frame = (CGRect){ CGPointMake(leftpadding,(sectionHeight - iconSize.height) / 2. + 2),iconSize};
    
    self.title.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:content];
    CGSize titleSize = [self.title measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.title.frame = (CGRect){CGPointMake(self.iconText.frame.origin.x + self.iconText.frame.size.width + 3, sectionHeight / 2. - 15),titleSize};
    
    self.desLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColor] size:12 content:customer];
    CGSize desSize = [self.desLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.desLabel.frame = (CGRect){CGPointMake(self.iconText.frame.origin.x + self.iconText.frame.size.width + 3, sectionHeight / 2.),desSize};
    
    self.stateArea.frame = CGRectMake(CGRectGetMaxX(self.title.frame) + leftpadding, 0, 50, 20);
    self.stateArea.centerY = sectionHeight / 2.;
    self.stateArea.titleColor = self.stateArea.strokeColor = iconColor;
    self.stateArea.title = isComplete ? @"已上报":@"未上报";
    
    if(self.itemCount > 1){//改成点击进入item详情页
        
        self.rightArrow.x = sectionWidth - self.rightArrow.width - leftpadding;
        self.rightArrow.centerY = self.stateArea.centerY;
        self.rightArrow.hidden = NO;
        
        self.detailLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatOrange size:14 content:@"详情"];
        self.detailLabel.size = [self.detailLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        self.detailLabel.maxX = self.rightArrow.x - leftpadding;
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
