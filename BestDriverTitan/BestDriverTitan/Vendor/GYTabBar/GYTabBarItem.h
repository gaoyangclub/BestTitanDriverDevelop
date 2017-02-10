//
//  GYTabBarItem.h
//  CustomTabViewController
//
//  Created by admin on 16/10/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYTabBarItem : UIControl

@property(nonatomic,assign)NSInteger itemIndex;
@property(nonatomic,retain)NSObject* data;
@property(nonatomic,copy)NSString* badgeValue;

@end
