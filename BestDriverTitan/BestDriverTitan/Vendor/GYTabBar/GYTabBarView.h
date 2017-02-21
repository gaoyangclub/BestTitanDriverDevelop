//
//  GYTabBarView.h
//  CustomTabViewController
//
//  Created by admin on 16/10/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
//struct TabData{
//    __unsafe_unretained UIViewController *controller;
//    __unsafe_unretained NSObject *source;
//};
@class TabData;
@class GYTabBarView;

@protocol GYTabBarDelegate <NSObject>
@optional //可选的
-(void)didSelectItem:(GYTabBarView*)tabBar tabData:(TabData*)tabData index:(NSInteger)index;
@end

@interface GYTabBarView : UIView

@property(nonatomic,retain) Class itemClass;
@property(nonatomic,retain) NSArray<TabData *>* dataArray;
@property(nonatomic,assign) NSInteger selectedIndex;
@property(nonatomic, weak) id<GYTabBarDelegate> delegate;

-(void)setItemBadge:(NSInteger)badge atIndex:(NSInteger)index;

@end

@interface TabData:NSObject

-(instancetype)init __attribute__((unavailable("Disabled. Use +initWithParams instead")));
+(instancetype)new __attribute__((unavailable("Disabled. Use +initWithParams instead")));
-(instancetype)initWithFrame:(CGRect)frame __attribute__((unavailable("Disabled. Use +initWithParams instead")));
-(instancetype)initWithCoder:(NSCoder *)aDecoder __attribute__((unavailable("Disabled. Use +initWithParams instead")));
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style __attribute__((unavailable("Disabled. Use +initWithParams instead")));

+(instancetype)initWithParams:(NSObject*)data controller:(UIViewController*)controller;

@property(nonatomic,retain) UIViewController *controller;
@property(nonatomic,retain) NSObject *data;
@property(nonatomic,assign) NSInteger badge;

@end
