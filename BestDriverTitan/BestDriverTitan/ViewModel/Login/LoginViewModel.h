//
//  LoginViewModel.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BaseViewModel.h"

@interface LoginViewModel : BaseViewModel

-(void)getAuthCode:(NSString*)phone returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;
-(void)getAuthCode:(NSString*)phone isAdmin:(BOOL)isAdmin returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

-(void)logon:(NSString*)phone authcode:(NSString*)authcode returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

-(void)registerGeTuiAppClient:(NSString*)clientId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

@end
