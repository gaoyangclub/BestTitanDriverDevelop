//
//  ShipmentActivityShipUnitBean.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ShipmentActivityShipUnitBean.h"

@implementation ShipmentActivityShipUnitBean

- (id)copyWithZone:(NSZone *)zone {
    
    ShipmentActivityShipUnitBean *bean = [[[self class] allocWithZone:zone] init];
    bean.itemName = self.itemName;
    bean.pacakageUnitCount = self.pacakageUnitCount;
    bean.actualReceivedWeight = self.actualReceivedWeight;
    bean.actualReceivedVolume = self.actualReceivedVolume;
    bean.packageStandard = self.packageStandard;
    bean.itemCount = self.itemCount;
    
    return bean;
}


@end
