//
//  ShipmentActivityBean.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ShipmentActivityBean.h"

@implementation ShipmentActivityBean

-(BOOL)hasReport{
    return self.status && ![self.status isEqualToString:ACTIVITY_STATUS_PENDING_REPORT];
}

@end
