

//
//  ShipmentStopBean.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ShipmentStopBean.h"

@implementation ShipmentStopBean

#pragma 声明数组、字典或者集合里的元素类型时要重写
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"shipmentActivityList":[ShipmentActivityBean class]};
}


@end
