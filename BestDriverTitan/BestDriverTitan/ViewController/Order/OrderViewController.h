//
//  OrderViewController.h
//  BestDriverTitan
//  订单详情列表
//  Created by 高扬 on 17/3/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MJTableViewController.h"
#import "ShipmentActivityBean.h"

@interface OrderViewController : MJTableViewController

@property(nonatomic,retain)NSArray<ShipmentActivityBean*>* activityBeans;

@end
