//
//  LoginViewModel.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

-(void)getAuthCode:(NSString *)phone returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self getAuthCode:phone isAdmin:NO returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)getAuthCode:(NSString *)phone isAdmin:(BOOL)isAdmin returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self sendRequest:AUTH_CODE_URL(phone,BOOL_TO_STRING(isAdmin)) sendType:NetSendTypeGet body:nil fillHeader:NO responseJson:YES returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)logon:(NSString *)phone authcode:(NSString *)authcode returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self sendRequest:LOGIN_URL(phone,ConcatStrings(AUTH_CODE_PREV,authcode)) sendType:NetSendTypeGet body:nil fillHeader:NO responseJson:YES returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)registerGeTuiAppClient:(NSString *)clientId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    if([self getHeaders]){//有token的情况下才可以
        [self sendRequest:REGISTER_APPCLIENT_URL(clientId) responseJson:NO returnBlock:returnBlock failureBlock:failureBlock];
    }
}

@end
