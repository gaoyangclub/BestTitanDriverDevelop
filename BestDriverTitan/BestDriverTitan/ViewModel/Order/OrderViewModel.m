//
//  OrderViewModel.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderViewModel.h"

@implementation OrderViewModel

-(void)getTaskActivity:(long)shipmentActivityId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self sendRequest:TASK_ACTIVITY_URL(shipmentActivityId) returnBlock:returnBlock failureBlock:failureBlock];
}

@end
