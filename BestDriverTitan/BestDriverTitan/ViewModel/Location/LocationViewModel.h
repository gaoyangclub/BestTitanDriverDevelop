//
//  LocationViewModel.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BaseViewModel.h"
#import "AmapLocationService.h"

@interface LocationViewModel : BaseViewModel

-(void)submitLocationPoints:(NSMutableArray<NSString*>*)locationList returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

+(void)sendLocationPoints;

@end
