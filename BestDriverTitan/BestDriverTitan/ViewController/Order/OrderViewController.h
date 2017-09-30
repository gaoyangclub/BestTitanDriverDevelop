//
//  OrderViewController.h
//  BestDriverTitan
//  订单详情列表
//  Created by 高扬 on 17/3/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MJTableViewController.h"
#import "ShipmentActivityBean.h"
#import "ShipmentStopBean.h"
#import "ShipmentBean.h"

@interface OrderViewController : MJTableViewController

@property(nonatomic,retain)ShipmentBean* shipmentBean;
@property(nonatomic,retain)ShipmentStopBean* stopBean;
@property(nonatomic,retain)NSArray<ShipmentActivityBean*>* activityBeans;

@property(nonatomic,copy)NSString* selectedTaskCode;//优先选中的活动类型

@property(nonatomic,copy)__block ReturnValueBlock returnBlock;

@end
