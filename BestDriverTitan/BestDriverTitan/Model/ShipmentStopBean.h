//
//  ShipmentStopBean.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipmentStopBean : NSObject

@property(nonatomic,assign)long id;
@property(nonatomic,copy)NSString* locationAddress;
@property(nonatomic,copy)NSString* shortAddress;//去掉省市区
@property(nonatomic,copy)NSString* stopName;//详细店名

@property(nonatomic,assign)int orderCount;//订单数

@property(nonatomic,assign)int pickupCount;
@property(nonatomic,assign)int deliverCount;
@property(nonatomic,assign)BOOL isComplete;
@property(nonatomic,assign)BOOL isFollow;

@end
