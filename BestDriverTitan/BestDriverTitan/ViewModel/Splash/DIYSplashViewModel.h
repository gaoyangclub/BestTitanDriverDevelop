//
//  DIYSplashViewModel.h
//  BestDriverTitan
//
//  Created by admin on 16/12/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"

@interface DIYSplashViewModel : BaseViewModel

-(void) fetchUpdateVersion:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

@end
