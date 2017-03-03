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
#import "DIYTabBarItem.h"
#import "CircleNode.h"

//站点信息按钮
@interface StopButton:UIControl{
    NSInteger stopIndex;
//    NSString* stopLabel;
}

@property(nonatomic,retain)ASTextNode* stateNode;
@property(nonatomic,retain)ASTextNode* labelNode1;
@property(nonatomic,retain)ASTextNode* labelNode2;
@property(nonatomic,retain)ASTextNode* labelNode3;
@property(nonatomic,retain)ASTextNode* indexNode;

-(void)setComplete:(BOOL)isComplete;
-(void)setIndex:(NSInteger)index;
-(void)setLabel:(NSString*)label;

-(void)setSelect:(BOOL)isSelect;

@end

@implementation StopButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
    }
    return self;
}

-(ASTextNode *)indexNode{
    if (!_indexNode) {
        _indexNode = [[ASTextNode alloc]init];
        _indexNode.layerBacked = YES;
        _indexNode.userInteractionEnabled = NO;
        [self.layer addSublayer:_indexNode.layer];
    }
    return _indexNode;
}

-(ASTextNode *)labelNode1{
    if (!_labelNode1) {
        _labelNode1 = [[ASTextNode alloc]init];
        _labelNode1.layerBacked = YES;
        [self.layer addSublayer:_labelNode1.layer];
    }
    return _labelNode1;
}
-(ASTextNode *)labelNode2{
    if (!_labelNode2) {
        _labelNode2 = [[ASTextNode alloc]init];
        _labelNode2.layerBacked = YES;
        [self.layer addSublayer:_labelNode2.layer];
    }
    return _labelNode2;
}
-(ASTextNode *)labelNode3{
    if (!_labelNode3) {
        _labelNode3 = [[ASTextNode alloc]init];
        _labelNode3.layerBacked = YES;
        [self.layer addSublayer:_labelNode3.layer];
    }
    return _labelNode3;
}

-(ASTextNode *)stateNode{
    if (!_stateNode) {
        _stateNode = [[ASTextNode alloc]init];
        _stateNode.layerBacked = YES;
        _stateNode.userInteractionEnabled = NO;
        [self.layer addSublayer:_stateNode.layer];
    }
    return _stateNode;
}

-(void)setComplete:(BOOL)isComplete{
    if (isComplete) {
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:20                         context:ICON_YI_SHANG_BAO];
    }else{
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_DAI_WAN_CHENG size:20                         context:ICON_DAI_SHANG_BAO];
    }
    CGSize stateSize = [self.stateNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    CGFloat containerWidth = CGRectGetWidth(self.bounds);
    self.stateNode.frame = (CGRect){
        CGPointMake((containerWidth - stateSize.width) / 2., 5),stateSize
    };
}

-(void)setIndex:(NSInteger)index{
    self->stopIndex = index;
    self.indexNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 context:[NSString stringWithFormat:@"%li",(long)index]];
    CGSize indexSize = [self.indexNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.indexNode.frame = (CGRect){
        CGPointMake((CGRectGetWidth(self.bounds) - indexSize.width) / 2., 30),indexSize
    };
}

-(void)setLabel:(NSString*)label{
//    self->stopLabel = label;
    
    NSInteger charGap = 15;
    NSMutableArray* array = [NSMutableArray array];
    for (int i = 0; i < 3; i ++) {
        BOOL isBreak = NO;
        NSUInteger len = charGap;
        if((i + 1) * charGap > label.length){//说明文字已经过了
            len = label.length % charGap;
            isBreak = YES;
        }
        NSString* substr = [label substringWithRange:NSMakeRange(i * charGap, len)];
        NSString* result = @"";
        for(int j = 0; j < substr.length; j++){
            NSString* echar = [substr substringWithRange:NSMakeRange(j, 1)];
            result = ConcatStrings(result, echar, @"\n");
        }
//        NSArray* a = [substr componentsSeparatedByString:@""];
//        substr = [a componentsJoinedByString:@"t"];
        [array addObject:result];
        if (isBreak) {
            break;
        }
    }
    CGFloat labelY = 65;
    CGFloat labelW = 15;
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    
    CGFloat baseX = (viewWidth - array.count * labelW) / 2.;
    
//    return;
    NSArray* nodes = @[self.labelNode1,self.labelNode2,self.labelNode3];
    
    int labelIndex = 0;
    for (NSString* substr in array) {
        ASTextNode* labelSubNode = nodes[labelIndex];//[[ASTextNode alloc]init];
//        labelSubNode.layerBacked = YES;
//        labelSubNode.userInteractionEnabled = NO;
//        [self.layer addSublayer:labelSubNode.layer];
        
//        labelSubNode.layerBacked = YES;
        labelSubNode.name = substr;
        labelSubNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 context:substr];
//        labelSubNode.backgroundColor = [UIColor flatPowderBlueColor];
//        CGFloat labelHeight = CGRectGetHeight(self.bounds) - labelY;
        CGSize labelSize = [labelSubNode measure:CGSizeMake(labelW, FLT_MAX)];
        labelSubNode.frame = (CGRect){
            CGPointMake(baseX + labelIndex * labelW, labelY),
            labelSize
        };
//        labelSubNode.frame = CGRectMake(0, labelY, labelW, 100);
//        [self.layer addSublayer:labelSubNode.layer];
        
        labelIndex ++;
    }
//
//    self.labelNode1.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 context:array[0]];
//    self.labelNode1.frame = CGRectMake(0, labelY, labelW, 100);
//    self.labelNode2.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 context:array[1]];
//    self.labelNode2.frame = CGRectMake(20, labelY, labelW, 100);
//    self.labelNode3.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 context:array[2]];
//    self.labelNode3.frame = CGRectMake(40, labelY, labelW, 100);
    
}

-(void)setSelect:(BOOL)isSelect{
    NSArray* nodes = @[self.labelNode1,self.labelNode2,self.labelNode3];
    if (isSelect) {
        self.indexNode.attributedString = [NSString simpleAttributedString:FlatOrangeDark size:14 context:[NSString         stringWithFormat:@"%li",self->stopIndex]];
        for (ASTextNode* labelNode in nodes) {
            if (labelNode.name) {
                labelNode.attributedString = [NSString simpleAttributedString:FlatOrangeDark size:14 context:labelNode.name];
            }
        }
    }else{
        self.indexNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 context:[NSString         stringWithFormat:@"%li",self->stopIndex]];
        for (ASTextNode* labelNode in nodes) {
            if (labelNode.name) {
                labelNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 context:labelNode.name];
            }
        }
    }
}

@end


@interface ActivityButton:UIControl

@property(nonatomic,retain)ASTextNode* iconNode;
@property(nonatomic,retain)ASTextNode* labelNode;
@property(nonatomic,retain)ASControlNode* alertNode;//警告货量差异
@property(nonatomic,retain)ASTextNode* stateNode;//完成情况状态
@property(nonatomic,retain)DIYBarData* data;//警告货量差异

-(void)showAlertNode;
-(void)hideAlertNode;

-(void)setComplete:(BOOL)isComplete;

//-(void)updateIconColor:(UIColor*)iconColor;

@end
@implementation ActivityButton

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.opaque = false;//坑爹 一定要关闭掉才有透明绘制和圆角
//    }
//    return self;
//}

-(ASControlNode *)alertNode{
    if (!_alertNode) {
        _alertNode = [[ASControlNode alloc]init];
        _alertNode.layerBacked = YES;
        _alertNode.userInteractionEnabled = NO;
        
        ASTextNode* alertIcon = [[ASTextNode alloc]init];
        alertIcon.layerBacked = YES;
        alertIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatYellow size:20 context:ICON_JING_GAO];
        CGSize alertSize = [alertIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        CGFloat padding = 5;
        alertIcon.frame = (CGRect){
            CGPointMake(CGRectGetWidth(self.bounds) - alertSize.width - padding, CGRectGetHeight(self.bounds) - alertSize.height - padding),alertSize
        };
        [_alertNode addSubnode:alertIcon];
        
        [self.layer addSublayer:_alertNode.layer];
    }
    return _alertNode;
}

-(ASTextNode *)stateNode{
    if (!_stateNode) {
        _stateNode = [[ASTextNode alloc]init];
        _stateNode.layerBacked = YES;
        _stateNode.userInteractionEnabled = NO;
        [self.layer addSublayer:_stateNode.layer];
    }
    return _stateNode;
}

-(void)setComplete:(BOOL)isComplete{
    if (isComplete) {
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:20                         context:ICON_YI_SHANG_BAO];
    }else{
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_DAI_WAN_CHENG size:20                         context:ICON_DAI_SHANG_BAO];
    }
    CGSize stateSize = [self.stateNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    CGFloat padding = 5;
    self.stateNode.frame = (CGRect){
        CGPointMake(CGRectGetWidth(self.bounds) - stateSize.width - padding, padding),stateSize
    };
}

//-(void)updateIconColor:(UIColor*)iconColor{
//    self.iconNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:30                         context:self.data.image];
////    CGSize labelSize = [self.labelNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
////    self.labelNode.frame = (CGRect){CGPointMake((buttonWidth - labelSize.width) / 2., buttonHeight / 2. + labelOffset),labelSize};
//}

-(void)showAlertNode{
    self.alertNode.hidden = NO;
    //加侦听器
    //点击展开货量差异提示
}

-(void)hideAlertNode{
    self.alertNode.hidden = YES;
//    self.alertNode removeTarget:<#(nullable id)#> action:<#(nullable SEL)#> forControlEvents:<#(ASControlNodeEvent)#>
    //移除侦听器
}

@end


@interface TaskTripCell(){
    NSMutableDictionary* buttonDic;//活动上报按钮访问列表
}

@property(nonatomic,retain) RoundRectNode* topAreaBack;
@property(nonatomic,retain) UIView* topAreaView;
@property(nonatomic,retain) UIScrollView* bottomAreaView;

@property(nonatomic,retain) RoundRectNode* bottomRouteLine;
@property(nonatomic,retain) UIView* bottomRouteGroup;

@end


@implementation TaskTripCell

-(UIView *)bottomRouteGroup{
    if (!_bottomRouteGroup) {
        _bottomRouteGroup = [[UIView alloc]init];
//        _bottomRouteGroup.layerBacked = YES;
        [self.bottomAreaView addSubview:_bottomRouteGroup];
    }
    return _bottomRouteGroup;
}

-(RoundRectNode *)bottomRouteLine{
    if (!_bottomRouteLine) {
        _bottomRouteLine = [[RoundRectNode alloc]init];
        _bottomRouteLine.layerBacked = YES;
//        [self.bottomAreaView addSubnode:_bottomRouteLine];
        [self.bottomAreaView.layer addSublayer:_bottomRouteLine.layer];
    }
    return _bottomRouteLine;
}

-(UIScrollView *)bottomAreaView{
    if (!_bottomAreaView) {
        _bottomAreaView = [[UIScrollView alloc]init];
//        _bottomAreaView.layerBacked = YES;
//        [self.contentView.layer addSublayer:_bottomAreaView.layer];
        [self.contentView addSubview:_bottomAreaView];
    }
    return _bottomAreaView;
}

-(UIView *)topAreaView{
    if (!_topAreaView) {
        _topAreaView = [[UIView alloc]init];
        [self.contentView addSubview:_topAreaView];
    }
    return _topAreaView;
}

-(RoundRectNode *)topAreaBack{
    if (!_topAreaBack) {
        _topAreaBack = [[RoundRectNode alloc]init];
        _topAreaBack.fillColor = [UIColor whiteColor];
        _topAreaBack.cornerRadius = 5;
        _topAreaBack.layerBacked = YES;
        [self.topAreaView.layer addSublayer:_topAreaBack.layer];
    }
    return _topAreaBack;
}

-(void)initTopArea:(CGFloat)backWidth{
    if (!buttonDic) {
        CGFloat buttonWidth = backWidth / 3.;
        CGFloat buttonHeight = 65;
        CGFloat padding = 5;//内边距
        CGFloat iconOffset = -25;
        CGFloat labelOffset = 10;
        
        buttonDic = [[NSMutableDictionary alloc]init];
        
        //6个活动上报按钮
        NSArray<DIYBarData *>* dataArray = @[[DIYBarData initWithParams:TABBAR_TITLE_TI_HUO image:ICON_TI_HUO],
                                             [DIYBarData initWithParams:TABBAR_TITLE_ZHUANG_CHE image:ICON_ZHUANG_CHE],
                                             [DIYBarData initWithParams:TABBAR_TITLE_XIE_HUO image:ICON_XIE_HUO],
                                             [DIYBarData initWithParams:TABBAR_TITLE_QIAN_SHOU image:ICON_QIAN_SHOU],
                                             [DIYBarData initWithParams:TABBAR_TITLE_HUI_DAN image:ICON_HUI_DAN],
                                             [DIYBarData initWithParams:TABBAR_TITLE_SHOU_KUAN image:ICON_SHOU_KUAN],
                                          ];
        //2行3列
        for(int i = 0 ; i < dataArray.count ; i ++){
            DIYBarData* data = dataArray[i];
            
            ActivityButton* btn = [[ActivityButton alloc]init];
            [btn setShowTouch:YES];
            btn.data = data;
//            btn.layerBacked = YES;
            [self.topAreaView addSubview:btn];
            btn.frame = CGRectMake((i % 3) * buttonWidth, (i / 3) * buttonHeight, buttonWidth, buttonHeight);
            
            ASTextNode* iconNode = btn.iconNode = [[ASTextNode alloc]init];
            iconNode.layerBacked = YES;
            iconNode.userInteractionEnabled = NO;
            [btn.layer addSublayer:iconNode.layer];
            iconNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatPowderBlueDark size:30                         context:data.image];
            CGSize iconSize = [iconNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
            iconNode.frame = (CGRect){CGPointMake((buttonWidth - iconSize.width) / 2., buttonHeight / 2. + iconOffset),iconSize};
            
            ASTextNode* labelNode = btn.labelNode = [[ASTextNode alloc]init];
            labelNode.layerBacked = YES;
            labelNode.userInteractionEnabled = NO;
            [btn.layer addSublayer:labelNode.layer];
            labelNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:12 context:data.title];
            CGSize labelSize = [labelNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
            labelNode.frame = (CGRect){CGPointMake((buttonWidth - labelSize.width) / 2., buttonHeight / 2. + labelOffset),labelSize};
            
            [buttonDic setValue:btn forKey:data.title];
            
            if (i % 3 == 0) {//横向的线
                ASDisplayNode* lineTopY = [[ASDisplayNode alloc]init];
                lineTopY.backgroundColor = COLOR_LINE;
                lineTopY.layerBacked = YES;
                lineTopY.frame = CGRectMake(padding, (i / 3 + 1) * buttonHeight - LINE_WIDTH / 2., backWidth - padding * 2, LINE_WIDTH);
                [self.topAreaBack addSubnode:lineTopY];
            }else{
                ASDisplayNode* lineTopX = [[ASDisplayNode alloc]init];
                lineTopX.backgroundColor = COLOR_LINE;
                lineTopX.layerBacked = YES;
                lineTopX.frame = CGRectMake((i % 3) * buttonWidth - LINE_WIDTH / 2., (i / 3) * buttonHeight + padding, LINE_WIDTH , buttonHeight - padding * 2);
                [self.topAreaBack addSubnode:lineTopX];
            }
        }
    }
}

////更新文字颜色
//+(void)updateAttributedColor:(NSMutableAttributedString*)attributedString  color:(UIColor*)color{
////    [attributedString removeAttribute:NSForegroundColorAttributeName range:NSMakeRange(0, attributedString.length)];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributedString.length)];
//    nsconcrete
//}

//底部站点列表(Stop)
-(void)initBottomArea:(CGFloat)scrollerHeight{
    CGFloat routeY = 50;
    CGFloat routeH = 5;
    CGFloat padding = 20;
    CGFloat itemWidth = 80;
    CGFloat btnWidth = itemWidth - 30;
    //绘制背景长条
    int count = (arc4random() % 10) + 2; //生成0-2范围的随机数
    
    CGFloat contentWidth = itemWidth * (count - 1) + padding * 4;
    
    self.bottomAreaView.contentSize = CGSizeMake(contentWidth, scrollerHeight);
    
    self.bottomRouteLine.frame = CGRectMake(padding, routeY, itemWidth * (count - 1) + padding * 2, routeH);
    self.bottomRouteLine.cornerRadius = routeH / 2.;
    self.bottomRouteLine.fillColor = FlatGrayDark;
    [self.bottomRouteLine removeAllSubNodes];
    
    
    CGFloat groupHeight = scrollerHeight - routeY - routeH;
    self.bottomRouteGroup.frame = CGRectMake(0, 0, contentWidth, groupHeight);
    [self.bottomRouteGroup removeAllSubViews];
    
    CGFloat radius = routeH / 2. - 0.5;
    for (NSInteger i = 0; i < count; i ++) {//添加白点
        CircleNode* circle = [[CircleNode alloc]init];
        circle.layerBacked = YES;
        circle.fillColor = [UIColor flatWhiteColor];
        circle.cornerRadius = radius;
        circle.frame = CGRectMake(padding + i * itemWidth - radius, (routeH - radius * 2) / 2., radius * 2, radius * 2);
        [self.bottomRouteLine addSubnode:circle];
        
        
        StopButton* btn = [[StopButton alloc]init];
        [self.bottomRouteGroup addSubview:btn];
//        btn.backgroundColor = [UIColor brownColor];
        btn.frame = CGRectMake(padding * 2 + i * itemWidth - btnWidth / 2., 0, btnWidth, groupHeight);
        btn.userInteractionEnabled = YES;
        [btn setIndex:i + 1];
        [btn setLabel:@"上海上海市松江区上海上海市松江区大港镇松镇公路1339号宝湾物流112号库"];//😭
        
        int completeCount = (arc4random() % 3);
        [btn setComplete:completeCount == 0];
        
        if (i == 0) {
            [btn setSelect:YES];
        }
        [btn addTarget:self action:@selector(changeRouteButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self checkButtonStates];
}

-(void)changeRouteButton:(StopButton*)clickBtn{
    for (StopButton* btn in self.bottomRouteGroup.subviews) {
        if (btn != clickBtn) {
            [btn setSelect:NO];
        }else{
            [btn setSelect:YES];
        }
    }
    [self checkButtonStates];
}

-(void)checkButtonStates{
    for (NSString *key in buttonDic) {
        ActivityButton* btn = buttonDic[key];
        int count = (arc4random() % 4); //生成0-2范围的随机数
        if (count > 0) {
            if (count > 1) {
                //                [btn updateIconColor:COLOR_PRIMARY];
                [btn setComplete:YES];
                if (count > 2) {
                    [btn showAlertNode];
                }
            }else{
                //                [btn updateIconColor:COLOR_PRIMARY];
                [btn setComplete:NO];
            }
            btn.stateNode.hidden = NO;
            [btn setShowTouch:YES];
            //            btn.userInteractionEnabled = YES;
            btn.alpha = 1;
        }else{
            //            [btn updateIconColor:FlatGray];
            btn.stateNode.hidden = YES;
            [btn setShowTouch:NO];
            //            btn.userInteractionEnabled = NO;//无法交互
            btn.alpha = 0.3;
            [btn hideAlertNode];
        }
    }
}

-(void)showSubviews{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat cellHeight = self.contentView.bounds.size.height;
    CGFloat cellWidth = self.contentView.bounds.size.width;
    
    CGFloat leftMargin = 10;
    CGFloat topMargin = 5;
    
    CGFloat backWidth = cellWidth - leftMargin * 2;
    CGFloat backHeight = 175;
    
    self.topAreaView.frame = CGRectMake(leftMargin, topMargin, backWidth, backHeight);
    self.topAreaBack.frame = self.topAreaView.bounds;
    [self initTopArea:backWidth];
    
    CGFloat scrollerHeight = cellHeight - backHeight - topMargin;
    self.bottomAreaView.frame = CGRectMake(0, topMargin + backHeight, cellWidth, scrollerHeight);
//    self.bottomAreaView.backgroundColor = [UIColor brownColor];
    
    [self initBottomArea:scrollerHeight];
    
}



@end
