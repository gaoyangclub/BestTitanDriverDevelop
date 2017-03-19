//
//  ShipmentBean.h
//  BestDriverTitan
//
//  Created by admin on 17/1/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipmentBean : NSObject

@property(nonatomic,assign)int factor1;
@property(nonatomic,assign)int factor2;
@property(nonatomic,assign)int factor3;
@property(nonatomic,assign)int pickupCount;
@property(nonatomic,assign)int deliverCount;
@property(nonatomic,assign)BOOL isComplete;
@property(nonatomic,retain)NSDate* dateTime;


@end
