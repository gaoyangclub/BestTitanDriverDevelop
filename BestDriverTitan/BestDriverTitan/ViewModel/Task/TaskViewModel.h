//
//  TaskViewModel.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BaseViewModel.h"

@interface TaskViewModel : BaseViewModel

-(void)getRecentList:(NSInteger)pageNumber returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;
-(void)getRecentList:(NSInteger)pageNumber isAll:(BOOL)isAll returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

//获取停靠站列表数据
-(void)getStopList:(long)shipmentId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;
//获取运单运费信息
-(void)getRate:(long)shipmentId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

@end
