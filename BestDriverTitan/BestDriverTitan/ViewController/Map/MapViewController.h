//
//  MapViewController.h
//  BestDriverTitan
//  3D地图定位结果展示
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmapLocationService.h"

typedef NS_ENUM(NSInteger, MapViewMode) {
    MapViewModeNormal = 0,//只显示当前位置
    MapViewModeMark,//展示地图大头针 显示tips
    MapViewModeRoute//运动轨迹
};

@interface MapViewController : UIViewController

@property(nonatomic,retain)NSArray<LocationInfo*>* routePoints;//轨迹坐标点
@property(nonatomic,retain)NSArray<LocationInfo*>* markPoints;//覆盖物坐标数据
@property(nonatomic,assign)MapViewMode mode;

//-(instancetype)init __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
//+(instancetype)new __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
//更多屏蔽初始化方法参照: http://ios.jobbole.com/89329/#comment-90585

//+(instancetype)sharedInstance;


@end
