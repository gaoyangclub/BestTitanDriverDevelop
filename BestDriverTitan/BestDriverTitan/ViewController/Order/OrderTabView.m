//
//  OrderTabView.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/3/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderTabView.h"

@interface TabButton : UIControl{
}

@property(nonatomic,retain)ASTextNode* indexNode;
@property(nonatomic,retain)ASDisplayNode* square;

-(void)setIndex:(NSInteger)index;
-(void)setSelect:(BOOL)isSelect;

@end

@implementation TabButton

-(ASTextNode *)indexNode{
    if (!_indexNode) {
        _indexNode = [[ASTextNode alloc]init];
        _indexNode.layerBacked = YES;
        [self.layer addSublayer:_indexNode.layer];
    }
    return _indexNode;
}

-(ASDisplayNode *)square{
    if (!_square) {
        _square = [[ASDisplayNode alloc]init];
        _square.layerBacked = YES;
        [self.layer addSublayer:_square.layer];
    }
    return _square;
}

-(void)setIndex:(NSInteger)index{
    self.indexNode.attributedString = [NSString simpleAttributedString:FlatGrayDark size:20 content:[NSString stringWithFormat:@"%li",(long)index + 1]];
    CGSize indexSize = [self.indexNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.indexNode.frame = (CGRect){
        CGPointMake((CGRectGetWidth(self.bounds) - indexSize.width) / 2., (CGRectGetHeight(self.bounds) - indexSize.height) / 2.),indexSize
    };
}

-(void)setSelect:(BOOL)isSelect{
    self.square.backgroundColor = FlatYellowDark;
    if (isSelect) {
        self.backgroundColor = [UIColor clearColor];
        self.square.frame = CGRectMake(0, 0, 5, CGRectGetHeight(self.bounds));
    }else{
        self.backgroundColor = [UIColor whiteColor];
        self.square.frame = CGRectMake(0, 0, 2, CGRectGetHeight(self.bounds));
    }
}


@end

@interface OrderTabView(){
    NSInteger selectedIndex;
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

-(void)setSelectedIndex:(NSInteger)index{
    if (self->selectedIndex != index) {
        TabButton* btn = self.subviews[index];
        [self changeTabButton:btn isClick:NO];
    }
}

-(void)setTotalCount:(NSInteger)count{
    [self removeAllSubViews];
    
    CGFloat tabHeight = 60;
    CGFloat tabWidth = ORDER_TAB_WIDTH;
    
    self.contentSize = CGSizeMake(tabWidth, count * tabHeight);
    
    TabButton* selectBtn;
    for (NSInteger i = 0; i < count; i++) {
        TabButton* btn = [[TabButton alloc]init];
        btn.frame = CGRectMake(0, i * tabHeight, tabWidth, tabHeight);
        btn.tag = i;
        [self addSubview:btn];
        
        [btn setIndex:i];
        if (i == 0) {
            selectBtn = btn;
        }
        [btn addTarget:self action:@selector(clickTabButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self changeTabButton:selectBtn isClick:NO];
}

-(void)clickTabButton:(TabButton*)clickBtn{
    [self changeTabButton:clickBtn isClick:YES];
}

-(void)changeTabButton:(TabButton*)clickBtn isClick:(BOOL)isClick{
    self->selectedIndex = clickBtn.tag;
    for (TabButton* btn in self.subviews) {
        if ([btn respondsToSelector:@selector(setSelect:)]) {
            if (btn != clickBtn) {
                [btn setSelect:NO];
            }else{
                [btn setSelect:YES];
            }
        }
    }
    [self moveTabButton:clickBtn];
//    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_ADDRESS_SELECT object:[clickBtn getLabel]];
    if(isClick && self.tabDelegate && [self.tabDelegate respondsToSelector:@selector(didSelectIndex:)]){
        [self.tabDelegate didSelectIndex:self->selectedIndex];
    }
}

-(void)moveTabButton:(TabButton*)clickBtn{
    CGRect btnToSelf = [self convertRect:clickBtn.frame toView:self.superview];
    CGFloat moveY = btnToSelf.origin.y - CGRectGetHeight(self.bounds) / 2. + btnToSelf.size.height / 2.;
    CGPoint contentOffset = self.contentOffset;
    //    self.bottomAreaView.contentSize.width
    CGFloat maxOffsetY = self.contentSize.height - CGRectGetHeight(self.bounds);
    maxOffsetY = maxOffsetY > 0 ? maxOffsetY : 0;
    CGFloat moveOffsetY = contentOffset.y + moveY;
    if (moveOffsetY < 0) {
        moveOffsetY = 0;
    }else if(moveOffsetY > maxOffsetY){
        moveOffsetY = maxOffsetY;
    }
    [self setContentOffset:CGPointMake(contentOffset.x,moveOffsetY) animated:YES];
}


@end
