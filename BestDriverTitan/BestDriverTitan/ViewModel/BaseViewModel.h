//
//  ViewModelClass.h
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/8.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

//Kicking off network or database requests
//Determining when information should be hidden or shown
//Date and number formatting
//Localization

#import <Foundation/Foundation.h>
#import "NetRequestClass.h"
#import "PhotoTranslateUtils.h"

#define GetBody(bean) [NSJSONSerialization dataWithJSONObject:[bean yy_modelToJSONObject] options:kNilOptions error:NULL]

typedef NS_ENUM(NSInteger,NetSendType) {
    NetSendTypeGet = 1,
    NetSendTypePost = 2
};

//定义返回请求数据的block类型
//typedef void (^ReturnValueBlock) (id returnValue);
//typedef void (^FailureBlock) (NSString* errorCode,NSString* errorMsg);
//typedef void (^FailureBlock)();
//typedef void (^NetWorkBlock)(BOOL netConnetState);

@interface BaseViewModel : NSObject

//@property (strong, nonatomic) ReturnValueBlock returnBlock;
//@property (strong, nonatomic) ErrorCodeBlock errorBlock;
//@property (strong, nonatomic) FailureBlock failureBlock;

//获取网络的链接状态
//-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock;

// 传入交互的Block块
//-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
//                 WithErrorBlock: (ErrorCodeBlock) errorBlock
//               WithFailureBlock: (FailureBlock) failureBlock;


-(void)sendRequest:(NSString*)url returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

-(void)sendRequest:(NSString*)url responseJson:(BOOL)responseJson returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

-(void)sendRequest:(NSString*)url sendType:(NetSendType)sendType body:(NSData*)body responseJson:(BOOL)responseJson returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

-(void)sendRequest:(NSString*)url sendType:(NetSendType)sendType body:(NSData*)body fillHeader:(BOOL)fillHeader responseJson:(BOOL)responseJson returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

-(NSDictionary <NSString *, NSString *> *)getHeaders;

-(void)uploadRequest:(NSString *)url assetsArray:(NSMutableArray<PhotoAlbumVo*> *)assetsArray
         returnBlock:(ReturnValueBlock)returnBlock
       progressBlock:(ProgressValueBlock)progressBlock
        failureBlock:(FailureBlock)failureBlock;

-(void)uploadRequest:(NSString *)url assetsArray:(NSMutableArray<PhotoAlbumVo*> *)assetsArray fillHeader:(BOOL)fillHeader
         returnBlock:(ReturnValueBlock)returnBlock
       progressBlock:(ProgressValueBlock)progressBlock
        failureBlock:(FailureBlock)failureBlock;

@end
