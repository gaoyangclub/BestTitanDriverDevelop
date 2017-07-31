//
//  TaskTripCell.m
//  BestDriverTitan
//
//  Created by admin on 17/2/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskTripCell.h"
#import "RoundRectNode.h"
#import "GYTabBarView.h"
#import "CircleNode.h"
#import "ShipmentStopBean.h"
#import "FlatButton.h"

@interface TaskTripCell(){
    
}

//@property(nonatomic,retain) UIScrollView* bottomAreaView;

//@property(nonatomic,retain) RoundRectNode* bottomRouteLine;
//@property(nonatomic,retain) ASTextNode* carView;
//@property(nonatomic,retain) UIView* bottomRouteGroup;

@property(nonatomic,retain)ASTextNode* indexNode;
@property(nonatomic,retain)ASTextNode* titleNode;
@property(nonatomic,retain)ASTextNode* stateNode;

@property(nonatomic,retain)ASTextNode* shipUintCountText;

@property(nonatomic,retain)RoundRectNode* routeLine;
@property(nonatomic,retain)CircleNode* routeCircle;

@property (nonatomic,retain)UIControl* naviButton;//导航按钮
@property (nonatomic,retain)ASTextNode* naviIcon;//导航图标
@property (nonatomic,retain)ASTextNode* naviLabel;//去这里

@property (nonatomic,retain)FlatButton* activityButton;
//@property (nonatomic,retain)RoundRectNode* activityBack;
//@property (nonatomic,retain)ASTextNode* activityLabel;

@end

static CGFloat shipWidth = 80;
static CGFloat naviWidth = 45;
static CGFloat bottomAreaHeight = 30;

@implementation TaskTripCell

-(ASTextNode *)indexNode{
    if (!_indexNode) {
        _indexNode = [[ASTextNode alloc]init];
        _indexNode.layerBacked = YES;
        _indexNode.userInteractionEnabled = NO;
        [self.contentView.layer addSublayer:_indexNode.layer];
    }
    return _indexNode;
}

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

-(ASTextNode *)stateNode{
    if (!_stateNode) {
        _stateNode = [[ASTextNode alloc]init];
        _stateNode.layerBacked = YES;
        _stateNode.userInteractionEnabled = NO;
        [self.contentView.layer addSublayer:_stateNode.layer];
    }
    return _stateNode;
}

-(RoundRectNode *)routeLine{
    if (!_routeLine) {
        _routeLine = [[RoundRectNode alloc]init];
        _routeLine.layerBacked = YES;
        _routeLine.fillColor = FlatGrayDark;
        [self.contentView.layer addSublayer:_routeLine.layer];
    }
    return _routeLine;
}

-(CircleNode *)routeCircle{
    if (!_routeCircle) {
        _routeCircle = [[CircleNode alloc]init];
        _routeCircle.layerBacked = YES;
        _routeCircle.fillColor = FlatWhite;
        [self.contentView.layer addSublayer:_routeCircle.layer];
    }
    return _routeCircle;
}

-(ASTextNode *)shipUintCountText{
    if(!_shipUintCountText){
        _shipUintCountText = [[ASTextNode alloc]init];
        _shipUintCountText.layerBacked = YES;
        [self.contentView.layer addSubnode:_shipUintCountText];
    }
    return _shipUintCountText;
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

-(FlatButton *)activityButton{
    if (!_activityButton) {
        _activityButton = [[FlatButton alloc]init];
//        [_activityButton setShowTouch:YES];
        [self addSubview:_activityButton];
        _activityButton.fillColor = COLOR_PRIMARY;
        [_activityButton addTarget:self action:@selector(activityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _activityButton;
}

-(void)activityButtonClick:(UIView*)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_ACTIVITY_SELECT object:self.data];
}

//-(RoundRectNode *)activityBack{
//    if (!_activityBack) {
//        _activityBack = [[RoundRectNode alloc]init];
//        _activityBack.layerBacked = YES;
//        _activityBack.fillColor = COLOR_PRIMARY;
//        _activityBack.cornerRadius = 5;
//        [self.activityButton.layer addSublayer:_activityBack.layer];
//    }
//    return _activityBack;
//}
//
//-(ASTextNode *)activityLabel{
//    if (!_activityLabel) {
//        _activityLabel = [[ASTextNode alloc]init];
//        _activityLabel.layerBacked = YES;
//        [self.activityButton.layer addSublayer:_activityLabel.layer];
//    }
//    return _activityLabel;
//}

-(void)showSubviews{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    self.isSelected
    
    CGFloat cellHeight = self.contentView.bounds.size.height;
    CGFloat cellWidth = self.contentView.bounds.size.width;
//
////    CGFloat leftMargin = 10;
//    CGFloat topMargin = 5;
//    
////    CGFloat backWidth = cellWidth - leftMargin * 2;
////    CGFloat backHeight = 175;
//    
//    CGFloat scrollerHeight = cellHeight - topMargin;
//    self.bottomAreaView.frame = CGRectMake(0, topMargin, cellWidth, scrollerHeight);
////    self.bottomAreaView.backgroundColor = [UIColor brownColor];
//    
//    [self initBottomArea:scrollerHeight];
    
    ShipmentStopBean* stopBean = self.data;
    
//    if (self.isSelected) {
//        
//    }else{
//        
//    }
    [self initRouteArea:cellHeight];
    [self initNaviArea:cellWidth cellHeight:cellHeight];
    
    [self initTitleArea:cellWidth cellHeight:cellHeight];
    
    [self initBottomArea:cellWidth cellHeight:cellHeight];
}

//-(void)setIsSelected:(BOOL)isSelected{
//    [super setIsSelected:YES];
//    CGFloat cellHeight = self.contentView.bounds.size.height;
//    CGFloat cellWidth = self.contentView.bounds.size.width;
//    [self initTitleArea:cellWidth cellHeight:cellHeight];
//}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    CGFloat cellHeight = self.contentView.bounds.size.height;
    CGFloat cellWidth = self.contentView.bounds.size.width;
    [self initTitleArea:cellWidth cellHeight:cellHeight];
}

-(void)initTitleArea:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight{
    
    CGFloat leftMargin = CGRectGetMaxX(self.routeLine.frame) + 5;
    
    ShipmentStopBean* stopBean = self.data;
    
    NSString* address = stopBean.stopName;
    
    UIColor* titleColor;
    if(self.selected){
        titleColor = FlatOrange;
        self.backgroundColor = FlatWhite;
    }else{
        titleColor = FlatBlack;
        self.backgroundColor = [UIColor clearColor];
    }
    
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:titleColor size:14 content:address];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, address.length)];
    
    self.titleNode.attributedString = textString;
    
    CGFloat rightArea = naviWidth;
    
    CGFloat maxStartWidth = cellWidth - leftMargin - rightArea;
    
    CGSize textStartSize = [self.titleNode measure:CGSizeMake(maxStartWidth, FLT_MAX)];
    self.titleNode.frame = (CGRect){ CGPointMake(leftMargin,cellHeight - bottomAreaHeight - textStartSize.height),textStartSize};
}

-(void)initNaviArea:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight{
    CGFloat naviHeight = cellHeight;
    
    self.naviButton.frame = CGRectMake(cellWidth - naviWidth, 0, naviWidth, naviHeight);
    
    self.naviIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:26 content:ICON_DAO_HANG];
    CGSize naviIconSize = [self.naviIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.naviLabel.attributedString = [NSString simpleAttributedString:FlatGray  size:12 content:@"去这里"];
    CGSize naviLabelSize = [self.naviLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    CGFloat naviIconY = (cellHeight - naviIconSize.height - naviLabelSize.height) / 2.;
    
    self.naviIcon.frame = (CGRect){ CGPointMake((naviWidth - naviIconSize.width) / 2.,naviIconY),naviIconSize};
    self.naviLabel.frame = (CGRect){ CGPointMake((naviWidth - naviLabelSize.width) / 2.,naviIconY + naviIconSize.height),naviLabelSize};
}

-(void)initBottomArea:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight{
    CGFloat leftMargin = CGRectGetMaxX(self.routeLine.frame) + 5;
    CGFloat bottomY = cellHeight - bottomAreaHeight;
    
    [self initActivityArea:leftMargin bottomY:bottomY cellWidth:cellWidth cellHeight:cellHeight];
    
    ShipmentStopBean* stopBean = self.data;
    
    int pickupCount = stopBean.pickupCount; //生成0-15范围的随机数
    int deliverCount = stopBean.deliverCount; //生成0-15范围的随机数
    
    self.shipUintCountText.attributedString = [self generateShipUnitString:FlatOrange pickupCount:pickupCount deliverCount:deliverCount];
    CGSize shipUnitSize = [self.shipUintCountText measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    self.shipUintCountText.frame = (CGRect){
        CGPointMake(leftMargin, self.activityButton.center.y - shipUnitSize.height / 2.),
        shipUnitSize
    };
    
}

-(void)initActivityArea:(CGFloat)leftMargin bottomY:(CGFloat)bottomY cellWidth:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight{
    
    CGFloat activityWidth = 70;
    CGFloat activityHeight = 25;
    
    ShipmentStopBean* stopBean = self.data;
    
    self.activityButton.fillColor = stopBean.isComplete ? COLOR_YI_WAN_CHENG : COLOR_DAI_WAN_CHENG;
    self.activityButton.title = stopBean.isComplete ? @"已完成" : @"未完成(1)";
    
//    self.activityBack.frame = self.activityButton.bounds;
//    
//    self.activityLabel.attributedString = [NSString simpleAttributedString:[UIColor whiteColor]  size:14 content:@"任务详情"];
//    CGSize activityLabelSize = [self.activityLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    
//    self.activityLabel.frame = (CGRect){ CGPointMake((activityWidth - activityLabelSize.width) / 2.,(activityHeight -activityLabelSize.height) / 2.),activityLabelSize};
    
    self.activityButton.frame = CGRectMake(leftMargin + shipWidth, bottomY, activityWidth, activityHeight);
}

-(void)initRouteArea:(CGFloat)cellHeight{
    CGFloat marginLeft = 10;
    
    ShipmentStopBean* stopBean = self.data;
    
    if (stopBean.isComplete) {
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:20                         content:ICON_YI_SHANG_BAO];
    }else{
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_DAI_WAN_CHENG size:20                         content:ICON_DAI_SHANG_BAO];
    }
    CGSize stateSize = [self.stateNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    CGFloat containerWidth = CGRectGetWidth(self.bounds);
    CGFloat stateWidth = 20;
    self.stateNode.frame = (CGRect){
        CGPointMake(marginLeft + (stateWidth - stateSize.width) / 2., (cellHeight - stateSize.height) / 2.),stateSize
    };
    self.indexNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 content:[NSString stringWithFormat:@"%li",(long)self.indexPath.row + 1]];
    CGSize indexSize = [self.indexNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    CGFloat indexWidth = 20;
    self.indexNode.frame = (CGRect){
        CGPointMake(marginLeft + stateWidth + (indexWidth - indexSize.width) / 2., (cellHeight - indexSize.height) / 2.),indexSize
    };
    
    CGFloat routeW = 5;
    CGFloat routeH = cellHeight;
    CGFloat routeY = 0;
    if (self.isFirst) {
        routeH = cellHeight * 3 / 4;
        routeY = cellHeight - routeH;
        self.routeLine.topLeftRadius = routeW / 2.;
        self.routeLine.topRightRadius = routeW / 2.;
        self.routeLine.bottomLeftRadius = 0;
        self.routeLine.bottomRightRadius = 0;
    }else if(self.isLast){
        routeH = cellHeight * 3 / 4;
        self.routeLine.topLeftRadius = 0;
        self.routeLine.topRightRadius = 0;
        self.routeLine.bottomLeftRadius = routeW / 2.;
        self.routeLine.bottomRightRadius = routeW / 2.;
    }else{
        self.routeLine.topLeftRadius = self.routeLine.topRightRadius = self.routeLine.bottomLeftRadius = self.routeLine.bottomRightRadius = 0;
    }
    CGFloat routeBaseX = marginLeft + stateWidth + indexWidth;
    
    self.routeLine.frame = CGRectMake(routeBaseX, routeY, routeW, routeH);
    
    CGFloat radius = routeW / 2. - 0.5;
    self.routeCircle.cornerRadius = radius;
    self.routeCircle.frame = CGRectMake(routeBaseX + routeW / 2. - radius, cellHeight / 2. - radius, radius * 2, radius * 2);
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
//    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, context.length)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, context.length)];
    NSUInteger loc = 0;
    if (pickupCount) {
//        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(loc, 2)];
        [attrString addAttribute:NSForegroundColorAttributeName value:FlatGray range:NSMakeRange(loc, 2)];
        loc += 2;
        NSUInteger pickupLength = [NSString stringWithFormat:@"%i", pickupCount].length;
//        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(loc, pickupLength)];
        [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(loc, pickupLength)];
        loc += pickupLength + 1;
    }
    if (deliverCount) {
//        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(loc, 2)];
        [attrString addAttribute:NSForegroundColorAttributeName value:FlatGray range:NSMakeRange(loc, 2)];
        loc += 2;
        NSUInteger deliverLength = [NSString stringWithFormat:@"%i", deliverCount].length;
//        [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(loc, deliverLength)];
        [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(loc, deliverLength)];
        //        loc += deliverLength;
    }
    return attrString;
}


@end
