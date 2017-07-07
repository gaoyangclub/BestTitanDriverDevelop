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
@property (nonatomic,retain) ASTextNode* licencePlateText;//车牌号
@property (nonatomic,retain) DiyLicensePlateNode* licencePlateView;//车牌背景图
@property (nonatomic,retain) ASTextNode* shipUintCountText;//货量
@property (nonatomic,retain) ASTextNode* shipUintCountLabel;//货量label
@property (nonatomic,retain) ASTextNode* soCountText;//so个数
@property (nonatomic,retain) ASTextNode* soCountLabel;//so个数label

//@property (nonatomic,retain) UIArrowView* rightArrow;
@property (nonatomic,retain) ASDisplayNode* lineTopY;
@property (nonatomic,retain) ASDisplayNode* lineBottomY;
@property (nonatomic,retain) ASDisplayNode* lineCenterX;

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
@property (nonatomic,retain) ASTextNode* followLabel;


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

//-(UIArrowView *)rightArrow{
//    if(!_rightArrow){
//        _rightArrow = [[UIArrowView alloc]initWithFrame:CGRectMake(0, 0, 10, 22)];
//        _rightArrow.direction = ArrowDirectRight;
//        _rightArrow.lineColor = COLOR_LINE;
//        _rightArrow.lineThinkness = 2;
//        [self.contentView addSubview:_rightArrow];
//    }
//    return _rightArrow;
//}

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

-(ASTextNode *)followLabel{
    if (!_followLabel) {
        _followLabel = [[ASTextNode alloc]init];
        _followLabel.layerBacked = YES;
        [self.followButton.layer addSublayer:_followLabel.layer];
    }
    return _followLabel;
}

-(void)initTopArea:(CGFloat)topY topWidth:(CGFloat)topWidth topHeight:(CGFloat)topHeight{
    CGFloat topCenterY = topY + topHeight / 2.;
    CGFloat labelOffset = -20;
    CGFloat textOffset = 0;
    CGFloat areaWith = topWidth / 3.;
    
    CGFloat areaX1 = 0;
    self.expenseLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColorDark] size:12 content:ConcatStrings(ICON_JIN_QIAN,@"预计收入")];
    CGSize expenseSize = [self.expenseLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.expenseLabel.frame = (CGRect){
        CGPointMake(areaX1 + (areaWith - expenseSize.width) / 2., topCenterY + labelOffset),expenseSize
    };
    self.expenseText.attributedString = [NSString simpleAttributedString:[UIColor flatOrangeColor] size:14 content:@"15元"];
    expenseSize = [self.expenseText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.expenseText.frame = (CGRect){
        CGPointMake(areaX1 + (areaWith - expenseSize.width) / 2., topCenterY + textOffset),expenseSize
    };
    
    CGFloat areaX2 = areaWith;
    self.distanceLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColorDark]     size:12 content:ConcatStrings(ICON_JU_LI,@"预计距离")];
    CGSize distanceSize = [self.distanceLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.distanceLabel.frame = (CGRect){
        CGPointMake(areaX2 + (areaWith - distanceSize.width) / 2., topCenterY + labelOffset),distanceSize
    };
    self.distanceText.attributedString = [NSString simpleAttributedString:[UIColor flatBlackColor] size:14 content:@"1.7公里"];
    distanceSize = [self.distanceText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.distanceText.frame = (CGRect){
        CGPointMake(areaX2 + (areaWith - distanceSize.width) / 2., topCenterY + textOffset),distanceSize
    };
    
    CGFloat areaX3 = areaWith * 2;
    self.costHourLabel.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColorDark]     size:12 content:ConcatStrings(ICON_SHI_JIAN,@"预计时间")];
    CGSize hourSize = [self.costHourLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.costHourLabel.frame = (CGRect){
        CGPointMake(areaX3 + (areaWith - hourSize.width) / 2., topCenterY + labelOffset),hourSize
    };
    self.costHourText.attributedString = [NSString simpleAttributedString:[UIColor flatBlackColor] size:14 content:@"2.5小时"];
    hourSize = [self.costHourText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.costHourText.frame = (CGRect){
        CGPointMake(areaX3 + (areaWith - hourSize.width) / 2., topCenterY + textOffset),hourSize
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

-(void)followClick:(UIControl*)sender{
    ShipmentBean* bean = self.data;
    bean.isFollow = !bean.isFollow;
    [self showFollowArea];
    
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
        self.followIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatOrange  size:18 content:ICON_GUAN_ZHU];
        self.followLabel.attributedString = [NSString simpleAttributedString:FlatOrange  size:14 content:@"取消收藏"];
    }else{
        self.followIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor]  size:18 content:ICON_GUAN_ZHU];
        self.followLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColor]  size:14 content:@"加入收藏"];
    }
    CGSize iconSize = [self.followIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.followIcon.frame = (CGRect){CGPointMake(0, (areaHeight - iconSize.height) / 2.),iconSize};
    CGFloat labelX = iconSize.width;
    CGSize labelSize = [self.followLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.followLabel.frame = (CGRect){CGPointMake(labelX, (areaHeight - labelSize.height) / 2.),labelSize};
    
    CGRect followFrame = self.followButton.frame;
    followFrame.size.width = labelX + labelSize.width;
    followFrame.origin.x = self.backNode.frame.origin.x + self.backNode.frame.size.width - followFrame.size.width - 5;
    
    self.followButton.frame = followFrame;
}

-(void)initBottomArea:(CGFloat)bottomY bottomWidth:(CGFloat)bottomWidth bottomHeight:(CGFloat)bottomHeight{
    ShipmentBean* bean = self.data;
    
    self.followButton.frame = CGRectMake(0, bottomY, 0, bottomHeight);
    [self showFollowArea];
    
    if (true) {
        return;
    }
    
    self.buttonArea.frame = CGRectMake(0, bottomY, bottomWidth, bottomHeight);
    [self.buttonArea removeAllSubNodes];
//    for (ASDisplayNode* subNode in self.buttonArea.subnodes) {//先全部移除干净
//        [subNode removeFromSupernode];
//    }
    
    CGFloat baseX = 10;
    int factor = bean.factor1; //生成0-2范围的随机数
    if(factor == 0){
        ASDisplayNode* subNode1 = [self createStateNode:@"货量差异" color:FlatYellow offsetX:baseX bottomHeight:bottomHeight];
        [self.buttonArea addSubnode:subNode1];
        baseX += subNode1.frame.size.width + 5;
    }
    if (bean.isComplete) {
        ASDisplayNode* subNode2 = [self createStateNode:@"已完成" color:COLOR_YI_WAN_CHENG offsetX:baseX bottomHeight:bottomHeight];
        [self.buttonArea addSubnode:subNode2];
        baseX += subNode2.frame.size.width + 5;
    }else{
        int factor = bean.factor2; //生成0-2范围的随机数
        if (factor > 1) {
            ASDisplayNode* subNode2 = [self createStateNode:@"待签收" color:COLOR_DAI_WAN_CHENG offsetX:baseX bottomHeight:bottomHeight];
            [self.buttonArea addSubnode:subNode2];
            baseX += subNode2.frame.size.width + 5;
        }else if(factor > 0){
            ASDisplayNode* subNode2 = [self createStateNode:@"待提货" color:COLOR_DAI_WAN_CHENG offsetX:baseX bottomHeight:bottomHeight];
            [self.buttonArea addSubnode:subNode2];
            baseX += subNode2.frame.size.width + 5;
        }
    }
    factor = bean.factor3; //生成0-2范围的随机数
    if (factor > 0) {
        ASDisplayNode* subNode1 = [self createStateNode:@"待收款" color:FlatOrange offsetX:baseX bottomHeight:bottomHeight];
        [self.buttonArea addSubnode:subNode1];
    }
    
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
    CGFloat topMargin = 5;
    
    CGFloat backWidth = cellWidth - leftMargin * 2;
    CGFloat backHeight = cellHeight - topMargin;// * 2;
    
    CGFloat padding = 5;//内边距10
    
    CGFloat topHeight = 50;
    CGFloat bottomHeight = 30;
    
    CGFloat topY = 25;
    CGFloat centerY = topY + topHeight;
    
    CGFloat centerHeight = backHeight - topY - topHeight - bottomHeight;
    
    self.backNode.frame = CGRectMake(leftMargin, 0, backWidth, backHeight);
    
    self.normalBackView.backNode.frame = self.selectBackView.backNode.frame = self.backNode.frame;
    
    self.lineTopY.frame = CGRectMake(padding, topY + topHeight, backWidth - padding * 2, LINE_WIDTH);
    self.lineBottomY.frame = CGRectMake(padding, topY + topHeight + centerHeight, backWidth - padding * 2, LINE_WIDTH);
    
    
    self.lineCenterX.frame = CGRectMake((backWidth - LINE_WIDTH) / 2., centerY + padding, LINE_WIDTH, centerHeight - padding * 2);
    
    CGFloat bottomY = centerY + centerHeight;
    
    [self initTopArea:topY topWidth:backWidth topHeight:topHeight];
    [self initCenterArea:centerY centerWidth:backWidth centerHeight:centerHeight];
    [self initBottomArea:bottomY bottomWidth:backWidth bottomHeight:bottomHeight];
    
    NSString* context = @"TO1251616161";
    NSMutableAttributedString* attrString =[[NSMutableAttributedString alloc]initWithString:context];
    [attrString addAttribute:NSForegroundColorAttributeName value:[UIColor flatBlackColor] range:NSMakeRange(0, context.length)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, context.length)];
    self.codeText.attributedString = attrString;
//    [NSString simpleAttributedString:[UIColor flatBlackColor] size:16 context:@"TO1251616161"];
    CGSize codeSize = [self.codeText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.codeText.frame = (CGRect){ CGPointMake(padding * 2, padding), codeSize };
    
    self.licencePlateText.attributedString = [NSString simpleAttributedString:[UIColor flatBlackColor] size:14 content:@"浙A8888888"];
    CGSize liceneSize = [self.licencePlateText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    CGFloat plateWidth = liceneSize.width + 10;
    CGFloat plateHeight = liceneSize.height + 10;
    self.licencePlateView.frame = CGRectMake(cellWidth - leftMargin - plateWidth - 10, 0, plateWidth, plateHeight);
    self.licencePlateView.fillColor = [UIColor flatYellowColorDark];
    self.licencePlateView.compleColor = [UIColor flatBlackColor];
//    self.licencePlateView.cornerRadius = 30;
    
    self.licencePlateText.frame = (CGRect){
        CGPointMake((self.licencePlateView.frame.size.width - liceneSize.width) / 2., (self.licencePlateView.frame.size.height - liceneSize.height) / 2.),
        liceneSize
    };
    
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
////        NSAttributedString* codeString = SimpleHtmlText([UIColor flatBlackColor], @"4", @"TO1251616161");
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

-(NSAttributedString *)generateCostString:(NSString*)distance hour:(NSString*)hour expense:(NSString*)expense{
    return HtmlToText(ConcatStrings(@"<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_JU_LI,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",distance,@"</font><font size='4' color='black'>Km</font>&nbsp&nbsp<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_SHI_JIAN,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",hour,@"</font><font size='4' color='black'>h</font>&nbsp&nbsp<font size='5' color='",[[UIColor flatGrayColor] hexFromUIColor],@"' face='",ICON_FONT_NAME,@"'>",ICON_JIN_QIAN,@"</font><font color='",[[UIColor flatOrangeColor] hexFromUIColor],@"' size='4'>",expense,@"</font>"));
}

@end
