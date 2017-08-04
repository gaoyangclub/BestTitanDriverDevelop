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


@implementation NetRequestClass
#pragma 监测网络的可链接性
+ (BOOL) netWorkReachability
{
    __block BOOL netState = NO;
    
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netState = YES;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                netState = YES;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                netState = NO;
            default:
                break;
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
//    NSURL *baseURL = [NSURL URLWithString:strUrl];
//    
//    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
//    
//    NSOperationQueue *operationQueue = manager.operationQueue;
//    
//    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusReachableViaWWAN:
//            case AFNetworkReachabilityStatusReachableViaWiFi:
//                [operationQueue setSuspended:NO];
//                netState = YES;
//                break;
//            case AFNetworkReachabilityStatusNotReachable:
//                netState = NO;
//            default:
//                [operationQueue setSuspended:YES];
//                break;
//        }
//    }];
//    
//    [manager.reachabilityManager startMonitoring];
    
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
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    for (NSString *key in headers) {
//        NSLog(@"key: %@ value: %@", key, dict[key]);
        [manager.requestSerializer setValue:headers[key] forHTTPHeaderField:key];
    }
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    //申明请求的数据是json类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
    [manager GET:requestURLString parameters:parameter progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//             DDLog(@"%@", responseObject);
////        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//        NSString *result = [responseObject stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        block(result);
             
             //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
             //        NSString *result = [responseObject stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
             DDLog(@"%@", responseObject);
             block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NetRequestClass onNetFailure:error failureBlock:failureBlock];
    }];
}

+ (void) NetRequestPOSTWithRequestURL: (NSString *) requestURLString
                        WithParameter: (NSDictionary *) parameter
                              headers: (NSDictionary <NSString *, NSString *> *) headers
                                 body: (NSData*) body
                 WithReturnValeuBlock: (ReturnValueBlock) block
//                   WithErrorCodeBlock: (ErrorCodeBlock) errorBlock
                     WithFailureBlock: (FailureBlock) failureBlock
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/plain", nil];
    
    [manager POST:requestURLString parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (body) {
            [formData appendPartWithHeaders:headers body:body];
        }
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

+(void)onNetFailure:(NSError * _Nonnull)error failureBlock:(FailureBlock) failureBlock{
    NSData* result = [error.userInfo valueForKey:@"com.alamofire.serialization.response.error.data"];
    if (result) {
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableLeaves error:nil];
        //        NSString* detailMessage = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
        //        DDLog(@"%@", jsonDict);
        NSString* detailMessage = [jsonDict valueForKey:@"detailMessage"];
        if (!detailMessage) {
            detailMessage = [jsonDict valueForKey:@"message"];
        }
        NSString* code = [jsonDict valueForKey:@"code"];
        if(failureBlock){
            failureBlock(code,detailMessage);
        }
    }else{
        if(failureBlock){
            failureBlock(nil,@"网络错误,请检查网络情况");
        }
    }
}


@end
