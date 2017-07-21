//
//  DIYSplashViewModel.m
//  BestDriverTitan
//
//  Created by admin on 16/12/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "DIYSplashViewModel.h"

@implementation DIYSplashViewModel


-(void) fetchUpdateVersion:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;{
    [self sendRequest:CHECK_VERSION_URL sendType:NetSendTypeGet body:nil fillHeader:NO returnBlock:returnBlock failureBlock:failureBlock];
//    [NetRequestClass NetRequestGETWithRequestURL:CHECK_VERSION_URL WithParameter:nil headers:nil
//                            WithReturnValeuBlock:^(id returnValue) {
//        DDLog(@"%@", returnValue);
//        [self fetchValueSuccessWithDic:returnValue];
//    } WithErrorCodeBlock:^(id errorCode) {
//        DDLog(@"errorCode:%@", errorCode);
//        [self errorCodeWithDic:errorCode];
//    } WithFailureBlock:^{
//        DDLog(@"网络异常");
//        [self netFailure];
//    }];
}

//#pragma 获取到正确的数据，对正确的数据进行处理
//-(void)fetchValueSuccessWithDic: (NSDictionary *) returnValue
//{
//    //对从后台获取的数据进行处理，然后传给ViewController层进行显示
//    if (self.returnBlock) {
//        self.returnBlock(returnValue);
//    }else{
//        NSString* result = ConcatStrings(NSStringFromClass([self class]),@"returnBlock is Null");
//        NSLog(result,"%s");
//    }
//}
//
//#pragma 对ErrorCode进行处理
//-(void) errorCodeWithDic: (NSDictionary *) errorDic
//{
//    if (self.errorBlock) {
//        self.errorBlock(errorDic);
//    }else{
//        NSLog(ConcatStrings(NSStringFromClass([self class]),@"errorBlock is Null"),"%s");
//    }
//}
//
//#pragma 对网路异常进行处理
//-(void) netFailure
//{
//    if(self.failureBlock){
//        self.failureBlock();
//    }else{
//        NSLog(ConcatStrings(NSStringFromClass([self class]),@"failureBlock is Null"),"%s");
//    }
//}

@end
