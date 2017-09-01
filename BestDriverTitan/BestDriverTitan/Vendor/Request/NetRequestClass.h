//
//  NetRequestClass.h
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/6.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ReturnValueBlock) (id returnValue);
typedef void (^FailureBlock) (NSString* errorCode,NSString* errorMsg);

@interface NetRequestClass : NSObject

#pragma 开始侦听状态
+ (void) initNetWorkStatus;

#pragma 监测网络的可链接性
+ (BOOL) netWorkReachability;

#pragma GET请求
+ (void) NetRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                             headers: (NSDictionary <NSString *, NSString *> *) headers
                WithReturnValeuBlock: (ReturnValueBlock) block
//                  WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                    WithFailureBlock: (FailureBlock) failureBlock;

#pragma POST请求
+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                              headers: (NSDictionary <NSString *, NSString *> *) headers
                                 body: (NSData*) body
                 WithReturnValeuBlock: (ReturnValueBlock) block
//                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     WithFailureBlock: (FailureBlock) failureBlock;

@end
