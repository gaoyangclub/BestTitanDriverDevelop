//
//  TaskViewCell.m
//  BestDriverTitan
//
//  Created by admin on 17/1/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskViewCell.h"
#import "UIArrowView.h"
#import "RoundRectNode.h"
#import "DiyLicensePlateNode.h"
#import "CircleNode.h"
#import "AppDelegate.h"
#import "UICreationUtils.h"
#import "FollowAnimateManager.h"
#import "FlatButton.h"

@interface RoundBackView:UIView

@property (nonatomic,retain) RoundRectNode* backNode;

@end

@implementation RoundBackView
@end


@interface TaskViewCell(){
//    BOOL isComplete;
    UIControl* btnTest;
}

@property (nonatomic,retain) RoundBackView* normalBackView;
@property (nonatomic,retain) RoundBackView* selectBackView;

@property (nonatomic,retain) ASDisplayNode* backNode;

@property (nonatomic,retain) ASTextNode* codeText;//运单号
@property (nonatomic,retain) FlatButton* stateArea;//未完成
//@property (nonatomic,retain) ASTextNode* stateText;//未完成

@property (nonatomic,retain) ASTextNode* licencePlateText;//车牌号
@property (nonatomic,retain) DiyLicensePlateNode* licencePlateView;//车牌背景图
@property (nonatomic,retain) ASTextNode* shipUintCountText;//货量
@property (nonatomic,retain) ASTextNode* shipUintCountLabel;//货量label
@property (nonatomic,retain) ASTextNode* soCountText;//so个数
@property (nonatomic,retain) ASTextNode* soCountLabel;//so个数label

@property (nonatomic,retain) UIArrowView* rightArrow;
@property (nonatomic,retain) ASDisplayNode* lineTopY;
@property (nonatomic,retain) ASDisplayNode* lineBottomY;
@property (nonatomic,retain) ASDisplayNode* lineCenterX;

@property (nonatomic,retain) ASDisplayNode* lineFollowX;

@property (nonatomic,retain) ASTextNode* orderCountIcon;//订单icon
@property (nonatomic,retain) ASTextNode* orderCountNode;//订单数
@property (nonatomic,retain) ASTextNode* costHourText;//配送时间花费
@property (nonatomic,retain) ASTextNode* distanceText;//配送里程花费
@property (nonatomic,retain) ASTextNode* expenseText;//参考运费
@property (nonatomic,retain) ASTextNode* costHourLabel;//配送时间花费
@property (nonatomic,retain) ASTextNode* distanceLabel;//配送里程花费
@property (nonatomic,retain) ASTextNode* expenseLabel;//参考运费

@property (nonatomic,retain) ASDisplayNode* buttonArea;//底部状态栏部分

@property (nonatomic,retain) CircleNode* circleArea;

@property (nonatomic,retain) UIControl* followButton;//关注
@property (nonatomic,retain) ASTextNode* followIcon;
//@property (nonatomic,retain) ASTextNode* followLabel;

@property (nonatomic,retain) UIControl* planButton;//规划站点
@property (nonatomic,retain) ASTextNode* planIcon;

@property (nonatomic,retain) ASTextNode* iconStart;//起点图标
@property (nonatomic,retain) ASTextNode* iconEnd;//终点图标
@property (nonatomic,retain) ASTextNode* textStart;//起点文字
@property (nonatomic,retain) ASTextNode* textEnd;//终点文字


@end


@implementation TaskViewCell

-(RoundBackView *)normalBackView{
    if (!_normalBackView) {
        _normalBackView = [[RoundBackView alloc]init];
//        _normalBackView.backgroundColor = [UIColor blueColor];
//        [self.contentView addSubview:_normalBackView];
        
        RoundRectNode* back = _normalBackView.backNode = [[RoundRectNode alloc]init];
        back.fillColor = [UIColor whiteColor];
        back.cornerRadius = 0;//5;
        back.layerBacked = YES;
        [_normalBackView.layer addSublayer:back.layer];
    }
    return _normalBackView;
}

-(RoundBackView *)selectBackView{
    if (!_selectBackView) {
        _selectBackView = [[RoundBackView alloc]init];
//        _selectBackView.backgroundColor = [UIColor grayColor];
//        [self.contentView addSubview:_selectBackView];
        
        RoundRectNode* back = _selectBackView.backNode = [[RoundRectNode alloc]init];
        back.fillColor = FlatWhite;
        back.cornerRadius = 0;//5;
        back.layerBacked = YES;
        [_selectBackView.layer addSublayer:back.layer];
    }
    return _selectBackView;
}

-(ASTextNode *)orderCountNode{
    if (!_orderCountNode) {
        _orderCountNode = [[ASTextNode alloc]init];
        _orderCountNode.layerBacked = YES;
        [self.backNode addSubnode:_orderCountNode];
    }
    return _orderCountNode;
}

-(ASTextNode *)orderCountIcon{
    if (!_orderCountIcon) {
        _orderCountIcon = [[ASTextNode alloc]init];
        _orderCountIcon.layerBacked = YES;
        [self.backNode addSubnode:_orderCountIcon];
    }
    return _orderCountIcon;
}

-(ASTextNode *)expenseLabel{
    if(!_expenseLabel){
        _expenseLabel = [[ASTextNode alloc]init];
        _expenseLabel.layerBacked = YES;
        [self.backNode addSubnode:_expenseLabel];
    }
    return _expenseLabel;
}

-(ASTextNode *)expenseText{
    if(!_expenseText){
        _expenseText = [[ASTextNode alloc]init];
        _expenseText.layerBacked = YES;
        [self.backNode addSubnode:_expenseText];
    }
    return _expenseText;
}

-(ASTextNode *)distanceLabel{
    if(!_distanceLabel){
        _distanceLabel = [[ASTextNode alloc]init];
        _distanceLabel.layerBacked = YES;
        [self.backNode addSubnode:_distanceLabel];
    }
    return _distanceLabel;
}

-(ASTextNode *)distanceText{
    if(!_distanceText){
        _distanceText = [[ASTextNode alloc]init];
        _distanceText.layerBacked = YES;
        [self.backNode addSubnode:_distanceText];
    }
    return _distanceText;
}

-(ASTextNode *)costHourLabel{
    if(!_costHourLabel){
        _costHourLabel = [[ASTextNode alloc]init];
        _costHourLabel.layerBacked = YES;
        [self.backNode addSubnode:_costHourLabel];
    }
    return _costHourLabel;
}

-(ASTextNode *)costHourText{
    if(!_costHourText){
        _costHourText = [[ASTextNode alloc]init];
        _costHourText.layerBacked = YES;
        [self.backNode addSubnode:_costHourText];
    }
    return _costHourText;
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

-(DiyLicensePlateNode *)licencePlateView{
    if(!_licencePlateView){
        _licencePlateView = [[DiyLicensePlateNode alloc]init];
        _licencePlateView.layerBacked = YES;
        _licencePlateView.fillColor = FlatWhite;//COLOR_LINE;
        _licencePlateView.compleColor = [UIColor clearColor];
        [self.contentView.layer addSublayer:_licencePlateView.layer];
    }
    return _licencePlateView;
}

-(CircleNode *)circleArea{
    if (!_circleArea) {
        _circleArea = [[CircleNode alloc]init];
        _circleArea.layerBacked = YES;
        _circleArea.fillColor = [UIColor clearColor];
        _circleArea.strokeWidth = 4;
        [self.backNode addSubnode:_circleArea];
    }
    return _circleArea;
}

//定义UI结构 利用AsyncDisplayKit的工具布局

-(ASDisplayNode *)lineTopY{
    if(!_lineTopY){
        _lineTopY = [[ASDisplayNode alloc]init];
        _lineTopY.backgroundColor = COLOR_LINE;
        _lineTopY.layerBacked = YES;
        [self.backNode addSubnode:_lineTopY];
    }
    return _lineTopY;
}

-(ASDisplayNode *)lineBottomY{
    if(!_lineBottomY){
        _lineBottomY = [[ASDisplayNode alloc]init];
        _lineBottomY.backgroundColor = COLOR_LINE;
        _lineBottomY.layerBacked = YES;
        [self.backNode addSubnode:_lineBottomY];
    }
    return _lineBottomY;
}

-(ASDisplayNode *)lineCenterX{
    if(!_lineCenterX){
        _lineCenterX = [[ASDisplayNode alloc]init];
        _lineCenterX.backgroundColor = COLOR_LINE;
        _lineCenterX.layerBacked = YES;
        [self.backNode addSubnode:_lineCenterX];
    }
    return _lineCenterX;
}

-(ASDisplayNode *)lineFollowX{
    if(!_lineFollowX){
        _lineFollowX = [[ASDisplayNode alloc]init];
        _lineFollowX.backgroundColor = COLOR_LINE;
        _lineFollowX.layerBacked = YES;
        [self.backNode addSubnode:_lineFollowX];
    }
    return _lineFollowX;
}

-(UIArrowView *)rightArrow{
    if(!_rightArrow){
        _rightArrow = [[UIArrowView alloc]initWithFrame:CGRectMake(0, 0, 8, 16)];
        _rightArrow.direction = ArrowDirectRight;
        _rightArrow.lineColor = COLOR_LINE;
        _rightArrow.lineThinkness = 2;
        [self.contentView addSubview:_rightArrow];
    }
    return _rightArrow;
}

-(ASTextNode *)soCountText{
    if(!_soCountText){
        _soCountText = [[ASTextNode alloc]init];
        _soCountText.layerBacked = YES;
        [self.backNode addSubnode:_soCountText];
    }
    return _soCountText;
}

-(ASTextNode *)soCountLabel{
    if(!_soCountLabel){
        _soCountLabel = [[ASTextNode alloc]init];
        _soCountLabel.layerBacked = YES;
        [self.backNode addSubnode:_soCountLabel];
    }
    return _soCountLabel;
}

-(ASTextNode *)codeText{
    if(!_codeText){
        _codeText = [[ASTextNode alloc]init];
        _codeText.layerBacked = YES;
//                _codeText.textColor = [UIColor whiteColor];
        //        _titleView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
        //        _titleView.textAlignment = NSTextAlignmentCenter;
        [self.backNode addSubnode:_codeText];
    }
    return _codeText;
}

//-(RoundRectNode *)stateArea{
//    if (!_stateArea) {
//        _stateArea = [[RoundRectNode alloc]init];
//        _stateArea.layerBacked = YES;
//        _stateArea.cornerRadius = 3;
//        _stateArea.fillColor = COLOR_DAI_WAN_CHENG;
//        [self.backNode addSubnode:_stateArea];
//    }
//    return _stateArea;
//}

-(FlatButton *)stateArea{
    if (!_stateArea) {
        _stateArea = [[FlatButton alloc]init];
        _stateArea.userInteractionEnabled = NO;
        _stateArea.cornerRadius = 3;
        _stateArea.fillColor = [UIColor whiteColor];
        _stateArea.strokeWidth = 1;
        //        _stateArea.fillColor = COLOR_DAI_WAN_CHENG;
        [self.contentView addSubview:_stateArea];
    }
    return _stateArea;
}

//-(ASTextNode *)stateText{
//    if(!_stateText){
//        _stateText = [[ASTextNode alloc]init];
//        _stateText.layerBacked = YES;
//        [self.stateArea addSubnode:_stateText];
//    }
//    return _stateText;
//}

-(ASTextNode *)shipUintCountText{
    if(!_shipUintCountText){
        _shipUintCountText = [[ASTextNode alloc]init];
        _shipUintCountText.layerBacked = YES;
        [self.backNode addSubnode:_shipUintCountText];
    }
    return _shipUintCountText;
}

-(ASTextNode *)shipUintCountLabel{
    if(!_shipUintCountLabel){
        _shipUintCountLabel = [[ASTextNode alloc]init];
        _shipUintCountLabel.layerBacked = YES;
        [self.backNode addSubnode:_shipUintCountLabel];
    }
    return _shipUintCountLabel;
}

-(ASTextNode *)licencePlateText{
    if(!_licencePlateText){
        _licencePlateText = [[ASTextNode alloc]init];
        _licencePlateText.layerBacked = YES;
//        [self.contentView.layer addSublayer:_licencePlateText.layer];
        [self.licencePlateView addSubnode:_licencePlateText];
    }
    return _licencePlateText;
}

-(ASDisplayNode *)buttonArea{
    if (!_buttonArea) {
        _buttonArea = [[ASDisplayNode alloc]init];
        _buttonArea.layerBacked = YES;
        [self.backNode addSubnode:_buttonArea];
    }
    return _buttonArea;
}

-(ASTextNode *)iconStart{
    if (!_iconStart) {
        _iconStart = [[ASTextNode alloc]init];
        _iconStart.layerBacked = YES;
        [self.buttonArea addSubnode:_iconStart];
    }
    return _iconStart;
}

-(ASTextNode *)iconEnd{
    if (!_iconEnd) {
        _iconEnd = [[ASTextNode alloc]init];
        _iconEnd.layerBacked = YES;
        [self.buttonArea addSubnode:_iconEnd];
    }
    return _iconEnd;
}

-(ASTextNode *)textStart{
    if (!_textStart) {
        _textStart = [[ASTextNode alloc]init];
        _textStart.maximumNumberOfLines = 2;
        _textStart.truncationMode = NSLineBreakByTruncatingTail;
        _textStart.layerBacked = YES;
        [self.buttonArea addSubnode:_textStart];
    }
    return _textStart;
}

-(ASTextNode *)textEnd{
    if (!_textEnd) {
        _textEnd = [[ASTextNode alloc]init];
        _textEnd.maximumNumberOfLines = 2;
        _textEnd.truncationMode = NSLineBreakByTruncatingTail;
        _textEnd.layerBacked = YES;
        [self.buttonArea addSubnode:_textEnd];
    }
    return _textEnd;
}

-(UIControl *)followButton{
    if (!_followButton) {
        _followButton = [[UIControl alloc]init];
//        _followButton.backgroundColor = FlatBrownDark;
        [_followButton setShowTouch:YES];
        [self.contentView addSubview:_followButton];
        [_followButton addTarget:self action:@selector(followClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _followButton;
}

-(ASTextNode *)followIcon{
    if (!_followIcon) {
        _followIcon = [[ASTextNode alloc]init];
        _followIcon.layerBacked = YES;
        [self.followButton.layer addSublayer:_followIcon.layer];
    }
    return _followIcon;
}

-(UIControl *)planButton{
    if (!_planButton) {
        _planButton = [[UIControl alloc]init];
//        _planButton.backgroundColor = FlatBrownDark;
        [_planButton setShowTouch:YES];
        [self.contentView addSubview:_planButton];
        [_planButton addTarget:self action:@selector(planClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _planButton;
}

-(ASTextNode *)planIcon{
    if (!_planIcon) {
        _planIcon = [[ASTextNode alloc]init];
        _planIcon.layerBacked = YES;
        [self.planButton.layer addSublayer:_planIcon.layer];
    }
    return _planIcon;
}

//-(ASTextNode *)followLabel{
//    if (!_followLabel) {
//        _followLabel = [[ASTextNode alloc]init];
//        _followLabel.layerBacked = YES;
//        [self.followButton.layer addSublayer:_followLabel.layer];
//    }
//    return _followLabel;
//}

-(void)initTopArea:(CGFloat)topY topWidth:(CGFloat)topWidth topHeight:(CGFloat)topHeight{
//    CGFloat topCenterY = topY + topHeight / 2.;
//    CGFloat labelOffset = -20;
//    CGFloat textOffset = 0;
    
//    CGFloat followWidth = 40;
    
    CGFloat marginLeft = 0;//followWidth / 2.;
    
    CGFloat areaWith = (topWidth - marginLeft) / 4.;
    
//    self.followButton.frame = CGRectMake(0, topY + (topHeight - followWidth) / 2., followWidth, followWidth);
//    [self showFollowArea];
    
    UIColor* iconColor = FlatGray;//[UIColor flatGrayColorDark];
    
    CGFloat areaX0 = marginLeft;
    
    self.orderCountIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:16 content:ICON_DING_DAN];
    self.orderCountIcon.size = [self.orderCountIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.orderCountNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatOrange size:14 content:@"15个"];
    self.orderCountNode.size = [self.orderCountNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];//CGSize orderCountSize =
    
    self.orderCountIcon.x = areaX0 + (areaWith - self.orderCountIcon.width - self.orderCountNode.width) / 2;
    self.orderCountNode.x = self.orderCountIcon.maxX;
    self.orderCountNode.centerY = self.orderCountIcon.centerY = topY + topHeight / 2.;
    
    CGFloat areaX1 = areaX0 + areaWith;
    
    self.expenseLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:16 content:ICON_JIN_QIAN];
    CGSize expenseLabelSize = [self.expenseLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.expenseText.attributedString = [NSString simpleAttributedString:[UIColor flatOrangeColor] size:14 content:@"15元"];
    CGSize expenseTextSize = [self.expenseText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    CGFloat expenseX = areaX1 + (areaWith - expenseLabelSize.width - expenseTextSize.width) / 2;
    
    self.expenseLabel.frame = (CGRect){
        CGPointMake(expenseX, topY + (topHeight - expenseLabelSize.height) / 2.),expenseLabelSize
    };
    self.expenseText.frame = (CGRect){
        CGPointMake(expenseX + expenseLabelSize.width, topY + (topHeight - expenseTextSize.height) / 2.),expenseTextSize
    };
    
    CGFloat areaX2 = areaX1 + areaWith;
    self.distanceLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:16 content:ICON_JU_LI];
    CGSize distanceLabelSize = [self.distanceLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.distanceText.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:@"1.7公里"];
    CGSize distanceTextSize = [self.distanceText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    CGFloat distanceX = areaX2 + (areaWith - distanceLabelSize.width - distanceTextSize.width) / 2;
    
    self.distanceLabel.frame = (CGRect){
        CGPointMake(distanceX, topY + (topHeight - distanceLabelSize.height) / 2.),distanceLabelSize
    };
    self.distanceText.frame = (CGRect){
        CGPointMake(distanceX + distanceLabelSize.width, topY + (topHeight - distanceTextSize.height) / 2.),distanceTextSize
    };
    
    CGFloat areaX3 = areaX2 + areaWith;
    self.costHourLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:16 content:ICON_SHI_JIAN];
    CGSize hourLabelSize = [self.costHourLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.costHourText.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:@"2.5小时"];
    CGSize hourTextSize = [self.costHourText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    CGFloat hourX = areaX3 + (areaWith - hourLabelSize.width - hourTextSize.width) / 2;
    
    self.costHourLabel.frame = (CGRect){
        CGPointMake(hourX, topY + (topHeight - hourLabelSize.height) / 2.),hourLabelSize
    };
    self.costHourText.frame = (CGRect){
        CGPointMake(hourX + hourLabelSize.width, topY + (topHeight - hourTextSize.height) / 2.),hourTextSize
    };
}

-(void)initCenterArea:(CGFloat)centerY centerWidth:(CGFloat)centerWidth centerHeight:(CGFloat)centerHeight{
    CGFloat topCenterY = centerY + centerHeight / 2.;
    CGFloat areaWith = centerWidth / 2.;
    CGFloat labelOffset = 10;
    CGFloat textOffset = -30;
    
    CGFloat areaX1 = 0;
    
    ShipmentBean* bean = self.data;
    
    UIColor* iconColor;
    if (bean.isComplete) {
        //    if (self.indexPath.row % 2 == 0) {
        iconColor = COLOR_YI_WAN_CHENG;
    }else{
        iconColor = COLOR_DAI_WAN_CHENG;
    }
    
    self.soCountText.attributedString = [NSString simpleAttributedString:iconColor size:30 content:@"8"];
    CGSize soSize = [self.soCountText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.soCountText.frame = (CGRect){
        CGPointMake(areaX1 + (areaWith - soSize.width) / 2., topCenterY + textOffset),soSize
    };
    self.soCountLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColorDark] size:12 content:@"订单个数"];
    soSize = [self.soCountLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.soCountLabel.frame = (CGRect){
        CGPointMake(areaX1 + (areaWith - soSize.width) / 2., topCenterY + labelOffset),soSize
    };
    
    int pickupCount = bean.pickupCount; //生成0-15范围的随机数
    int deliverCount = bean.deliverCount; //生成0-15范围的随机数
    
    CGFloat areaX2 = areaWith;
    self.shipUintCountText.attributedString = [self generateShipUnitString:iconColor pickupCount:pickupCount deliverCount:deliverCount];
    //[NSString simpleAttributedString:iconColor size:30 context:@"提50送50"];
    CGSize shipSize = [self.shipUintCountText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.shipUintCountText.frame = (CGRect){
        CGPointMake(areaX2 + (areaWith - shipSize.width) / 2., topCenterY + textOffset),shipSize
    };
    self.shipUintCountLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColorDark] size:12 content:@"货量(箱)"];
    shipSize = [self.shipUintCountLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.shipUintCountLabel.frame = (CGRect){
        CGPointMake(areaX2 + (areaWith - shipSize.width) / 2., topCenterY + labelOffset),shipSize
    };
    
    self.circleArea.strokeColor = iconColor;
    self.circleArea.frame = CGRectMake(0, centerY + 5, areaWith, centerHeight - 10);
    
//    CircleNode* circle2 = [[CircleNode alloc]init];
//    circle2.layerBacked = YES;
//    circle2.fillColor = [UIColor clearColor];
//    circle2.strokeColor = iconColor;
//    circle2.strokeWidth = 4;
//    [self.backView addSubnode:circle2];
//    circle2.frame = CGRectMake(areaX2, centerY + 5, areaWith, centerHeight - 10);
}


-(NSAttributedString *)generateShipUnitString:(UIColor*)color pickupCount:(int)pickupCount deliverCount:(int)deliverCount{
    NSString* pickupString = NULL;
    if (pickupCount) {
        pickupString = ConcatStrings(@"提 ",[NSNumber numberWithInt:pickupCount],@" ");
    }
    NSString* deliverString = NULL;
    if (deliverCount) {
        deliverString = ConcatStrings(@"送 ",[NSNumber numberWithInt:deliverCount]);
    }
    NSString* context = ConcatStrings(pickupString ? pickupString : @"", deliverString ? deliverString : @"");
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc]initWithString:context];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, context.length)];
    NSUInteger loc = 0;
    if (pickupCount) {
        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(loc, 2)];
        loc += 2;
        NSUInteger pickupLength = [NSString stringWithFormat:@"%i", pickupCount].length;
        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(loc, pickupLength)];
        loc += pickupLength + 1;
    }
    if (deliverCount) {
        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(loc, 2)];
        loc += 2;
        NSUInteger deliverLength = [NSString stringWithFormat:@"%i", deliverCount].length;
        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(loc, deliverLength)];
//        loc += deliverLength;
    }
    return attrString;
}

-(void)planClick:(UIControl*)sender{
    [PopAnimateManager startClickAnimation:sender];
}

-(void)followClick:(UIControl*)sender{
    ShipmentBean* bean = self.data;
    bean.isFollow = !bean.isFollow;
    [self showFollowArea];
    
    [PopAnimateManager startClickAnimation:sender];
    
    if(bean.isFollow){
        
        UIViewController* rootViewController = ((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
        
        CGRect btnToSelf = [self.followButton convertRect:self.followIcon.frame toView:rootViewController.view];
        
        [[FollowAnimateManager sharedInstance] startAnimate:btnToSelf];
        
        
        //frame变化
//        POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
//        spring.toValue = [NSValue valueWithCGRect:CGRectMake(230, 40, 80, 40)];
//        
//        //设置振幅
//        spring.springBounciness = 20;
//        //振幅速度
//        spring.springSpeed = 20;

//        [iconTag pop_addAnimation:spring forKey:@"spring"];
        
    }
}


-(void)showFollowArea{
    
    ShipmentBean* bean = self.data;
    
    CGFloat areaHeight = CGRectGetHeight(self.followButton.bounds);
    
    if (bean.isFollow) {
        self.followIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatOrange  size:24 content:ICON_STAR];
//        self.followLabel.attributedString = [NSString simpleAttributedString:FlatOrange  size:12 content:@"收  藏"];
    }else{
        self.followIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor]  size:24 content:ICON_STAR];
//        self.followLabel.attributedString = [NSString simpleAttri÷butedString:[UIColor flatGrayColor]  size:12 content:@"收  藏"];
    }
    
    CGSize iconSize = [self.followIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    CGSize labelSize = [self.followLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    CGFloat iconGap = 0;
//    CGFloat iconY = (areaHeight - (iconSize.height + iconGap + labelSize.height)) / 2;
    
    self.followIcon.frame = (CGRect){CGPointMake((areaHeight - iconSize.width) / 2., (areaHeight - iconSize.height) / 2.),iconSize};
    
//    self.followLabel.frame = (CGRect){CGPointMake((areaHeight - labelSize.width) / 2, iconY + iconSize.height + iconGap),labelSize};
    
//    CGRect followFrame = self.followButton.frame;
//    followFrame.size.width = labelX + labelSize.width;
//    followFrame.origin.x = self.backNode.frame.origin.x + self.backNode.frame.size.width - followFrame.size.width - 5;
//    self.followButton.frame = followFrame;
}


-(void)showPlanArea{
    CGFloat areaHeight = CGRectGetHeight(self.planButton.bounds);
    CGFloat areaWidth = CGRectGetWidth(self.planButton.bounds);
    self.planIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_PRIMARY  size:36 content:ICON_DAO_HANG];
    CGSize iconSize = [self.planIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.planIcon.frame = (CGRect){CGPointMake((areaWidth - iconSize.width) / 2., (areaHeight - iconSize.height) / 2.),iconSize};
}


-(void)initBottomArea:(CGFloat)bottomY bottomWidth:(CGFloat)bottomWidth bottomHeight:(CGFloat)bottomHeight{
    
    CGFloat planButtonWidth = 10;//bottomHeight - ;
//    self.planButton.frame = CGRectMake(bottomWidth - planButtonWidth, bottomY , planButtonWidth, bottomHeight);
//    [self showPlanArea];
    
//    ShipmentBean* bean = self.data;
    
    self.buttonArea.frame = CGRectMake(0, bottomY, bottomWidth, bottomHeight);
    
    CGFloat baseX = self.orderCountIcon.x;
//    CGFloat leftpadding = 10;
    CGFloat iconGap = 5;
    
    self.iconStart.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatGreenDark size:16 content:ICON_NODE];
    CGSize iconStartSize = [self.iconStart measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconStart.frame = (CGRect){ CGPointMake(baseX,0 + (bottomHeight / 2. - iconStartSize.height) / 2.),iconStartSize};
    
    NSString* address = @"大港镇松镇公路1339号宝湾物流112号库";
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:address];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, address.length)];
    
    self.textStart.attributedString = textString;
    CGFloat maxStartWidth = bottomWidth - baseX - iconStartSize.width - iconGap - planButtonWidth;
    
    CGSize textStartSize = [self.textStart measure:CGSizeMake(maxStartWidth, FLT_MAX)];
    self.textStart.frame = (CGRect){ CGPointMake(self.iconStart.maxX + iconGap,0 + (bottomHeight / 2. - textStartSize.height) / 2.),textStartSize};
    
    self.iconEnd.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatOrange size:16 content:ICON_NODE];
    CGSize iconEndSize = [self.iconEnd measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconEnd.frame = (CGRect){ CGPointMake(baseX,bottomHeight / 2. + (bottomHeight / 2. - iconStartSize.height) / 2.),iconEndSize};
    
    NSString* address2 = @"青浦工业园区新团路518号（二期）";
    NSMutableAttributedString* textString2 = (NSMutableAttributedString*)[NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:address2];
//    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
//    style.alignment = NSTextAlignmentLeft;
    [textString2 addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, address2.length)];
    
    self.textEnd.attributedString = textString2;
    maxStartWidth = bottomWidth - baseX - iconEndSize.width - iconGap - planButtonWidth;
    
    CGSize textEndSize = [self.textEnd measure:CGSizeMake(maxStartWidth, FLT_MAX)];
    self.textEnd.frame = (CGRect){ CGPointMake(self.iconEnd.maxX + iconGap,bottomHeight / 2. + (bottomHeight / 2. - textEndSize.height) / 2.),textEndSize};
    
//    if (true) {
//        return;
//    }
//    
//    [self.buttonArea removeAllSubNodes];
////    for (ASDisplayNode* subNode in self.buttonArea.subnodes) {//先全部移除干净
////        [subNode removeFromSupernode];
////    }
//    
//    CGFloat baseX = 10;
//    int factor = bean.factor1; //生成0-2范围的随机数
//    if(factor == 0){
//        ASDisplayNode* subNode1 = [self createStateNode:@"货量差异" color:FlatYellow offsetX:baseX bottomHeight:bottomHeight];
//        [self.buttonArea addSubnode:subNode1];
//        baseX += subNode1.frame.size.width + 5;
//    }
//    if (bean.isComplete) {
//        ASDisplayNode* subNode2 = [self createStateNode:@"已完成" color:COLOR_YI_WAN_CHENG offsetX:baseX bottomHeight:bottomHeight];
//        [self.buttonArea addSubnode:subNode2];
//        baseX += subNode2.frame.size.width + 5;
//    }else{
//        int factor = bean.factor2; //生成0-2范围的随机数
//        if (factor > 1) {
//            ASDisplayNode* subNode2 = [self createStateNode:@"待签收" color:COLOR_DAI_WAN_CHENG offsetX:baseX bottomHeight:bottomHeight];
//            [self.buttonArea addSubnode:subNode2];
//            baseX += subNode2.frame.size.width + 5;
//        }else if(factor > 0){
//            ASDisplayNode* subNode2 = [self createStateNode:@"待揽收" color:COLOR_DAI_WAN_CHENG offsetX:baseX bottomHeight:bottomHeight];
//            [self.buttonArea addSubnode:subNode2];
//            baseX += subNode2.frame.size.width + 5;
//        }
//    }
//    factor = bean.factor3; //生成0-2范围的随机数
//    if (factor > 0) {
//        ASDisplayNode* subNode1 = [self createStateNode:@"待收款" color:FlatOrange offsetX:baseX bottomHeight:bottomHeight];
//        [self.buttonArea addSubnode:subNode1];
//    }
    
//    UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
    //    [btn setTitle:@"ceshiahgia" forState:UIControlStateNormal];
    
//    if (!btnTest) {
//        UIControl* btn = self->btnTest = [[UIControl alloc]init];
//        btn.frame = CGRectMake(0, 0, 100, 50);
//        //    btn.userInteractionEnabled = NO;
//        btn.backgroundColor = [UIColor brownColor];
////            btn.opaque = YES;
//        //    btn.alpha = 0.95;
////        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//        [btn setShowTouch:YES];
//        [self.contentView addSubview:btn];
//        
//            ASDisplayNode* btn2 = [[ASDisplayNode alloc]init];
//            btn2.backgroundColor = [UIColor flatSkyBlueColor];
//            btn2.frame = CGRectMake(10, 10, 50, 50);
//        //    btn2.opaque = YES;
//            btn2.layerBacked = YES;
////            btn2.userInteractionEnabled = YES;
////            [btn2 setShowTouch:YES];
////            [btn2 addTarget:self action:@selector(btnClick) forControlEvents:ASControlNodeEventTouchUpInside];
//            [btn.layer addSublayer:btn2.layer];
////            [self.contentView.layer addSublayer:btn2.layer];
//        
//        UIView* aaa = [[UIView alloc]init];
//        aaa.backgroundColor = [UIColor flatYellowColor];
//        aaa.frame = CGRectMake(5, 20, 30, 30);
//        aaa.userInteractionEnabled = false;
//        [btn addSubview:aaa];
//        
//    }
}

-(void)btnClick{
    NSLog(@"测试点击...");
}

-(ASDisplayNode*)createStateNode:(NSString*)content color:(UIColor*)color offsetX:(CGFloat)offsetX bottomHeight:(CGFloat)bottomHeight{
    ASTextNode* textNode = [[ASTextNode alloc]init];
    textNode.attributedString = [NSString simpleAttributedString:color size:12 content:content];
    textNode.layerBacked = YES;
    CGSize textSize = [textNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    CGFloat plateWidth = textSize.width + 10;
    CGFloat plateHeight = textSize.height + 10;
    
    CGFloat offsetY = (bottomHeight - plateHeight) / 2.;
    
    RoundRectNode* roundNode = [[RoundRectNode alloc]init];
    roundNode.frame = CGRectMake(offsetX, offsetY, plateWidth, plateHeight);
    roundNode.layerBacked = YES;
    roundNode.strokeColor = color;
    roundNode.strokeWidth = 1;
    roundNode.fillColor = [UIColor whiteColor];
    roundNode.cornerRadius = 5;
    [roundNode addSubnode:textNode];
    
    textNode.frame = (CGRect){
        CGPointMake((roundNode.frame.size.width - textSize.width) / 2., (roundNode.frame.size.height - textSize.height) / 2.),
        textSize
    };
    
    return roundNode;
}

-(void)showSubviews{
    
//    int count = (arc4random() % 3); //生成0-2范围的随机数
//    isComplete = count > 0;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.normalBackView.frame = self.selectBackView.frame = self.contentView.bounds;
    self.backgroundView = self.normalBackView;
    self.selectedBackgroundView = self.selectBackView;
    
    CGFloat cellHeight = self.contentView.bounds.size.height;
    CGFloat cellWidth = self.contentView.bounds.size.width;
//    CGFloat gap = 1;
    
    CGFloat leftMargin = 0;//10;
//    CGFloat topMargin = 5;
    
    CGFloat backWidth = cellWidth - leftMargin * 2;
    CGFloat backHeight = cellHeight;// - topMargin;// * 2;
    
//    CGFloat padding = 5;//内边距10
    
    CGFloat topHeight = 40;
    CGFloat bottomHeight = 60;
    
    CGFloat topY = 25;
    CGFloat centerY = topY + topHeight;
    
    CGFloat centerHeight = 0;//backHeight - topY - topHeight - bottomHeight;
    
    self.backNode.frame = CGRectMake(leftMargin, 0, backWidth, backHeight);
    
    self.normalBackView.backNode.frame = self.selectBackView.backNode.frame = self.backNode.frame;
    
//    self.lineTopY.frame = CGRectMake(padding, topY + topHeight, backWidth - padding * 2, LINE_WIDTH);
//    self.lineBottomY.frame = CGRectMake(padding, topY + topHeight + centerHeight, backWidth - padding * 2, LINE_WIDTH);
//    if(!self.isLast){
        self.lineBottomY.frame = CGRectMake(0, backHeight - LINE_WIDTH, backWidth, LINE_WIDTH);
//    }
//    self.lineBottomY.hidden = self.isLast;
//    self.lineCenterX.frame = CGRectMake((backWidth - LINE_WIDTH) / 2., centerY + padding, LINE_WIDTH, centerHeight - padding * 2);
    
    CGFloat bottomY = centerY + centerHeight;
    
//    self.lineFollowX.frame = CGRectMake(backWidth - bottomHeight - LINE_WIDTH / 2. + 10, bottomY + padding, LINE_WIDTH, bottomHeight -padding * 2);
    [self initTopArea:topY topWidth:backWidth topHeight:topHeight];
    
    [self initTitleArea:cellWidth];
    
//    [self initCenterArea:centerY centerWidth:backWidth centerHeight:centerHeight];
    [self initBottomArea:bottomY bottomWidth:backWidth bottomHeight:bottomHeight];
    
    CGSize arrowSize = self.rightArrow.frame.size;
    CGRect arrowFrame = self.rightArrow.frame;
    CGPoint arrowOrigin = CGPointMake(cellWidth - arrowSize.width - 10, (cellHeight - arrowSize.height) / 2.);
    arrowFrame.origin = arrowOrigin;
    self.rightArrow.frame = arrowFrame;
////    NSLog(@"颜色 %@",[TaskViewCell hexFromUIColor:[UIColor greenColor]]);
//    self.shipUintCountText.attributedString = [NSString simpleAttributedString:[UIColor flatCoffeeColorDark] size:14 context:@"货量50箱"];
//    CGSize countSize = [self.shipUintCountText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    
//    self.soCountText.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColorDark] size:14 context:@"SO100个"];
//    
//    CGSize soSize = [self.soCountText measure:CGSizeMake(cellWidth, cellHeight)];
//    
//    CGFloat textLeftpadding = leftpadding + 5;// + iconSize.width
//    CGFloat textToppadding = (cellHeight - codeSize.height - countSize.height - soSize.height  - gap * 2) / 2.;
//    

//    
//    self.shipUintCountText.frame = (CGRect){ CGPointMake(textLeftpadding, textToppadding + codeSize.height + gap), countSize };
//    self.soCountText.frame = (CGRect){ CGPointMake(textLeftpadding, self.shipUintCountText.frame.origin.y + countSize.height + gap), soSize };
//
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////        NSAttributedString* iconString = SimpleHtmlTextFace(ICON_FONT_NAME,iconColor,@"14",iconName);
////        NSAttributedString* codeString = SimpleHtmlText(COLOR_BLACK_ORIGINAL, @"4", @"TO1251616161");
////        NSAttributedString* liceneString = SimpleHtmlText([UIColor flatWhiteColor],@"4",@"浙A8888888");
////        NSAttributedString* countString = SimpleHtmlText([UIColor flatCoffeeColorDark],@"4",@"货量50箱");
////        NSAttributedString* soString = SimpleHtmlText([UIColor flatGrayColorDark],@"4",@"SO100个");
//        NSAttributedString * costString = [self generateCostString:@"18" hour:@"2.5" expense:@"320"];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            self.costHourText.attributedString = costString;
//            CGSize costSize = [self.costHourText measure:CGSizeMake(cellWidth, cellHeight)];
//            
//            
//            self.costHourText.frame = (CGRect){CGPointMake(cellWidth - leftpadding - costSize.width, self.soCountText.frame.origin.y + countSize.height - costSize.height), costSize };
//        });
//    });
//    
////    if (!self.isFirst) {//顶部加一根线
//        self.lineNode.frame = CGRectMake(leftpadding, cellHeight - LINE_WIDTH, cellWidth - leftpadding * 2, LINE_WIDTH);
////    }
}

-(void)initTitleArea:(CGFloat)cellWidth{//顶部上方标题栏部分
    
    CGFloat padding = 5;//内边距10
    
    NSString* context = @"TO1251616161";
    //    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc]initWithString:context];
    //    [attrString addAttribute:NSForegroundColorAttributeName value:COLOR_BLACK_ORIGINAL range:NSMakeRange(0, context.length)];
    //    [attrString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, context.length)];
    self.codeText.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:16 content:context];
    //    [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:16 context:@"TO1251616161"];
    self.codeText.size = [self.codeText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.codeText.x = self.orderCountIcon.x;
    self.codeText.y = padding;
//    self.codeText.frame = (CGRect){ CGPointMake(padding * 2, padding), codeSize };
    
    ShipmentBean* bean = self.data;
    UIColor* iconColor;
    if(bean.isComplete){
        iconColor = COLOR_YI_WAN_CHENG;
    }else{
        iconColor = COLOR_DAI_WAN_CHENG;
    }
    
    self.stateArea.size = CGSizeMake(50, 20);
    self.stateArea.x = self.codeText.maxX + padding;
    self.stateArea.y = 5;//self.codeText.centerY;
    self.stateArea.titleColor = self.stateArea.strokeColor = iconColor;
    self.stateArea.title = bean.isComplete ? @"已完成":@"未完成";
    
//    if (!bean.isComplete) {
//        self.stateText.attributedString = [NSString simpleAttributedString:[UIColor whiteColor] size:12 content:@"未完成"];
//        CGSize stateSize = [self.stateText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//        self.stateText.frame = (CGRect){ CGPointMake(padding, padding / 2.), stateSize };
//        
//        CGFloat stateHeight = stateSize.height + padding;
//        
//        self.stateArea.frame = CGRectMake(CGRectGetMinX(self.codeText.frame) + codeSize.width + padding, padding + (CGRectGetHeight(self.codeText.bounds) - stateHeight) / 2., stateSize.width + padding * 2, stateHeight);
//    }
//    self.stateArea.hidden = bean.isComplete;
    
    self.licencePlateText.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:@"浙A790GK"];
    CGSize liceneSize = [self.licencePlateText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    CGFloat plateWidth = liceneSize.width + 10;
    CGFloat plateHeight = liceneSize.height + 10;
    self.licencePlateView.frame = CGRectMake(cellWidth - plateWidth - padding, 3, plateWidth, plateHeight);
    //    self.licencePlateView.cornerRadius = 30;
    
    self.licencePlateText.frame = (CGRect){
        CGPointMake((self.licencePlateView.frame.size.width - liceneSize.width) / 2., (self.licencePlateView.frame.size.height - liceneSize.height) / 2.),
        liceneSize
    };
}

-(NSAttributedString *)generateCostString:(NSString*)distance hour:(NSString*)hour expense:(NSString*)expense{
    return HtmlToText(ConcatStrings(@"<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_JU_LI,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",distance,@"</font><font size='4' color='black'>Km</font>&nbsp&nbsp<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_SHI_JIAN,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",hour,@"</font><font size='4' color='black'>h</font>&nbsp&nbsp<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_JIN_QIAN,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",expense,@"</font>"));
}

@end
