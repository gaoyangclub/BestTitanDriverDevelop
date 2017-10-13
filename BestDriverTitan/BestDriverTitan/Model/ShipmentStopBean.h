//
//  ShipmentStopBean.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShipmentActivityBean.h"
#import "ContactBean.h"

@interface ShipmentStopBean : NSObject

@property(nonatomic,assign)long id;
@property(nonatomic,copy)NSString* locationAddress;
//@property(nonatomic,copy)NSString* shortAddress;//去掉省市区
@property(nonatomic,copy)NSString* stopName;//详细店名

@property(nonatomic,assign)int orderCount;//订单数

@property(nonatomic,assign)int pickupCount;
@property(nonatomic,assign)int deliveryCount;

@property(nonatomic,copy)NSString* deliveryDate;

@property(nonatomic,assign)double latitude;
@property(nonatomic,assign)double longitude;

@property(nonatomic,assign)BOOL isArrive;
@property(nonatomic,assign)BOOL isDeparture;

@property(nonatomic,retain)NSMutableArray<ShipmentActivityBean*>* shipmentActivityList;

@property(nonatomic,retain)NSMutableArray<ContactBean*>* contactList;//联系人列表

@property(nonatomic,assign)CGFloat ordermovementCt;//订单数

-(BOOL)getIsComplete;

@property(nonatomic,assign)BOOL isComplete;
//@property(nonatomic,assign)BOOL isFollow;

@end
