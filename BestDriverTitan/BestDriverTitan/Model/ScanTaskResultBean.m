//
//  ScanCodeItemBean.m
//  BestDriverTitan
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ScanTaskResultBean.h"

@implementation ScanTaskOrderBean

#pragma 声明数组、字典或者集合里的元素类型时要重写
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"penddingReportPickupCodes":[NSString class],@"reportedPickupCodes":[NSString class]};
}

@end

@implementation ScanTaskResultBean

#pragma 声明数组、字典或者集合里的元素类型时要重写
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"orders":[ScanTaskOrderBean class]};
}

@end
