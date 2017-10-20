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
typedef void (^ProgressValueBlock) (float completed,float total,NSString* title);

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
                    WithFailureBlock: (FailureBlock) failureBlock;
#pragma GET请求
+ (void) NetRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                             headers: (NSDictionary <NSString *, NSString *> *) headers
                        responseJson: (BOOL)responseJson
                WithReturnValeuBlock: (ReturnValueBlock) block
                    WithFailureBlock: (FailureBlock) failureBlock;

#pragma POST请求 body形式
+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                              headers: (NSDictionary <NSString *, NSString *> *) headers
                                 body: (NSData*) body
                 WithReturnValeuBlock: (ReturnValueBlock) block
//                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     WithFailureBlock: (FailureBlock) failureBlock;

#pragma POST请求 parameter形式
+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                              headers: (NSDictionary <NSString *, NSString *> *) headers
                 WithReturnValeuBlock: (ReturnValueBlock) block
                     WithFailureBlock: (FailureBlock) failureBlock;

#pragma POST UPLOAD 请求 images上传图片
+ (void) NetRequestUploadWithRequestURL: (NSString *) requestURLString
                          WithParameter: (NSDictionary *) parameter
                                headers: (NSDictionary <NSString *, NSString *> *) headers
                                 images: (NSArray*) images
                   WithReturnValeuBlock: (ReturnValueBlock) block
                      WithProgressBlock: (ProgressValueBlock) progressBlock
                       WithFailureBlock: (FailureBlock) failureBlock;

@end
