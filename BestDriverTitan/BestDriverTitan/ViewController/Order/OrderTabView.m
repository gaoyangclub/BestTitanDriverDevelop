//
//  OrderTabView.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/3/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderTabView.h"
#import "CircleNode.h"
#import "RoundRectNode.h"

//#define TAB_SELECT_COLOR FlatOrange

@interface TabButton : UIControl{
    
}

@property(nonatomic,retain)ASTextNode* titleNode;
@property(nonatomic,retain)ASTextNode* statusNode;
//@property(nonatomic,retain)ASDisplayNode* square;
@property(nonatomic,retain)RoundRectNode* backNode;
@property(nonatomic,retain)ShipmentActivityBean* activityBean;


//@property(nonatomic,retain)CircleNode* leftLine;
//@property(nonatomic,retain)CircleNode* rightLine;


//-(void)setIndex:(NSInteger)index;
//-(void)setTitle:(NSString*)title;
-(void)setSelect:(BOOL)isSelect;
//-(void)setActivity:(ShipmentActivityBean*)bean;

@end

@implementation TabButton

-(ASTextNode *)statusNode{
    if (!_statusNode) {
        _statusNode = [[ASTextNode alloc]init];
        _statusNode.layerBacked = YES;
        [self.layer addSublayer:_statusNode.layer];
    }
    return _statusNode;
}

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        [self.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

//-(ASDisplayNode *)square{
//    if (!_square) {
//        _square = [[ASDisplayNode alloc]init];
//        _square.layerBacked = YES;
//        _square.backgroundColor = COLOR_BLACK_ORIGINAL;
//        [self.layer addSublayer:_square.layer];
//    }
//    return _square;
//}

-(RoundRectNode *)backNode{
    if (!_backNode) {
        _backNode = [[RoundRectNode alloc]init];
        _backNode.layerBacked = YES;
        _backNode.fillColor = [UIColor whiteColor];
        _backNode.strokeColor = COLOR_LINE;
        _backNode.strokeWidth = 1;
        _backNode.cornerRadius = 5;
        [self.layer addSublayer:_backNode.layer];
    }
    return _backNode;
}

//-(CircleNode *)leftLine{
//    if (!_leftLine) {
//        _leftLine = [[CircleNode alloc]init];
//        _leftLine.layerBacked = YES;
//        _leftLine.fillColor = COLOR_LINE;
//        [self.layer addSublayer:_leftLine.layer];
//    }
//    return _leftLine;
//}
//
//-(CircleNode *)rightLine{
//    if (!_rightLine) {
//        _rightLine = [[CircleNode alloc]init];
//        _rightLine.layerBacked = YES;
//        _rightLine.fillColor = COLOR_LINE;
//        [self.layer addSublayer:_rightLine.layer];
//    }
//    return _rightLine;
//}

//-(void)setIndex:(NSInteger)index{
//    self.indexNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:18 content:[NSString stringWithFormat:@"%li",(long)index + 1]];
//    CGSize indexSize = [self.indexNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    self.indexNode.frame = (CGRect){
//        CGPointMake((CGRectGetWidth(self.bounds) - indexSize.width) / 2., (CGRectGetHeight(self.bounds) - indexSize.height) / 2.),indexSize
//    };
//}

//-(void)setTitle:(NSString *)title{
//    
//    self.indexNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:FlatGray size:14 content:title];
//    CGSize indexSize = [self.indexNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    self.indexNode.frame = (CGRect){
//        CGPointMake((CGRectGetWidth(self.bounds) - indexSize.width) / 2., (CGRectGetHeight(self.bounds) - indexSize.height) / 2.),indexSize
//    };
//}

-(void)setActivityBean:(ShipmentActivityBean *)activityBean{
    _activityBean = activityBean;
    
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.bounds);
    
    CGFloat backLeftMargin = 5;
    CGFloat backTopMargin = 5;
    
    self.backNode.frame = CGRectMake(backLeftMargin, backTopMargin, viewWidth - backLeftMargin * 2, viewHeight - backTopMargin * 2);
    
    NSString* content = [Config getActivityLabelByCode:activityBean.activityDefinitionCode];
    
    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:content];
    CGSize titleSize = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    
    __weak __typeof(self) weakSelf = self;
    [[activityBean rac_valuesForKeyPath:@"status" observer:nil] subscribeNext:^(id x) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        UIColor* statusColor;
        NSString* statusIcon;
        if ([activityBean hasReport]) {
            statusColor = COLOR_YI_WAN_CHENG;
            statusIcon = ICON_YI_SHANG_BAO;
        }else{
            statusColor = COLOR_DAI_WAN_CHENG;
            statusIcon = ICON_DAI_SHANG_BAO;
        }
        strongSelf.statusNode.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:statusColor size:20 content:statusIcon];
        CGSize statusSize = [self.statusNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
        CGFloat gap = 5;
        CGFloat baseX = (viewWidth - titleSize.width - statusSize.width - gap) / 2.;
        strongSelf.statusNode.frame = (CGRect){
            CGPointMake(baseX, (viewHeight - statusSize.height) / 2.),statusSize
        };
        strongSelf.titleNode.frame = (CGRect){
            CGPointMake(baseX + statusSize.width + gap, (viewHeight - titleSize.height) / 2.),titleSize
        };
    }];
    self.backgroundColor = [UIColor whiteColor];
}

-(void)setSelect:(BOOL)isSelect{
//    NSString* content = [Config getActivityLabelByCode:self.activityBean.activityDefinitionCode];
    if (isSelect) {
        self.backNode.fillColor = self.backNode.strokeColor;//COLOR_BACKGROUND;
//        self.titleNode.attributedString = [NSString simpleAttributedString:[UIColor whiteColor] size:14 content:content];
    }else{
        self.backNode.fillColor = [UIColor whiteColor];
//        self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:content];
    }
}


@end

@interface OrderTabView(){
//    NSInteger selectedIndex;
    BOOL needCheckMoveToCenter;
}

@end
@implementation OrderTabView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)init{
    self = [super init];
    if (self) {
        self->_selectedIndex = -1;//默认不选中
    }
    return self;
}

-(void)setSelectedIndex:(NSInteger)index{
    if (self->_selectedIndex != index) {
        TabButton* btn = self.subviews[index];
        [self changeTabButton:btn isClick:NO];
    }
}

-(void)layoutSubviews{
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    CGFloat contentWidth = self.contentSize.width;
    if (contentWidth < viewWidth) {
        UIEdgeInsets contentInset = self.contentInset;
        contentInset.left = (viewWidth - contentWidth) / 2;
        self.contentInset = contentInset;
    }else{
        if (self->needCheckMoveToCenter && self->_selectedIndex >= 0 && self->_selectedIndex < self.subviews.count) {
            self->needCheckMoveToCenter = NO;
            UIView* clickBtn = self.subviews[self->_selectedIndex];
            [self moveTabButton:clickBtn];
        }
    }
}

-(void)setActivityBeans:(NSArray<ShipmentActivityBean *> *)activityBeans{
    _activityBeans = activityBeans;
    
    [self removeAllSubViews];
    
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat tabHeight = ORDER_TAB_HEIGHT;
    CGFloat tabWidth = ORDER_TAB_WIDTH;
    
    NSInteger count = activityBeans.count;
    
    CGFloat contentWidth = count * tabWidth;
    
    self.contentSize = CGSizeMake(contentWidth, tabHeight);
    
//    TabButton* selectBtn;
    for (NSInteger i = 0; i < count; i++) {
        ShipmentActivityBean* bean = activityBeans[i];
        
        TabButton* btn = [[TabButton alloc]init];
        btn.frame = CGRectMake(i * tabWidth, 0, tabWidth, tabHeight);
        btn.tag = i;
        [self addSubview:btn];
        
        btn.activityBean = bean;
//        if (i == 0) {
//            selectBtn = btn;
//        }
        [btn addTarget:self action:@selector(clickTabButton:) forControlEvents:UIControlEventTouchUpInside];
    }
//    [self changeTabButton:selectBtn isClick:NO];
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

-(void)refreshActivityByIndex:(NSInteger)index{
    if (index < self.subviews.count && index < self.activityBeans.count) {
        TabButton* btn = self.subviews[index];
        ShipmentActivityBean* bean = self.activityBeans[index];
        btn.activityBean = bean;
    }
}

//-(void)setTotalCount:(NSInteger)count{
//    [self removeAllSubViews];
//    
//    CGFloat tabHeight = ORDER_TAB_HEIGHT;
//    CGFloat tabWidth = ORDER_TAB_WIDTH;
//    
//    self.contentSize = CGSizeMake(count * tabWidth, tabHeight);
//    
//    TabButton* selectBtn;
//    for (NSInteger i = 0; i < count; i++) {
//        TabButton* btn = [[TabButton alloc]init];
//        btn.frame = CGRectMake(i * tabWidth, 0, tabWidth, tabHeight);
//        btn.tag = i;
//        [self addSubview:btn];
//        
//        [btn setIndex:i];
//        if (i == 0) {
//            selectBtn = btn;
//        }
//        [btn addTarget:self action:@selector(clickTabButton:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    [self changeTabButton:selectBtn isClick:NO];
//    
////    self.canCancelContentTouches = NO;
//    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//}

-(void)clickTabButton:(TabButton*)clickBtn{
    if (!self.tabDelegate || (self.tabDelegate &&
                    [self.tabDelegate respondsToSelector:@selector(shouldSelectIndex:)] &&
                    [self.tabDelegate shouldSelectIndex:clickBtn.tag])) {
        [self changeTabButton:clickBtn isClick:YES];
    }
}

-(void)changeTabButton:(TabButton*)clickBtn isClick:(BOOL)isClick{
    if (self->_selectedIndex == clickBtn.tag) {
        return;//已经选中不需要在触发
    }
    self->_selectedIndex = clickBtn.tag;
    for (TabButton* btn in self.subviews) {
        if ([btn respondsToSelector:@selector(setSelect:)]) {
            if (btn != clickBtn) {
                [btn setSelect:NO];
            }else{
                [btn setSelect:YES];
            }
        }
    }
//    [self moveTabButton:clickBtn];
//    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_ADDRESS_SELECT object:[clickBtn getLabel]];
    if(isClick && self.tabDelegate){
        if ([self.tabDelegate respondsToSelector:@selector(didSelectIndex:)]) {
            [self.tabDelegate didSelectIndex:self->_selectedIndex];
        }
    }
    if ([self.tabDelegate respondsToSelector:@selector(didSelectItem:)]) {
        [self.tabDelegate didSelectItem:_activityBeans[self->_selectedIndex]];
    }
    self->needCheckMoveToCenter = YES;
    [self setNeedsLayout];
}

-(void)moveTabButton:(UIView*)clickBtn{
    CGFloat viewWidth = CGRectGetWidth(self.bounds);
    CGRect btnToSelf = [self convertRect:clickBtn.frame toView:self.superview];
    CGFloat moveX = btnToSelf.origin.x - viewWidth / 2. + btnToSelf.size.width / 2.;
    CGPoint contentOffset = self.contentOffset;
    //    self.bottomAreaView.contentSize.width
    CGFloat maxOffsetX = self.contentSize.width - viewWidth;
    maxOffsetX = maxOffsetX > 0 ? maxOffsetX : 0;
    CGFloat moveOffsetX = contentOffset.x + moveX;
    if (moveOffsetX < 0) {
        moveOffsetX = 0;
    }else if(moveOffsetX > maxOffsetX){
        moveOffsetX = maxOffsetX;
    }
    [self setContentOffset:CGPointMake(moveOffsetX,contentOffset.y) animated:YES];
}

//-(void)moveTabButton:(TabButton*)clickBtn{
//    CGRect btnToSelf = [self convertRect:clickBtn.frame toView:self.superview];
//    CGFloat moveY = btnToSelf.origin.y - CGRectGetHeight(self.bounds) / 2. + btnToSelf.size.height / 2.;
//    CGPoint contentOffset = self.contentOffset;
//    //    self.bottomAreaView.contentSize.width
//    CGFloat maxOffsetY = self.contentSize.height - CGRectGetHeight(self.bounds);
//    maxOffsetY = maxOffsetY > 0 ? maxOffsetY : 0;
//    CGFloat moveOffsetY = contentOffset.y + moveY;
//    if (moveOffsetY < 0) {
//        moveOffsetY = 0;
//    }else if(moveOffsetY > maxOffsetY){
//        moveOffsetY = maxOffsetY;
//    }
//    [self setContentOffset:CGPointMake(contentOffset.x,moveOffsetY) animated:YES];
//}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    
//    static UIEvent *e = nil;
//    
//    if (e != nil && e == event) {
//        e = nil;
//        return [super hitTest:point withEvent:event];
//    }
//    
//    e = event;
//    
//    if (event.type == UIEventTypeTouches) {
//        NSSet *touches = [event touchesForView:self];
//        UITouch *touch = [touches anyObject];
//        if (touch.phase == UITouchPhaseBegan) {
//            NSLog(@"Touches began");
//            [self touchesBegan:touches withEvent:event];
//        }else if(touch.phase == UITouchPhaseEnded){
//            NSLog(@"Touches Ended");
//            
//        }else if(touch.phase == UITouchPhaseCancelled){
//            NSLog(@"Touches Cancelled");
//            
//        }else if (touch.phase == UITouchPhaseMoved){
//            NSLog(@"Touches Moved");
//            
//        }
//    }
//    return [super hitTest:point withEvent:event];
//}
//
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
    if (![self isMemberOfClass:[UIScrollView class]]) {
        
    } else {
        [[self nextResponder] touchesBegan:touches withEvent:event];
        if ([super respondsToSelector:@selector(touchesBegan:withEvent:)]) {
            [super touchesBegan:touches withEvent:event];
        }
    }
    
}

@end
