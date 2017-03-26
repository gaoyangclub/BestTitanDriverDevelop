//
//  OrderTabView.h
//  BestDriverTitan
//
//  Created by 高扬 on 17/3/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderTabViewDelegate<NSObject>

@optional
-(void)didSelectIndex:(NSInteger)index;

@end

@interface OrderTabView : UIScrollView

@property(nonatomic,weak)id<OrderTabViewDelegate> tabDelegate;

-(void)setTotalCount:(NSInteger)count;
-(void)setSelectedIndex:(NSInteger)index;

@end
