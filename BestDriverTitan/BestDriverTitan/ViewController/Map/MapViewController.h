//
//  MapViewController.h
//  BestDriverTitan
//  3D地图定位结果展示
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AmapLocationService.h"

@interface MapViewController : UIViewController

@property(nonatomic,retain)NSMutableArray<LocationInfo*>* locationPoints;

//-(instancetype)init __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
//+(instancetype)new __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
//更多屏蔽初始化方法参照: http://ios.jobbole.com/89329/#comment-90585

//+(instancetype)sharedInstance;


@end
