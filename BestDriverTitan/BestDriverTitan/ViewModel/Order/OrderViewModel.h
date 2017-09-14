//
//  OrderViewModel.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BaseViewModel.h"

@interface OrderViewModel : BaseViewModel

-(void)getTaskActivity:(long)shipmentActivityId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

@end
