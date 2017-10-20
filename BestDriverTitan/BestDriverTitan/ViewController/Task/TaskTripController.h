//
//  TaskTripController.h
//  BestDriverTitan
//
//  Created by admin on 16/12/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJTableViewController.h"
#import "ShipmentBean.h"

@interface TaskTripController : MJTableViewController

//@property(nonatomic,retain)ShipmentBean* shipmentBean;
@property(nonatomic,assign)long shipmentId;
@property(nonatomic,copy)NSString* shipmentCode;

@property(nonatomic,copy)__block ReturnValueBlock returnBlock;

@end
