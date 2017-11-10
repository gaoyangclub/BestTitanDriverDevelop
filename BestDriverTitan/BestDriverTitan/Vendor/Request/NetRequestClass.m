//
//  NetRequestClass.m
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/6.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "NetRequestClass.h"

@interface NetRequestClass ()

@end

static BOOL netState;

@implementation NetRequestClass

+(void)initNetWorkStatus{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netState = YES;
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
                break;
            case AFNetworkReachabilityStatusUnknown:
                netState = NO;
                break;
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

#pragma 监测网络的可链接性
+ (BOOL) netWorkReachability
{
    return netState;
}

/***************************************
 在这做判断如果有dic里有errorCode
 调用errorBlock(dic)
 没有errorCode则调用block(dic
 ******************************/

//#pragma --mark GET请求方式
//+ (void) NetRequestGETWithRequestURL: (NSString *) requestURLString
//                       WithParameter: (NSDictionary *) parameter
//                WithReturnValeuBlock: (ReturnValueBlock) block
//                  WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
//                    WithFailureBlock: (FailureBlock) failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    
//    AFHTTPRequestOperation *op = [manager GET:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        DDLog(@"%@", dic);
//        
//        block(dic);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@", [error description]);
//        failureBlock();
//    }];
//    
//    op.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [op start];
//    
//}
//
//#pragma --mark POST请求方式
//
//+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
//                        WithParameter: (NSDictionary *) parameter
//                 WithReturnValeuBlock: (ReturnValueBlock) block
//                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
//                     WithFailureBlock: (FailureBlock) failureBlock
//{
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] init];
//    
//    AFHTTPRequestOperation *op = [manager POST:requestURLString parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        
//        DDLog(@"%@", dic);
//        
//        block(dic);
//        /***************************************
//         在这做判断如果有dic里有errorCode
//         调用errorBlock(dic)
//         没有errorCode则调用block(dic
//         ******************************/
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock();
//    }];
//    
//    op.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [op start];
//
//}

+ (void) NetRequestGETWithRequestURL: (NSString *) requestURLString
                       WithParameter: (NSDictionary *) parameter
                             headers: (NSDictionary <NSString *, NSString *> *) headers
                 WithReturnValeuBlock: (ReturnValueBlock) block
//                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     WithFailureBlock: (FailureBlock) failureBlock
{
    //申明返回的结果是json类型
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
////    //申明请求的数据是json类型
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
//    for (NSString *key in headers) {
//        //        NSLog(@"key: %@ value: %@", key, dict[key]);
//        [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
//    }
//    
//    [manager GET:requestURLString parameters:parameter progress:nil
//         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
////             DDLog(@"%@", responseObject);
//////        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
////        NSString *result = [responseObject stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
////        block(result);
//             
//             //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//             //        NSString *result = [responseObject stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//             DDLog(@"%@", responseObject);
//             block(responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [NetRequestClass onNetFailure:error failureBlock:failureBlock];
//    }];
    
    [NetRequestClass NetRequestGETWithRequestURL:requestURLString WithParameter:parameter headers:headers responseJson:YES WithReturnValeuBlock:block WithFailureBlock:failureBlock];
}

+(void)NetRequestGETWithRequestURL:(NSString *)requestURLString WithParameter:(NSDictionary *)parameter headers:(NSDictionary<NSString *,NSString *> *)headers responseJson:(BOOL)responseJson WithReturnValeuBlock:(ReturnValueBlock)block WithFailureBlock:(FailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (!responseJson) {//非json格式的数据获取
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    }
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:requestURLString parameters:parameter error:nil];
    //    [request addValue:你需要的accept-id forHTTPHeaderField:@"Accept-Id"];
    //    [request addValue:你需要的user-agent forHTTPHeaderField:@"User-Agent"];
    //    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    for (NSString *key in headers) {
        //        NSLog(@"key: %@ value: %@", key, headers[key]);
        [request setValue:headers[key] forHTTPHeaderField:key];
    }
    //    [request setHTTPBody:body];
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            DDLog(@"%@", responseObject);
            block(responseObject);
        } else {
            [NetRequestClass onNetFailure:error failureBlock:failureBlock];
        }
    }] resume];
}

+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                              headers: (NSDictionary <NSString *, NSString *> *) headers
                                 body: (NSData*) body
                 WithReturnValeuBlock: (ReturnValueBlock) block
//                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     WithFailureBlock: (FailureBlock) failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:requestURLString parameters:parameter error:nil];
//    [request addValue:你需要的accept-id forHTTPHeaderField:@"Accept-Id"];
//    [request addValue:你需要的user-agent forHTTPHeaderField:@"User-Agent"];
    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    for (NSString *key in headers) {
//        NSLog(@"key: %@ value: %@", key, headers[key]);
        [request setValue:headers[key] forHTTPHeaderField:key];
    }
    [request setHTTPBody:body];
    
    [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (!error) {
            DDLog(@"%@", responseObject);
            block(responseObject);
        } else {
            [NetRequestClass onNetFailure:error failureBlock:failureBlock];
        }
    }] resume];
    
//    AFHTTPRequestOperation *op = [manager POST:requestURLString parameters:parameter
//    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//        [formData appendPartWithHeaders:nil body:body];
//    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        
//        DDLog(@"%@", dic);
//        
//        block(dic);
//        /***************************************
//         在这做判断如果有dic里有errorCode
//         调用errorBlock(dic)
//         没有errorCode则调用block(dic
//         ******************************/
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock();
//    }];
//    
//    op.responseSerializer = [AFHTTPResponseSerializer serializer];
//    
//    [op start];
    
}

+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                              headers: (NSDictionary <NSString *, NSString *> *) headers
                 WithReturnValeuBlock: (ReturnValueBlock) block
//                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     WithFailureBlock: (FailureBlock) failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    for (NSString *key in headers) {
//        NSLog(@"key: %@ value: %@", key, headers[key]);
        [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
    }
    [manager POST:requestURLString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //        if (body) {
        //            [formData appendPartWithHeaders:headers body:body];
        //        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        DDLog(@"%@", responseObject);
        block(responseObject);
                /***************************************
                 在这做判断如果有dic里有errorCode
                 调用errorBlock(dic)
                 没有errorCode则调用block(dic)
                 ******************************/
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NetRequestClass onNetFailure:error failureBlock:failureBlock];
    }];
}

+ (void) NetRequestUploadWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                              headers: (NSDictionary <NSString *, NSString *> *) headers
                               images: (NSArray*) images
                 WithReturnValeuBlock: (ReturnValueBlock) block
                    WithProgressBlock: (ProgressValueBlock) progressBlock
                     WithFailureBlock: (FailureBlock) failureBlock
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 3600;//延迟1小时
    for (NSString *key in headers) {
//        NSLog(@"key: %@ value: %@", key, headers[key]);
        [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
    }
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];//设置服务器允许的请求格式内容
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    [manager POST:requestURLString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (UIImage* image in images) {
        for (id imageData in images) {
            NSData* data;
            if ([imageData isKindOfClass:[NSData class]]) {
                data = UIImageJPEGRepresentation([UIImage imageWithData:imageData],0.1);//压缩质量
            }else if([imageData isKindOfClass:[UIImage class]]){
                data = UIImageJPEGRepresentation(imageData,0.1);
            }
//            NSData *data = UIImageJPEGRepresentation(image,0.1);
//            if(data){
                //            NSData *data = UIImagePNGRepresentation(image);
                //第一个代表文件转换后data数据，第二个代表图片的名字，第三个代表图片放入文件夹的名字，第四个代表文件的类型
                
                // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
                // 要解决此问题，
                // 可以在上传时使用当前的系统事件作为文件名
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                // 设置时间格式
                formatter.dateFormat = @"yyyyMMddHHmmssSSS";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
                
                [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
//            }
        }
    } progress:^(NSProgress * progressValue){
        if (progressBlock) {
            progressBlock(progressValue.completedUnitCount,progressValue.totalUnitCount,nil);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DDLog(@"%@", responseObject);
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NetRequestClass onNetFailure:error failureBlock:failureBlock];
    }];
}

+(void)onNetFailure:(NSError * _Nonnull)error failureBlock:(FailureBlock) failureBlock{
    NSData* result = [error.userInfo valueForKey:@"com.alamofire.serialization.response.error.data"];
    NSString* detailMessage;
    if (result) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableLeaves error:nil];
        //        NSString* detailMessage = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        //        DDLog(@"%@", jsonDict);
        detailMessage = [jsonDict valueForKey:@"detailMessage"];
        if (!detailMessage) {
            detailMessage = [jsonDict valueForKey:@"message"];
        }
        NSString* code = [jsonDict valueForKey:@"code"];
        if(failureBlock){
            failureBlock(code,detailMessage);
        }
    }else{
        detailMessage = [error.userInfo valueForKey:@"NSDebugDescription"];
        if (detailMessage) {
            failureBlock(nil,detailMessage);
        }else if(failureBlock){
            failureBlock(nil,@"网络错误,请检查网络情况");
        }
    }
}


@end
