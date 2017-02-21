//
//  GYTabBarController.h
//  CustomTabViewController
//
//  Created by admin on 16/10/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GYTabBarView.h"

@interface GYTabBarController : UITabBarController

//@property(nonatomic,retain,readonly) GYTabBarView* tabBarView;
@property(nonatomic,assign) CGFloat tabBarHeight;
@property(nonatomic,retain) Class itemClass;
@property(nonatomic,retain) NSArray<TabData *>* dataArray;

-(void)setItemBadge:(NSInteger)badge atIndex:(NSInteger)index;

@end
