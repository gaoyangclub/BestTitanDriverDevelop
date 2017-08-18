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
#import "UIArrowView.h"
#import "MapNaviViewController.h"
#import "OwnerViewController.h"

@interface TaskTripCell(){
    
}

//@property(nonatomic,retain) UIScrollView* bottomAreaView;

//@property(nonatomic,retain) RoundRectNode* bottomRouteLine;
//@property(nonatomic,retain) ASTextNode* carView;
//@property(nonatomic,retain) UIView* bottomRouteGroup;

//@property(nonatomic,retain)ASTextNode* indexNode;

@property(nonatomic,retain)ASTextNode* titleNode;
@property(nonatomic,retain)ASTextNode* orderCountIcon;
@property(nonatomic,retain)ASTextNode* orderCountNode;//订单数

@property(nonatomic,retain)ASTextNode* addressNode;

@property(nonatomic,retain)ASTextNode* stateNode;

@property(nonatomic,retain)ASTextNode* shipUintCountText;

@property(nonatomic,retain)ASTextNode* timeLabel;

@property(nonatomic,retain)RoundRectNode* routeLine;
@property(nonatomic,retain)CircleNode* routeCircle;

@property (nonatomic,retain)FlatButton* naviButton;//导航按钮
//@property (nonatomic,retain)ASTextNode* naviIcon;//导航图标
@property (nonatomic,retain)ASTextNode* naviLabel;//去这里

@property (nonatomic,retain)FlatButton* phoneButton;//联系电话

@property (nonatomic,retain)FlatButton* activityButton;

@property (nonatomic,retain)UIView* indicatorView;
//@property (nonatomic,retain)RoundRectNode* activityBack;
//@property (nonatomic,retain)ASTextNode* activityLabel;

@end

static CGFloat topAreaHeight = 30;
//static CGFloat shipWidth = 60;
static CGFloat naviWidth = 40;
static CGFloat bottomAreaHeight = 45;

@implementation TaskTripCell

+(CGFloat)getMarginLeft{
    if (SCREEN_WIDTH > IPHONE_5S_WIDTH) {
        return 7 * SYSTEM_SCALE;
    }
    return 3;
}

//-(ASTextNode *)carView{
//    if (!_carView) {
//        _carView = [[ASTextNode alloc]init];
//        _carView.layerBacked = YES;
//        _carView.userInteractionEnabled = NO;
//        [self.contentView.layer addSublayer:_carView.layer];
//    }
//    return _carView;
//}

-(UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc]init];
        
        CGFloat backWidth = 12;
        CGFloat backHeight = 12;
        CGFloat arrowWidth = 6;
        
        UIView* backNode = [[UIView alloc]init];
        [_indicatorView addSubview:backNode];
        backNode.backgroundColor = COLOR_LINE;
        backNode.frame = CGRectMake(0, 0, backWidth, backHeight);
        
        UIArrowView* arrowNode = [[UIArrowView alloc]init];
        [_indicatorView addSubview:arrowNode];
        arrowNode.direction = ArrowDirectRight;
        arrowNode.isClosed = YES;
        arrowNode.fillColor = COLOR_LINE;
        arrowNode.lineColor = COLOR_LINE;
//        arrowNode.lineThinkness = 0;
        arrowNode.frame = CGRectMake(backWidth, 0, arrowWidth, backHeight);
        
        [self.contentView addSubview:_indicatorView];
        
        _indicatorView.frame = CGRectMake(0, 0, backWidth + arrowWidth, backHeight);
    }
    return _indicatorView;
}

//-(ASTextNode *)indexNode{
//    if (!_indexNode) {
//        _indexNode = [[ASTextNode alloc]init];
//        _indexNode.layerBacked = YES;
//        _indexNode.userInteractionEnabled = NO;
//        [self.contentView.layer addSublayer:_indexNode.layer];
//    }
//    return _indexNode;
//}

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        _titleNode.maximumNumberOfLines = 1;//最多一行
        _titleNode.truncationMode = NSLineBreakByTruncatingTail;
        [self.contentView.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

-(ASTextNode *)orderCountNode{
    if (!_orderCountNode) {
        _orderCountNode = [[ASTextNode alloc]init];
        _orderCountNode.layerBacked = YES;
        [self.contentView.layer addSublayer:_orderCountNode.layer];
    }
    return _orderCountNode;
}

-(ASTextNode *)orderCountIcon{
    if (!_orderCountIcon) {
        _orderCountIcon = [[ASTextNode alloc]init];
        _orderCountIcon.layerBacked = YES;
        [self.contentView.layer addSublayer:_orderCountIcon.layer];
    }
    return _orderCountIcon;
}

-(ASTextNode *)addressNode{
    if (!_addressNode) {
        _addressNode = [[ASTextNode alloc]init];
        _addressNode.layerBacked = YES;
        _addressNode.maximumNumberOfLines = 2;//最多2行
        _addressNode.truncationMode = NSLineBreakByTruncatingTail;
        [self.contentView.layer addSublayer:_addressNode.layer];
    }
    return _addressNode;
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
        _routeLine.fillColor = COLOR_LINE;
        [self.contentView.layer addSublayer:_routeLine.layer];
    }
    return _routeLine;
}

-(CircleNode *)routeCircle{
    if (!_routeCircle) {
        _routeCircle = [[CircleNode alloc]init];
        _routeCircle.layerBacked = YES;
        _routeCircle.fillColor = COLOR_LINE;//FlatWhite
        _routeCircle.strokeColor = [UIColor whiteColor];
        _routeCircle.strokeWidth = 2;
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

-(ASTextNode *)timeLabel{
    if(!_timeLabel){
        _timeLabel = [[ASTextNode alloc]init];
        _timeLabel.layerBacked = YES;
        [self.contentView.layer addSubnode:_timeLabel];
    }
    return _timeLabel;
}

//-(UIControl *)naviButton{
//    if (!_naviButton) {
//        _naviButton = [[UIControl alloc]init];
//        [_naviButton setShowTouch:YES];
//        [self addSubview:_naviButton];
//    }
//    return _naviButton;
//}

//-(ASTextNode *)naviIcon{
//    if (!_naviIcon) {
//        _naviIcon = [[ASTextNode alloc]init];
//        _naviIcon.layerBacked = YES;
//        [self.contentView.layer addSublayer:_naviIcon.layer];
//    }
//    return _naviIcon;
//}

-(FlatButton *)naviButton{
    if (!_naviButton) {
        _naviButton = [[FlatButton alloc]init];
        _naviButton.fillColor = [UIColor clearColor];
        _naviButton.titleColor = COLOR_ACCENT;
        _naviButton.titleFontName = ICON_FONT_NAME;
        _naviButton.titleSize = 38;
        _naviButton.title = ICON_DAO_HANG;
        [_naviButton addTarget:self action:@selector(clickNaviButton) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_naviButton];
    }
    return _naviButton;
}

-(void)clickNaviButton{
    MapNaviViewController* naviController = [[MapNaviViewController alloc]init];
    [[OwnerViewController sharedInstance]pushViewController:naviController animated:YES];
}

-(FlatButton *)phoneButton{
    if (!_phoneButton) {
        _phoneButton = [[FlatButton alloc]init];
        _phoneButton.fillColor = [UIColor clearColor];
        _phoneButton.titleColor = COLOR_ACCENT;
        _phoneButton.titleFontName = ICON_FONT_NAME;
        _phoneButton.titleSize = 28;
        _phoneButton.title = ICON_DIAN_HUA;
        [self.contentView addSubview:_phoneButton];
    }
    return _phoneButton;
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
    
    CGFloat cellHeight = self.contentView.bounds.size.height;
    CGFloat cellWidth = self.contentView.bounds.size.width;

    [self initRouteArea:cellHeight];
    
    [self initNaviArea:cellWidth cellHeight:cellHeight];
    
    [self initTopArea:cellWidth cellHeight:cellHeight];
    [self initCenterArea:cellWidth cellHeight:cellHeight];
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
    [self initRouteArea:cellHeight];
    [self initTopArea:cellWidth cellHeight:cellHeight];
    [self initCenterArea:cellWidth cellHeight:cellHeight];
}

-(void)initTopArea:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight{
    ShipmentStopBean* stopBean = self.data;
    
    CGFloat leftMargin = CGRectGetMaxX(self.routeLine.frame) + 16;
    
    CGFloat padding = 5;
    
    self.orderCountIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatGray size:18 content:ICON_DING_DAN];
    self.orderCountIcon.size = [self.orderCountIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];

    self.orderCountNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatOrange size:16 content:@"15"];
    self.orderCountNode.size = [self.orderCountNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];//CGSize orderCountSize =

    NSString* stopName = ConcatStrings([NSString stringWithFormat:@"%li",(long)self.indexPath.row + 1],@".",stopBean.shortAddress);
    UIColor* titleColor;//,@"上海市松江区上海市松江区啦啦啦啦啦啦"
    if(self.selected){
        titleColor = FlatOrange;
        self.backgroundColor = FlatWhite;
    }else{
        titleColor = COLOR_BLACK_ORIGINAL;
        self.backgroundColor = [UIColor clearColor];
    }
    
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:titleColor size:16 content:stopName];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, stopName.length)];
    self.titleNode.attributedString = textString;
    CGFloat maxStartWidth = cellWidth - leftMargin - naviWidth - [TaskTripCell getMarginLeft] - self.orderCountIcon.width - padding - self.orderCountNode.width;
    self.titleNode.size = [self.titleNode measure:CGSizeMake(maxStartWidth, FLT_MAX)];//CGSize textStartSize =
    self.titleNode.x = leftMargin;
    self.titleNode.maxY = topAreaHeight;
    
    self.orderCountIcon.x = self.titleNode.maxX + padding;
    self.orderCountIcon.centerY = self.titleNode.centerY;
    
    self.orderCountNode.x = self.orderCountIcon.maxX;
    self.orderCountNode.centerY = self.orderCountIcon.centerY;
}

-(void)initCenterArea:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight{
    
    CGFloat centerAreaY = topAreaHeight;
    CGFloat centerAreaHeight = cellHeight - topAreaHeight - bottomAreaHeight;
    
    CGFloat leftMargin = self.titleNode.x;//CGRectGetMinX(self.titleNode.frame);
    
    ShipmentStopBean* stopBean = self.data;
    
    NSString* address = stopBean.stopName;
    
    UIColor* titleColor;
    if(self.selected){
        titleColor = FlatOrange;
        self.backgroundColor = FlatWhite;
    }else{
        titleColor = COLOR_BLACK_ORIGINAL;
        self.backgroundColor = [UIColor clearColor];
    }
    
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:titleColor size:14 content:address];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, address.length)];
    
    self.addressNode.attributedString = textString;
    
    CGFloat maxStartWidth = cellWidth - leftMargin - naviWidth - [TaskTripCell getMarginLeft];
    
    self.addressNode.size = [self.addressNode measure:CGSizeMake(maxStartWidth, FLT_MAX)];//CGSize textStartSize =
    self.addressNode.x = leftMargin;
    self.addressNode.centerY = centerAreaY + centerAreaHeight / 2.;
//    self.addressNode.frame = (CGRect){ CGPointMake(leftMargin,centerAreaY + (centerAreaHeight - textStartSize.height) / 2.),textStartSize};
}

-(void)initNaviArea:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight{
    CGFloat naviHeight = cellHeight - bottomAreaHeight;
    
//    self.naviButton.frame = CGRectMake(cellWidth - naviWidth, 0, naviWidth, naviHeight);
//    
//    self.naviIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_PRIMARY size:26 content:ICON_DAO_HANG];
//    CGSize naviIconSize = [self.naviIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.naviLabel.attributedString = [NSString simpleAttributedString:FlatGray  size:12 content:@"去这里"];
    self.naviLabel.size = [self.naviLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
//    CGFloat naviIconY = (cellHeight - naviIconSize.height - naviLabelSize.height) / 2.;
    CGFloat baseX = cellWidth - naviWidth - [TaskTripCell getMarginLeft];
    CGFloat buttonHeight = naviHeight - 10;
    CGFloat buttonWidth = naviWidth;
    self.naviButton.frame = CGRectMake(baseX + (naviWidth - buttonWidth) / 2., (naviHeight - buttonHeight) / 2., buttonWidth, buttonHeight);
//    self.phoneButton.frame = CGRectMake(baseX + buttonWidth, (naviHeight - buttonHeight) / 2., buttonWidth, buttonHeight);
//    self.naviButton.backgroundColor = FlatBrownDark;
    
    self.naviLabel.centerX = self.naviButton.width / 2. - 5;
    self.naviLabel.maxY = self.naviButton.height;
    
//    self.naviIcon.frame = (CGRect){ CGPointMake((naviWidth - naviIconSize.width) / 2.,(bottomAreaHeight - naviIconSize.height) / 2.),naviIconSize};
//    self.naviLabel.frame = (CGRect){ CGPointMake((naviWidth - naviLabelSize.width) / 2.,naviIconY + naviIconSize.height),naviLabelSize};
}

-(void)initBottomArea:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight{
    CGFloat leftMargin = self.titleNode.x;//CGRectGetMinX(self.titleNode.frame);
    CGFloat bottomY = cellHeight - bottomAreaHeight;
    
    self.timeLabel.attributedString = [NSString simpleAttributedString:FlatGray size:12 content:@"送达:2017-08-15 00:00:00"];
    self.timeLabel.size = [self.timeLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];//CGSize timeSize =
    self.timeLabel.x = leftMargin;
    self.timeLabel.y = bottomY;
//    self.timeLabel.frame = (CGRect){
//        CGPointMake(leftMargin, bottomY),
//        timeSize
//    };
    ShipmentStopBean* stopBean = self.data;
    
    int pickupCount = stopBean.pickupCount; //生成0-15范围的随机数
    int deliverCount = stopBean.deliverCount; //生成0-15范围的随机数
    
    self.shipUintCountText.attributedString = [self generateShipUnitString:FlatOrange pickupCount:pickupCount deliverCount:deliverCount];
    self.shipUintCountText.size = [self.shipUintCountText measure:CGSizeMake(FLT_MAX, FLT_MAX)];//CGSize shipUnitSize =
    self.shipUintCountText.x = leftMargin;
    self.shipUintCountText.y = self.timeLabel.maxY + 5;
//    self.shipUintCountText.frame = (CGRect){
//        CGPointMake(leftMargin, CGRectGetMaxY(self.timeLabel.frame) + 5),
//        shipUnitSize
//    };
//    self.phoneButton.frame = CGRectMake(leftMargin + shipWidth, CGRectGetMaxY(self.timeLabel.frame), phoneWidth, phoneHeight);
    
    [self initActivityArea:bottomY cellWidth:cellWidth cellHeight:cellHeight];
    
    self.phoneButton.width = 30;
    self.phoneButton.height = 30;
//    self.phoneButton.backgroundColor = FlatBrownDark;
    self.phoneButton.maxX = self.activityButton.x - [TaskTripCell getMarginLeft];
    self.phoneButton.centerY = self.activityButton.centerY;
}

-(void)initActivityArea:(CGFloat)bottomY cellWidth:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight{
    CGFloat activityWidth = 85;
    CGFloat activityHeight = 30;
    
    ShipmentStopBean* stopBean = self.data;
    
    self.activityButton.fillColor = stopBean.isComplete ? COLOR_YI_WAN_CHENG : COLOR_DAI_WAN_CHENG;
    self.activityButton.title = stopBean.isComplete ? @"已完成" : @"未完成(1)";
    
    self.activityButton.frame = CGRectMake(cellWidth - activityWidth - [TaskTripCell getMarginLeft],bottomY + 5, activityWidth, activityHeight);
}

-(void)initRouteArea:(CGFloat)cellHeight{
    CGFloat marginLeft = [TaskTripCell getMarginLeft];
    
    ShipmentStopBean* stopBean = self.data;
    
    if (stopBean.isComplete) {
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:20                         content:ICON_YI_SHANG_BAO];
    }else{
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_DAI_WAN_CHENG size:20                         content:ICON_DAI_SHANG_BAO];
    }
    self.stateNode.size = [self.stateNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];//CGSize stateSize =
//    CGFloat containerWidth = CGRectGetWidth(self.bounds);
    CGFloat stateWidth = 20;
    self.stateNode.centerX = marginLeft + stateWidth / 2;
    self.stateNode.centerY = cellHeight / 2.;
//    self.stateNode.frame = (CGRect){
//        CGPointMake(marginLeft + (stateWidth - stateSize.width) / 2., (cellHeight - stateSize.height) / 2.),stateSize
//    };
    
    UIColor* indexColor;
    if (self.selected) {
        indexColor = FlatOrange;
    }else{
        indexColor = FlatGrayDark;
    }
    CGFloat indexWidth = 5;//20
//    self.indexNode.attributedString = [NSString simpleAttributedString:indexColor size:14 content:[NSString stringWithFormat:@"%li",(long)self.indexPath.row + 1]];
//    CGSize indexSize = [self.indexNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    self.indexNode.frame = (CGRect){
//        CGPointMake(marginLeft + stateWidth + (indexWidth - indexSize.width) / 2., (cellHeight - indexSize.height) / 2.),indexSize
//    };
    
    CGFloat routeW = 2;
    CGFloat routeH = cellHeight;
    CGFloat routeY = 0;
    CGFloat routeBaseX = marginLeft + stateWidth + indexWidth + 3;
    CGFloat radius;
    self.routeLine.hidden = NO;
    if (self.isFirst) {
        routeH = cellHeight * 1 / 2;
        routeY = cellHeight - routeH;
//        self.routeLine.topLeftRadius = routeW / 2.;
//        self.routeLine.topRightRadius = routeW / 2.;
//        self.routeLine.bottomLeftRadius = 0;
//        self.routeLine.bottomRightRadius = 0;
        radius = routeW + self.routeCircle.strokeWidth + 2;
    }else if(self.isLast){
        routeH = cellHeight * 1 / 2;
//        self.routeLine.topLeftRadius = 0;
//        self.routeLine.topRightRadius = 0;
//        self.routeLine.bottomLeftRadius = routeW / 2.;
//        self.routeLine.bottomRightRadius = routeW / 2.;
        radius = routeW + self.routeCircle.strokeWidth + 2;
    }else{
//        self.routeLine.topLeftRadius = self.routeLine.topRightRadius = self.routeLine.bottomLeftRadius = self.routeLine.bottomRightRadius = 0;
        radius = routeW + self.routeCircle.strokeWidth + 1;//routeW / 2. - 0.5;
    }
    self.routeLine.frame = CGRectMake(routeBaseX, routeY, routeW, routeH);
    
    self.routeCircle.fillColor = self.isFirst || self.isLast ? [UIColor whiteColor] : COLOR_LINE;
    self.routeCircle.strokeColor = self.isFirst || self.isLast ? COLOR_LINE : [UIColor whiteColor];
    self.routeCircle.cornerRadius = radius;
    self.routeCircle.frame = CGRectMake(routeBaseX + routeW / 2. - radius, cellHeight / 2. - radius, radius * 2, radius * 2);
    
    self.indicatorView.hidden = !self.selected;
    self.routeCircle.hidden = self.selected;
    if (!self.indicatorView.hidden) {
        CGSize carSize = self.indicatorView.bounds.size;
        self.indicatorView.x = routeBaseX + routeW / 2. - carSize.width / 3.;
        self.indicatorView.centerY = cellHeight / 2.;
//        self.indicatorView.frame = (CGRect){
//            CGPointMake(routeBaseX + routeW / 2. - carSize.width / 3., cellHeight / 2. - carSize.height / 2.),carSize
//        };
    }
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
