//
//  TaskTripSection.m
//  BestDriverTitan
//
//  Created by admin on 17/2/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskTripSection.h"
#import "RoundRectNode.h"
#import "DIYTabBarItem.h"
#import "OrderViewController.h"
#import "RootNavigationController.h"
#import "CircleNode.h"
#import "ShipmentStopBean.h"

//@interface ActivityButton:UIControl
//
//@property(nonatomic,retain)ASTextNode* iconNode;
//@property(nonatomic,retain)ASTextNode* labelNode;
//@property(nonatomic,retain)ASControlNode* alertNode;//警告货量差异
//@property(nonatomic,retain)ASTextNode* stateNode;//完成情况状态
//@property(nonatomic,retain)DIYBarData* data;//警告货量差异
//
//-(void)showAlertNode;
//-(void)hideAlertNode;
//
//-(void)setComplete:(BOOL)isComplete;
//
////-(void)updateIconColor:(UIColor*)iconColor;
//
//@end
//@implementation ActivityButton
//
////- (instancetype)init
////{
////    self = [super init];
////    if (self) {
////        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
////    }
////    return self;
////}
//
//-(ASControlNode *)alertNode{
//    if (!_alertNode) {
//        _alertNode = [[ASControlNode alloc]init];
//        _alertNode.layerBacked = YES;
//        _alertNode.userInteractionEnabled = NO;
//        
//        ASTextNode* alertIcon = [[ASTextNode alloc]init];
//        alertIcon.layerBacked = YES;
//        alertIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatYellow size:20 * SYSTEM_SCALE_FACTOR content:ICON_JING_GAO];
//        CGSize alertSize = [alertIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//        CGFloat padding = 5 * SYSTEM_SCALE_FACTOR;
//        alertIcon.frame = (CGRect){
//            CGPointMake(CGRectGetWidth(self.bounds) - alertSize.width - padding, CGRectGetHeight(self.bounds) - alertSize.height - padding),alertSize
//        };
//        [_alertNode addSubnode:alertIcon];
//        
//        [self.layer addSublayer:_alertNode.layer];
//    }
//    return _alertNode;
//}
//
//-(ASTextNode *)stateNode{
//    if (!_stateNode) {
//        _stateNode = [[ASTextNode alloc]init];
//        _stateNode.layerBacked = YES;
//        _stateNode.userInteractionEnabled = NO;
//        [self.layer addSublayer:_stateNode.layer];
//    }
//    return _stateNode;
//}
//
//-(void)setComplete:(BOOL)isComplete{
//    if (isComplete) {
//        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:20 * SYSTEM_SCALE_FACTOR content:ICON_YI_SHANG_BAO];
//    }else{
//        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_DAI_WAN_CHENG size:20 * SYSTEM_SCALE_FACTOR content:ICON_DAI_SHANG_BAO];
//    }
//    CGSize stateSize = [self.stateNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    CGFloat padding = 5 * SYSTEM_SCALE_FACTOR;
//    self.stateNode.frame = (CGRect){
//        CGPointMake(CGRectGetWidth(self.bounds) - stateSize.width - padding, padding),stateSize
//    };
//}
//
////-(void)updateIconColor:(UIColor*)iconColor{
////    self.iconNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:30                         context:self.data.image];
//////    CGSize labelSize = [self.labelNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//////    self.labelNode.frame = (CGRect){CGPointMake((buttonWidth - labelSize.width) / 2., buttonHeight / 2. + labelOffset),labelSize};
////}
//
//-(void)showAlertNode{
//    self.alertNode.hidden = NO;
//    //加侦听器
//    //点击展开货量差异提示
//}
//
//-(void)hideAlertNode{
//    self.alertNode.hidden = YES;
//    //    self.alertNode removeTarget:<#(nullable id)#> action:<#(nullable SEL)#> forControlEvents:<#(ASControlNodeEvent)#>
//    //移除侦听器
//}
//
//@end

@interface TaskTripSection(){
    NSMutableDictionary* buttonDic;//活动上报按钮访问列表
}

@property(nonatomic,retain) RoundRectNode* centerAreaBack;
@property(nonatomic,retain) UIView* centerAreaView;

@property(nonatomic,retain) ASDisplayNode* topAreaBack;

@property (nonatomic,retain) ASTextNode* shipUintCountText;//货量
@property (nonatomic,retain) ASTextNode* shipUintCountLabel;//货量label
@property (nonatomic,retain) ASTextNode* soCountText;//so个数
@property (nonatomic,retain) ASTextNode* soCountLabel;//so个数label
@property (nonatomic,retain) CircleNode* circleArea;

@property (nonatomic,retain) ASTextNode* timeText;

@property (nonatomic,retain) UIControl* phoneButton;//联系方式
@property (nonatomic,retain) ASTextNode* phoneIcon;

@property (nonatomic,retain) UIControl* followButton;//关注
@property (nonatomic,retain) ASTextNode* followIcon;
//@property (nonatomic,retain) ASTextNode* followLabel;

@property (nonatomic,retain) ASDisplayNode* lineBottomY;
@property (nonatomic,retain) ASDisplayNode* linePhoneX;

@property (nonatomic,retain) UIControl* naviButton;//导航按钮
@property (nonatomic,retain) ASTextNode* naviIcon;//导航图标
@property (nonatomic,retain) ASTextNode* naviLabel;//去这里

@property (nonatomic,retain) ASTextNode* textStart;//详细地址信息

@end


@implementation TaskTripSection

- (instancetype)init
{
    self = [super init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventOccurred:)
                                                 name:EVENT_ADDRESS_SELECT
                                               object:nil];
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_ADDRESS_SELECT object:nil];
//    [super dealloc];
}

-(ASDisplayNode *)topAreaBack{
    if (!_topAreaBack) {
        _topAreaBack = [[ASDisplayNode alloc]init];
        _topAreaBack.layerBacked = YES;
        _topAreaBack.backgroundColor = [UIColor whiteColor];
        [self.layer addSublayer:_topAreaBack.layer];
    }
    return _topAreaBack;
}

-(UIControl *)naviButton{
    if (!_naviButton) {
        _naviButton = [[UIControl alloc]init];
        [_naviButton setShowTouch:YES];
        [self addSubview:_naviButton];
    }
    return _naviButton;
}

-(ASTextNode *)naviIcon{
    if (!_naviIcon) {
        _naviIcon = [[ASTextNode alloc]init];
        _naviIcon.layerBacked = YES;
        [self.naviButton.layer addSublayer:_naviIcon.layer];
    }
    return _naviIcon;
}

-(ASTextNode *)naviLabel{
    if (!_naviLabel) {
        _naviLabel = [[ASTextNode alloc]init];
        _naviLabel.layerBacked = YES;
        [self.naviButton.layer addSublayer:_naviLabel.layer];
    }
    return _naviLabel;
}

-(ASTextNode *)textStart{
    if (!_textStart) {
        _textStart = [[ASTextNode alloc]init];
        _textStart.maximumNumberOfLines = 3;
        _textStart.truncationMode = NSLineBreakByTruncatingTail;
        _textStart.layerBacked = YES;
        [self.topAreaBack addSubnode:_textStart];
    }
    return _textStart;
}

-(UIView *)centerAreaView{
    if (!_centerAreaView) {
        _centerAreaView = [[UIView alloc]init];
        _centerAreaView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_centerAreaView];
    }
    return _centerAreaView;
}

-(RoundRectNode *)centerAreaBack{
    if (!_centerAreaBack) {
        _centerAreaBack = [[RoundRectNode alloc]init];
        _centerAreaBack.fillColor = [UIColor whiteColor];
        _centerAreaBack.cornerRadius = 5;
        _centerAreaBack.layerBacked = YES;
        [self.centerAreaView.layer addSublayer:_centerAreaBack.layer];
    }
    return _centerAreaBack;
}

-(ASTextNode *)soCountText{
    if(!_soCountText){
        _soCountText = [[ASTextNode alloc]init];
        _soCountText.layerBacked = YES;
        [self.centerAreaBack addSubnode:_soCountText];
    }
    return _soCountText;
}

-(ASTextNode *)soCountLabel{
    if(!_soCountLabel){
        _soCountLabel = [[ASTextNode alloc]init];
        _soCountLabel.layerBacked = YES;
        [self.centerAreaBack addSubnode:_soCountLabel];
    }
    return _soCountLabel;
}

-(ASTextNode *)shipUintCountText{
    if(!_shipUintCountText){
        _shipUintCountText = [[ASTextNode alloc]init];
        _shipUintCountText.layerBacked = YES;
        [self.centerAreaBack addSubnode:_shipUintCountText];
    }
    return _shipUintCountText;
}

-(ASTextNode *)shipUintCountLabel{
    if(!_shipUintCountLabel){
        _shipUintCountLabel = [[ASTextNode alloc]init];
        _shipUintCountLabel.layerBacked = YES;
        [self.centerAreaBack addSubnode:_shipUintCountLabel];
    }
    return _shipUintCountLabel;
}

-(CircleNode *)circleArea{
    if (!_circleArea) {
        _circleArea = [[CircleNode alloc]init];
        _circleArea.layerBacked = YES;
        _circleArea.fillColor = [UIColor clearColor];
        _circleArea.strokeWidth = 4;
        [self.centerAreaBack addSubnode:_circleArea];
    }
    return _circleArea;
}

-(ASDisplayNode *)lineBottomY{
    if(!_lineBottomY){
        _lineBottomY = [[ASDisplayNode alloc]init];
        _lineBottomY.backgroundColor = COLOR_LINE;
        _lineBottomY.layerBacked = YES;
        [self.centerAreaBack addSubnode:_lineBottomY];
    }
    return _lineBottomY;
}

-(ASDisplayNode *)linePhoneX{
    if(!_linePhoneX){
        _linePhoneX = [[ASDisplayNode alloc]init];
        _linePhoneX.backgroundColor = COLOR_LINE;
        _linePhoneX.layerBacked = YES;
        [self.centerAreaBack addSubnode:_linePhoneX];
    }
    return _linePhoneX;
}

-(ASTextNode *)timeText{
    if (!_timeText) {
        _timeText = [[ASTextNode alloc]init];
        _timeText.layerBacked = YES;
        [self.centerAreaBack addSubnode:_timeText];
    }
    return _timeText;
}

-(UIControl *)phoneButton{
    if (!_phoneButton) {
        _phoneButton = [[UIControl alloc]init];
        [_phoneButton setShowTouch:YES];
        [self.centerAreaView addSubview:_phoneButton];
    }
    return _phoneButton;
}

-(ASTextNode *)phoneIcon{
    if (!_phoneIcon) {
        _phoneIcon = [[ASTextNode alloc]init];
        _phoneIcon.layerBacked = YES;
        [self.phoneButton.layer addSublayer:_phoneIcon.layer];
    }
    return _phoneIcon;
}

-(UIControl *)followButton{
    if (!_followButton) {
        _followButton = [[UIControl alloc]init];
        [_followButton setShowTouch:YES];
        [self.centerAreaView addSubview:_followButton];
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

//-(ASTextNode *)followLabel{
//    if (!_followLabel) {
//        _followLabel = [[ASTextNode alloc]init];
//        _followLabel.layerBacked = YES;
//        [self.followButton.layer addSublayer:_followLabel.layer];
//    }
//    return _followLabel;
//}

- (void)eventOccurred:(NSNotification*)eventData{
    self.backgroundColor = COLOR_BACKGROUND;
    
//    DDLog(@"eventOccurred:收到消息");
    
    ShipmentStopBean* bean = eventData.object;
    if (!bean) {//数据没有传递
        return;
    }
    
    CGFloat sectionWidth = self.bounds.size.width;
//    CGFloat sectionHeight = self.bounds.size.height;
    
//    CGFloat leftpadding = 10;
    
    CGFloat topHeight = TASK_TRIP_SECTION_TOP_HEIGHT - 5;
    
    self.topAreaBack.frame = CGRectMake(0, 0, sectionWidth, topHeight);
    
//    CGFloat leftMargin = 0;//10;
//    CGFloat topMargin = 5;
    
//    CGFloat centerWidth = sectionWidth - leftMargin * 2;
//    CGFloat centerHeight = sectionHeight - topHeight - topMargin * 2;
    
//    self.centerAreaView.frame = CGRectMake(leftMargin, topHeight + topMargin, centerWidth, centerHeight);
    
//    CGFloat bottomHeight = 40;
    
//    CGFloat bottomY = centerHeight - bottomHeight;
    
//    self.lineBottomY.frame = CGRectMake(leftpadding, bottomY, centerWidth - leftpadding * 2, LINE_WIDTH);
    
    [self initTopArea:bean topWidth:sectionWidth topHeight:topHeight];
    
//    [self initCenterArea:bean centerWidth:centerWidth centerHeight:bottomY];
    
//    [self initBottomArea:bean bottomY:bottomY bottomWidth:centerWidth bottomHeight:bottomHeight];
    
//    self.topAreaBack.frame = self.topAreaView.bounds;
//    [self initTopArea:backWidth];
//    [self checkButtonStates];
}

-(void)initTopArea:(ShipmentStopBean*)bean topWidth:(CGFloat)topWidth topHeight:(CGFloat)topHeight{
    
    CGFloat leftpadding = 10;
    
    CGFloat naviWidth = topHeight;
    
    self.naviButton.frame = CGRectMake(topWidth - naviWidth, 0, naviWidth, topHeight);
    
    self.naviIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:26 content:ICON_DAO_HANG];
    CGSize naviIconSize = [self.naviIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.naviLabel.attributedString = [NSString simpleAttributedString:FlatGray  size:12 content:@"去这里"];
    CGSize naviLabelSize = [self.naviLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    CGFloat naviIconY = (topHeight - naviIconSize.height - naviLabelSize.height) / 2.;
    
    self.naviIcon.frame = (CGRect){ CGPointMake((naviWidth - naviIconSize.width) / 2.,naviIconY),naviIconSize};
    self.naviLabel.frame = (CGRect){ CGPointMake((naviWidth - naviLabelSize.width) / 2.,naviIconY + naviIconSize.height),naviLabelSize};
    
    NSString* address = bean.stopName;
    
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:address];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, address.length)];
    
    self.textStart.attributedString = textString;
    CGFloat maxStartWidth = topWidth - leftpadding - naviWidth;
    
    CGSize textStartSize = [self.textStart measure:CGSizeMake(maxStartWidth, FLT_MAX)];
    self.textStart.frame = (CGRect){ CGPointMake(leftpadding,(topHeight - textStartSize.height) / 2.),textStartSize};
    
}

-(void)initCenterArea:(ShipmentStopBean*)bean centerWidth:(CGFloat)centerWidth centerHeight:(CGFloat)centerHeight{
    CGFloat topCenterY = centerHeight / 2.;
    CGFloat areaWith = centerWidth / 2.;
    CGFloat labelOffset = 10;
    CGFloat textOffset = -30;
    
    CGFloat areaX1 = 0;
    
    UIColor* iconColor;
    if (bean.isComplete) {
        //    if (self.indexPath.row % 2 == 0) {
        iconColor = COLOR_YI_WAN_CHENG;
    }else{
        iconColor = COLOR_DAI_WAN_CHENG;
    }
    
    self.soCountText.attributedString = [NSString simpleAttributedString:iconColor size:30 content:[NSNumber numberWithInteger:bean.orderCount].stringValue];
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
    self.circleArea.frame = CGRectMake(0, 5, areaWith, centerHeight - 10);
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

-(void)initBottomArea:(ShipmentStopBean*)bean bottomY:(CGFloat)bottomY bottomWidth:(CGFloat)bottomWidth bottomHeight:(CGFloat)bottomHeight{
    
    CGFloat leftpadding = 10;
    
    self.timeText.attributedString = [NSString simpleAttributedString:FlatGray size:14 content:@"预计送达:2017-07-13 12:00:00"];
    CGSize timeSize = [self.timeText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.timeText.frame = (CGRect){CGPointMake(leftpadding, bottomY + (bottomHeight - timeSize.height) / 2.),timeSize};
    
    CGFloat phoneX = CGRectGetMinX(self.timeText.frame) + timeSize.width + leftpadding;
    
    self.linePhoneX.frame = CGRectMake(phoneX - LINE_WIDTH / 2., bottomY + leftpadding, LINE_WIDTH , bottomHeight - leftpadding * 2);
    
    self.phoneButton.frame = CGRectMake(phoneX, bottomY, bottomHeight, bottomHeight);
    self.phoneIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_PRIMARY size:24 content:ICON_DIAN_HUA];
    CGSize phoneSize = [self.phoneIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.phoneIcon.frame = (CGRect){CGPointMake((bottomHeight - phoneSize.width) / 2, (bottomHeight - phoneSize.height) / 2),phoneSize};
    
//    self.followButton.frame = CGRectMake(bottomWidth - bottomHeight, bottomY, bottomHeight, bottomHeight);
//    [self showFollowArea:bean];
}

//-(void)showFollowArea:(ShipmentStopBean*)bean{
//    
//    CGFloat areaHeight = CGRectGetHeight(self.followButton.bounds);
//    
//    if (bean.isFollow) {
//        self.followIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatOrange  size:24 content:ICON_STAR];
////        self.followLabel.attributedString = [NSString simpleAttributedString:FlatOrange  size:12 content:@"收  藏"];
//    }else{
//        self.followIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:[UIColor flatGrayColor]  size:24 content:ICON_STAR];
////        self.followLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColor]  size:12 content:@"收  藏"];
//    }
//    
//    CGSize iconSize = [self.followIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
////    CGSize labelSize = [self.followLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    
//    CGFloat iconY = (areaHeight - iconSize.height) / 2;
//    
//    self.followIcon.frame = (CGRect){CGPointMake((areaHeight - iconSize.width) / 2, iconY),iconSize};
//    
////    self.followLabel.frame = (CGRect){CGPointMake((areaHeight - labelSize.width) / 2, iconY + iconSize.height + iconGap),labelSize};
//}

//-(void)initTopArea:(CGFloat)backWidth{
//    if (!buttonDic) {
//        CGFloat buttonWidth = backWidth / 3.;
//        CGFloat buttonHeight = 65 * SYSTEM_SCALE_FACTOR;
//        CGFloat padding = 5 * SYSTEM_SCALE_FACTOR;//内边距
//        CGFloat iconOffset = -25 * SYSTEM_SCALE_FACTOR;
//        CGFloat labelOffset = 10 * SYSTEM_SCALE_FACTOR;
//        
//        buttonDic = [[NSMutableDictionary alloc]init];
//        
//        //6个活动上报按钮
//        NSArray<DIYBarData *>* dataArray = @[[DIYBarData initWithParams:TABBAR_TITLE_TI_HUO image:ICON_TI_HUO],
//                                             [DIYBarData initWithParams:TABBAR_TITLE_ZHUANG_CHE image:ICON_ZHUANG_CHE],
//                                             [DIYBarData initWithParams:TABBAR_TITLE_XIE_HUO image:ICON_XIE_HUO],
//                                             [DIYBarData initWithParams:TABBAR_TITLE_QIAN_SHOU image:ICON_QIAN_SHOU],
//                                             [DIYBarData initWithParams:TABBAR_TITLE_HUI_DAN image:ICON_HUI_DAN],
//                                             [DIYBarData initWithParams:TABBAR_TITLE_SHOU_KUAN image:ICON_SHOU_KUAN],
//                                             ];
//        //2行3列
//        for(int i = 0 ; i < dataArray.count ; i ++){
//            DIYBarData* data = dataArray[i];
//            
//            ActivityButton* btn = [[ActivityButton alloc]init];
//            [btn setShowTouch:YES];
//            btn.data = data;
//            //            btn.layerBacked = YES;
//            [self.topAreaView addSubview:btn];
//            btn.frame = CGRectMake((i % 3) * buttonWidth, (i / 3) * buttonHeight, buttonWidth, buttonHeight);
//            
//            ASTextNode* iconNode = btn.iconNode = [[ASTextNode alloc]init];
//            iconNode.layerBacked = YES;
//            iconNode.userInteractionEnabled = NO;
//            [btn.layer addSublayer:iconNode.layer];
//            iconNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatPowderBlueDark size:30 * SYSTEM_SCALE_FACTOR content:data.image];
//            CGSize iconSize = [iconNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//            iconNode.frame = (CGRect){CGPointMake((buttonWidth - iconSize.width) / 2., buttonHeight / 2. + iconOffset),iconSize};
//            
//            ASTextNode* labelNode = btn.labelNode = [[ASTextNode alloc]init];
//            labelNode.layerBacked = YES;
//            labelNode.userInteractionEnabled = NO;
//            [btn.layer addSublayer:labelNode.layer];
//            labelNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:12 * SYSTEM_SCALE_FACTOR  content:data.title];
//            CGSize labelSize = [labelNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//            labelNode.frame = (CGRect){CGPointMake((buttonWidth - labelSize.width) / 2., buttonHeight / 2. + labelOffset),labelSize};
//            
//            [btn addTarget:self action:@selector(clickActivityButton:) forControlEvents:UIControlEventTouchUpInside];
//            
//            [buttonDic setValue:btn forKey:data.title];
//            
//            if (i % 3 == 0) {//横向的线
//                ASDisplayNode* lineTopY = [[ASDisplayNode alloc]init];
//                lineTopY.backgroundColor = COLOR_LINE;
//                lineTopY.layerBacked = YES;
//                lineTopY.frame = CGRectMake(padding, (i / 3 + 1) * buttonHeight - LINE_WIDTH / 2., backWidth - padding * 2, LINE_WIDTH);
//                [self.topAreaBack addSubnode:lineTopY];
//            }else{
//                ASDisplayNode* lineTopX = [[ASDisplayNode alloc]init];
//                lineTopX.backgroundColor = COLOR_LINE;
//                lineTopX.layerBacked = YES;
//                lineTopX.frame = CGRectMake((i % 3) * buttonWidth - LINE_WIDTH / 2., (i / 3) * buttonHeight + padding, LINE_WIDTH , buttonHeight - padding * 2);
//                [self.topAreaBack addSubnode:lineTopX];
//            }
//        }
//    }
//}

//-(void)clickActivityButton:(ActivityButton*)btn{
//    UIViewController* controller = [[OrderViewController alloc]init];
//    [[RootNavigationController sharedInstance] pushViewController:controller animated:YES];
//}
//
//-(void)checkButtonStates{
//    for (NSString *key in buttonDic) {
//        ActivityButton* btn = buttonDic[key];
//        int count = (arc4random() % 4); //生成0-2范围的随机数
//        if (count > 0) {
//            if (count > 1) {
//                //                [btn updateIconColor:COLOR_PRIMARY];
//                [btn setComplete:YES];
//                if (count > 2) {
//                    [btn showAlertNode];
//                }
//            }else{
//                //                [btn updateIconColor:COLOR_PRIMARY];
//                [btn setComplete:NO];
//            }
//            btn.stateNode.hidden = NO;
//            [btn setShowTouch:YES];
//            //            btn.userInteractionEnabled = YES;
//            btn.alpha = 1;
//        }else{
//            //            [btn updateIconColor:FlatGray];
//            btn.stateNode.hidden = YES;
//            [btn setShowTouch:NO];
//            //            btn.userInteractionEnabled = NO;//无法交互
//            btn.alpha = 0.3;
//            [btn hideAlertNode];
//        }
//    }
//}


@end
