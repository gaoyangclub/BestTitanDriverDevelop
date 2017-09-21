//
//  OrderTabView.h
//  BestDriverTitan
//  用来展示所有站点下的活动tab页
//  Created by 高扬 on 17/3/26.
//  Copyright © 2017年 admin. All rights reserved.
//
//
#import <UIKit/UIKit.h>
#import "ShipmentActivityBean.h"

@protocol OrderTabViewDelegate<NSObject>

@optional
-(void)didSelectIndex:(NSInteger)index;
-(void)didSelectItem:(ShipmentActivityBean*)activityBean;

@end

@interface OrderTabView : UIScrollView

@property(nonatomic,weak)id<OrderTabViewDelegate> tabDelegate;
@property(nonatomic,retain)NSArray<ShipmentActivityBean*>* activityBeans;
@property(nonatomic,assign)NSInteger selectedIndex;

//-(void)setTotalCount:(NSInteger)count;
//-(void)setSelectedIndex:(NSInteger)index;
-(void)refreshActivityByIndex:(NSInteger)index;//刷新一下某个条目

@end
