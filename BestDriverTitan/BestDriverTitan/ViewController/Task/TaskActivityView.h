//
//  TaskActivityController.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomPopModelView.h"
#import "ShipmentActivityBean.h"

@protocol TaskActivityViewDelegate<NSObject>

-(void)activitySelected:(ShipmentActivityBean*)activityBean;

@end

@interface TaskActivityView : CustomPopModelView

@property(nonatomic, weak) id<TaskActivityViewDelegate> taskActivityDelegate;
@property(nonatomic,retain) NSMutableArray<ShipmentActivityBean*>* activityBeans;

@end
