//
//
//  ShipmentBean.m
//  BestDriverTitan
//
//  Created by admin on 17/1/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ShipmentBean.h"

@implementation ShipmentBean

-(BOOL)isComplete{
    return self.status ? ![self.status isEqualToString:ACTIVITY_STATUS_PENDING_REPORT] : NO;
}

-(NSDate *)date{
    if (!_date && self.dateTime > 0) {
        _date = [NSDate dateWithTimeIntervalSince1970:self.dateTime / 1000.];
    }
    return _date;
}

-(BOOL)canShowMoney{
    return self.accountDriverType ? [self.accountDriverType isEqualToString:ACCOUNT_DRIVER_TYPE_INDIVIDUAL] : NO;
}

@end
