//
//  ShipmentTaskBean.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/8/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ShipmentTaskBean.h"

@implementation ShipmentTaskBean


-(NSMutableArray<PhotoAlbumVo*> *)assetsArray{
    if (!_assetsArray) {
        _assetsArray = [[NSMutableArray<PhotoAlbumVo*> alloc]init];
    }
    return _assetsArray;
}

-(NSString *)getStatusName{
    if ([ACTIVITY_STATUS_PENDING_REPORT isEqualToString:self.status]) {
        return @"未确认";
    }else if ([ACTIVITY_STATUS_REPORTING isEqualToString:self.status] || [ACTIVITY_STATUS_REPORTED isEqualToString:self.status]) {
        return @"已确认";
    }else if ([ACTIVITY_STATUS_CANCELED isEqualToString:self.status]) {
        return @"已取消";
    }
    return @"";
}

-(BOOL)hasReport{
    return self.status && ![self.status isEqualToString:ACTIVITY_STATUS_PENDING_REPORT];
}

-(NSInteger)actualPackageCount{
    if (!_actualPackageCount) {
        int actualCount = 0;
        for (ShipmentActivityShipUnitBean* shipunitBean in self.shipUnits) {
            actualCount += shipunitBean.pacakageUnitCount;
        }
        _actualPackageCount = actualCount;
    }
    return _actualPackageCount;
}

#pragma 声明数组、字典或者集合里的元素类型时要重写
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"shipUnits":[ShipmentActivityShipUnitBean class],@"contactList":[ContactBean class]};
}


@end
