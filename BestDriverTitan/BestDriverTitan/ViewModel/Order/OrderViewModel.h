//
//  OrderViewModel.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BaseViewModel.h"
#import "ShipmentTaskBean.h"

@interface OrderViewModel : BaseViewModel

-(void)getTaskActivity:(long)shipmentActivityId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;
-(void)submitAllTasks:(NSArray<ShipmentTaskBean*>*)taskBeans returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

-(void)uploadAllReceipts:(NSArray<ShipmentTaskBean*>*)taskBeans returnBlock:(ReturnValueBlock)returnBlock
           progressBlock:(ProgressValueBlock)progressBlock
            failureBlock:(FailureBlock)failureBlock;

@end
