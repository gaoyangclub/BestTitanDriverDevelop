//
//  ShipmentActivityBean.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShipmentActivityBean : NSObject

@property(nonatomic,assign)long id;
@property(nonatomic,copy)NSString* activityDefinitionCode;
@property(nonatomic,copy)NSString* status;//活动完成状况

@property(nonatomic,assign)BOOL* itemStatus;//是否货量有差异

@end
