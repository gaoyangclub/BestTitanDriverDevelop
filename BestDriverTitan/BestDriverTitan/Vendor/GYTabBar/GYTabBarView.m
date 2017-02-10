//
//  GYTabBarView.m
//  CustomTabViewController
//
//  Created by admin on 16/10/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "GYTabBarView.h"
#import "GYTabBarItem.h"

@interface GYTabBarView(){
    BOOL changeData;
    Class _itemClass;
}
@end

@implementation GYTabBarView

-(Class)itemClass{
    if (!_itemClass) {
        _itemClass = [GYTabBarItem class];
    }
    return _itemClass;
}

-(void)setItemClass:(Class)itemClass{
    if (_itemClass != itemClass) {
        _itemClass = itemClass;
        changeData = YES;
        [self setNeedsLayout];
    }
}

-(void)setDataArray:(NSArray<TabData *> *)dataArray{
    _dataArray = dataArray;
    changeData = YES;
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    if (changeData) {//重新创建界面
        changeData = NO;
        [self refreshSubViews];
    }
    [self measure];
    [super layoutSubviews];
}
/**
 *  删除原有子对象 创建新对象
 */
-(void)refreshSubViews{
    if(!_dataArray || _dataArray.count == 0){
        return;//无数据
    }
    [self removeAllSubViews];
    NSInteger count = _dataArray.count;
//    CGFloat subW = CGRectGetWidth(self.bounds) / (CGFloat)count;
    
    GYTabBarItem *selectItem = nil;
    for (NSInteger i = 0; i < count; i++) {
        GYTabBarItem *itemView = [[self.itemClass alloc]init];
        itemView.itemIndex = i;
//        itemView.selected = i == self.selectedIndex;//直接选中
        if (i == self.selectedIndex) {
            selectItem = itemView;
        }
        itemView.data = _dataArray[i].data;
        itemView.badgeValue = [self getBadgeValue:_dataArray[i].badge];
        [self addSubview:itemView];
        [itemView addTarget:self action:@selector(tabSelectHandler:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self tabSelectHandler:selectItem];//默认就触发选中
}

-(NSString*)getBadgeValue:(NSInteger)badge{
    if (badge <= 0) {
        return nil;
    }
    if (badge <= 99) {
        return [NSString stringWithFormat:@"%ld",(long)badge];
    }
    return @"99+";
}

-(void)tabSelectHandler:(GYTabBarItem*)itemView{
    self.selectedIndex = itemView.itemIndex;
    for (GYTabBarItem* itemView in self.subviews) {
        itemView.selected = self.selectedIndex == itemView.itemIndex;//直接选中
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItem:tabData:index:)]) {
        [self.delegate didSelectItem:self tabData:_dataArray[self.selectedIndex] index:self.selectedIndex];
    }
}

/** 删除所有的子视图 */
-(void)removeAllSubViews{
    if(self.subviews.count == 0){
        return;
    }
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
}

/**
 重新对所有子对象布局
 */
-(void)measure{
    NSInteger count = self.subviews.count;
    CGFloat subW = CGRectGetWidth(self.bounds) / (CGFloat)count;//[NSNumber numberWithInteger:count].floatValue;
    for (NSInteger i = 0; i < count; i++) {
        GYTabBarItem *itemView = self.subviews[i];
//        itemView.backgroundColor = [UIColor blackColor];
        itemView.frame = CGRectMake(i * subW, 0, subW, CGRectGetHeight(self.bounds));
    }
}

-(void)setItemBadge:(NSInteger)badge atIndex:(NSInteger)index {
    if (index < _dataArray.count) {
        _dataArray[index].badge = badge;
    }
}

@end

@implementation TabData

+(instancetype)initWithParams:(NSObject *)data controller:(UIViewController *)controller{
    TabData *instance;
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
            instance.controller = controller;
            instance.data = data;
        }
    }
    return instance;
}


@end

