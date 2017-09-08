//
//  ViewModelClass.m
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/8.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "BaseViewModel.h"
@implementation BaseViewModel


#pragma 获取网络可到达状态
//-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock;
//{
//    BOOL netState = [NetRequestClass netWorkReachability];
//    netConnectBlock(netState);
//}

#pragma 接收穿过来的block
//-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
//                 WithErrorBlock: (ErrorCodeBlock) errorBlock
//               WithFailureBlock: (FailureBlock) failureBlock
//{
//    _returnBlock = returnBlock;
//    _errorBlock = errorBlock;
//    _failureBlock = failureBlock;
//}

-(void)sendRequest:(NSString *)url returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self sendRequest:url sendType:NetSendTypeGet body:nil returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)sendRequest:(NSString *)url sendType:(NetSendType)sendType body:(NSData *)body returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self sendRequest:url sendType:sendType body:body fillHeader:YES returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)sendRequest:(NSString *)url sendType:(NetSendType)sendType body:(NSData *)body fillHeader:(BOOL)fillHeader returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    if (!url) {//请求地址无效 无权操作
        if (failureBlock) {
            failureBlock(nil,@"当前无权限操作该数据!");
        }
    }
    NSDictionary <NSString *, NSString *> * headers = nil;
    if (fillHeader) {
        NSString* token = [Config getToken];
        if (token) {
            headers = @{@"TI-TOKEN":token};
        }
    }
    if (sendType == NetSendTypeGet) {
        [NetRequestClass NetRequestGETWithRequestURL:url WithParameter:nil headers:headers WithReturnValeuBlock:returnBlock WithFailureBlock:failureBlock];
    }else{
        [NetRequestClass NetRequestPOSTWithRequestURL:url WithParameter:nil headers:headers body:body WithReturnValeuBlock:returnBlock WithFailureBlock:failureBlock];
    }
}

@end
