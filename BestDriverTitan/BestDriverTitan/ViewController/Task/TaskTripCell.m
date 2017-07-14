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

//站点信息按钮
@interface StopButton:UIControl{
    NSInteger stopIndex;
    NSString* stopLabel;
}

@property(nonatomic,retain)ASTextNode* stateNode;
@property(nonatomic,retain)ASTextNode* labelNode1;
@property(nonatomic,retain)ASTextNode* labelNode2;
@property(nonatomic,retain)ASTextNode* labelNode3;
@property(nonatomic,retain)ASTextNode* indexNode;

-(void)setComplete:(BOOL)isComplete;
-(void)setIndex:(NSInteger)index;
-(void)setLabel:(NSString*)label;
-(NSString *)getLabel;

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
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:20                         content:ICON_YI_SHANG_BAO];
    }else{
        self.stateNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_DAI_WAN_CHENG size:20                         content:ICON_DAI_SHANG_BAO];
    }
    CGSize stateSize = [self.stateNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    CGFloat containerWidth = CGRectGetWidth(self.bounds);
    self.stateNode.frame = (CGRect){
        CGPointMake((containerWidth - stateSize.width) / 2., 5),stateSize
    };
}

-(void)setIndex:(NSInteger)index{
    self->stopIndex = index;
    self.indexNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 content:[NSString stringWithFormat:@"%li",(long)index]];
    CGSize indexSize = [self.indexNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.indexNode.frame = (CGRect){
        CGPointMake((CGRectGetWidth(self.bounds) - indexSize.width) / 2., 30),indexSize
    };
}

-(NSString*)getLabel{
    return self->stopLabel;
}

-(void)setLabel:(NSString*)label{
    self->stopLabel = label;
    
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
        labelSubNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 content:substr];
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
        self.indexNode.attributedString = [NSString simpleAttributedString:FlatOrangeDark size:14 content:[NSString         stringWithFormat:@"%li",(long)self->stopIndex]];
        for (ASTextNode* labelNode in nodes) {
            if (labelNode.name) {
                labelNode.attributedString = [NSString simpleAttributedString:FlatOrangeDark size:14 content:labelNode.name];
            }
        }
    }else{
        self.indexNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 content:[NSString         stringWithFormat:@"%li",(long)self->stopIndex]];
        for (ASTextNode* labelNode in nodes) {
            if (labelNode.name) {
                labelNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:14 content:labelNode.name];
            }
        }
    }
}

@end



@interface TaskTripCell(){
    
}

@property(nonatomic,retain) UIScrollView* bottomAreaView;

@property(nonatomic,retain) RoundRectNode* bottomRouteLine;
@property(nonatomic,retain) ASTextNode* carView;
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

-(ASTextNode *)carView{
    if (!_carView) {
        _carView = [[ASTextNode alloc]init];
        _carView.layerBacked = YES;
        [self.bottomAreaView.layer addSublayer:_carView.layer];
    }
    return _carView;
}

-(UIScrollView *)bottomAreaView{
    if (!_bottomAreaView) {
        _bottomAreaView = [[UIScrollView alloc]init];
//        _bottomAreaView.backgroundColor = [UIColor grayColor];
//        _bottomAreaView.layerBacked = YES;
//        [self.contentView.layer addSublayer:_bottomAreaView.layer];
        [self.contentView addSubview:_bottomAreaView];
    }
    return _bottomAreaView;
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
    
    NSMutableArray<ShipmentStopBean*>* stopArr = self.data;
    
    NSInteger count = stopArr.count;
    
    CGFloat contentWidth = itemWidth * (count - 1) + padding * 4;
    
    self.bottomAreaView.contentSize = CGSizeMake(contentWidth, scrollerHeight);
    
    self.bottomRouteLine.frame = CGRectMake(padding, routeY, itemWidth * (count - 1) + padding * 2, routeH);
    self.bottomRouteLine.cornerRadius = routeH / 2.;
    self.bottomRouteLine.fillColor = FlatGrayDark;
    [self.bottomRouteLine removeAllSubNodes];
    
    int selectIndex = arc4random() % count;
//    int carIndex = selectIndex - 1;//> 0 ? selectIndex - 1 : 0; //生成1-(count-1)范围的随机数
    
    self.carView.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_PRIMARY size:25 content:ICON_KA_CHE];
    CGSize carSize = [self.carView measure:CGSizeMake(FLT_MAX, FLT_MAX)];//FlatPowderBlueDark
    CGFloat carX;
    if (selectIndex > 0) {
        carX = padding * 2 + (selectIndex - 1) * itemWidth + (itemWidth - carSize.width) / 2.;
    }else{
        carX = (padding * 2 - carSize.width) / 2.;
    }
    
    self.carView.frame = (CGRect){
        CGPointMake(carX, routeY - carSize.height),
        carSize
    };
    
    CGFloat groupHeight = scrollerHeight - routeY - routeH;
    self.bottomRouteGroup.frame = CGRectMake(0, 0, contentWidth, groupHeight);
    [self.bottomRouteGroup removeAllSubViews];
    
    CGFloat radius = routeH / 2. - 0.5;
    StopButton* selectBtn;
    for (NSInteger i = 0; i < count; i ++) {//添加白点
        ShipmentStopBean* bean = stopArr[i];
        
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
        [btn setLabel:bean.shortAddress];
//        [btn setLabel:ConcatStrings(@"上海上海市松江区上海上海市松江区大港镇松镇公路1339号宝湾物流112号库",[NSString stringWithFormat:@"%li",(long)i])];//😭
        
//        int completeCount = (arc4random() % 3);
        [btn setComplete:bean.isComplete];
        btn.tag = i;
        
        if (i == selectIndex) {
            selectBtn = btn;
        }
        [btn addTarget:self action:@selector(changeRouteButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self changeRouteButton:selectBtn];
}

-(void)changeRouteButton:(StopButton*)clickBtn{
    for (StopButton* btn in self.bottomRouteGroup.subviews) {
        if (btn != clickBtn) {
            [btn setSelect:NO];
        }else{
            [btn setSelect:YES];
        }
    }
    
    [self moveRouteButton:clickBtn];
    
    NSMutableArray<ShipmentStopBean*>* stopArr = self.data;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_ADDRESS_SELECT object:stopArr[clickBtn.tag]];
}

-(void)moveRouteButton:(StopButton*)clickBtn{
    CGRect btnToSelf = [self.bottomRouteGroup convertRect:clickBtn.frame toView:self];
    CGFloat moveX = btnToSelf.origin.x - CGRectGetWidth(self.bounds) / 2. + btnToSelf.size.width / 2.;
    CGPoint contentOffset = self.bottomAreaView.contentOffset;
    //    self.bottomAreaView.contentSize.width
    CGFloat maxOffsetX = self.bottomAreaView.contentSize.width - CGRectGetWidth(self.bottomAreaView.bounds);
    maxOffsetX = maxOffsetX > 0 ? maxOffsetX : 0;
    CGFloat moveOffsetX = contentOffset.x + moveX;
    if (moveOffsetX < 0) {
        moveOffsetX = 0;
    }else if(moveOffsetX > maxOffsetX){
        moveOffsetX = maxOffsetX;
    }
    [self.bottomAreaView setContentOffset:CGPointMake(moveOffsetX,contentOffset.y) animated:YES];
}

-(void)showSubviews{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat cellHeight = self.contentView.bounds.size.height;
    CGFloat cellWidth = self.contentView.bounds.size.width;
    
//    CGFloat leftMargin = 10;
    CGFloat topMargin = 5;
    
//    CGFloat backWidth = cellWidth - leftMargin * 2;
//    CGFloat backHeight = 175;
    
    CGFloat scrollerHeight = cellHeight - topMargin;
    self.bottomAreaView.frame = CGRectMake(0, topMargin, cellWidth, scrollerHeight);
//    self.bottomAreaView.backgroundColor = [UIColor brownColor];
    
    [self initBottomArea:scrollerHeight];
    
}



@end
