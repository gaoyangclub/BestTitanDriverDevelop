//
//  ViewModelClass.m
//  MVVMTest
//
//  Created by 李泽鲁 on 15/1/8.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "BaseViewModel.h"
#import "AppDelegate.h"
@implementation BaseViewModel


#pragma 获取网络可到达状态
//-(void) netWorkStateWithNetConnectBlock: (NetWorkBlock) netConnectBlock;
//{
//    BOOL netState = [NetRequestClass netWorkReachability];
//    netConnectBlock(netState);
//}

#pragma 接收传过来的block
//-(void) setBlockWithReturnBlock: (ReturnValueBlock) returnBlock
//                 WithErrorBlock: (ErrorCodeBlock) errorBlock
//               WithFailureBlock: (FailureBlock) failureBlock
//{
//    _returnBlock = returnBlock;
//    _errorBlock = errorBlock;
//    _failureBlock = failureBlock;
//}
-(void)sendRequest:(NSString *)url returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self sendRequest:url responseJson:YES returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)sendRequest:(NSString *)url responseJson:(BOOL)responseJson returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self sendRequest:url sendType:NetSendTypeGet body:nil responseJson:responseJson returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)sendRequest:(NSString *)url sendType:(NetSendType)sendType body:(NSData *)body responseJson:(BOOL)responseJson returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self sendRequest:url sendType:sendType body:body fillHeader:YES responseJson:responseJson returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)sendRequest:(NSString *)url sendType:(NetSendType)sendType body:(NSData *)body fillHeader:(BOOL)fillHeader responseJson:(BOOL)responseJson returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    if (!url) {//请求地址无效 无权操作
        if (failureBlock) {
            failureBlock(nil,@"当前无权限操作该数据!");
        }
    }
    NSDictionary <NSString *, NSString *> * headers = nil;
    if (fillHeader) {
        headers = [self getHeaders];
    }
    if (sendType == NetSendTypeGet) {
        [NetRequestClass NetRequestGETWithRequestURL:url WithParameter:nil headers:headers responseJson:responseJson WithReturnValeuBlock:returnBlock WithFailureBlock:failureBlock];
    }else{
        [NetRequestClass NetRequestPOSTWithRequestURL:url WithParameter:nil headers:headers body:body WithReturnValeuBlock:returnBlock WithFailureBlock:failureBlock];
    }
}

-(NSDictionary <NSString *, NSString *> *)getHeaders{
    NSString* token = [Config getToken];
    if (token) {
        return @{@"TI-TOKEN":token,@"reportChannel":@"IOS"};
    }
    return nil;
}

-(void)uploadRequest:(NSString *)url assetsArray:(NSMutableArray<PhotoAlbumVo*> *)assetsArray
         returnBlock:(ReturnValueBlock)returnBlock
       progressBlock:(ProgressValueBlock)progressBlock
        failureBlock:(FailureBlock)failureBlock{
    [self uploadRequest:url assetsArray:assetsArray fillHeader:YES returnBlock:returnBlock progressBlock:progressBlock failureBlock:failureBlock];
}

-(void)uploadRequest:(NSString *)url assetsArray:(NSMutableArray<PhotoAlbumVo*> *)assetsArray fillHeader:(BOOL)fillHeader
         returnBlock:(ReturnValueBlock)returnBlock
       progressBlock:(ProgressValueBlock)progressBlock
        failureBlock:(FailureBlock)failureBlock{
    
    __weak __typeof(self) weakSelf = self;
    [PhotoTranslateUtils translateImagesByAssets:assetsArray completeHandler:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSMutableArray* images = [NSMutableArray array];
        for (PhotoAlbumVo* photoAlbum in assetsArray) {
            if(photoAlbum.picture){
                [images addObject:photoAlbum.picture];
            }else if(photoAlbum.imageData){
                [images addObject:photoAlbum.imageData];
//                ((AppDelegate*)[UIApplication sharedApplication].delegate).rootImage.image = photoAlbum.image;
            }
        }
        if (images.count > 0) {
            NSDictionary <NSString *, NSString *> * headers = nil;
            if (fillHeader) {
                headers = [strongSelf getHeaders];
            }
            [NetRequestClass NetRequestUploadWithRequestURL:url WithParameter:nil headers:headers images:images WithReturnValeuBlock:returnBlock WithProgressBlock:progressBlock WithFailureBlock:failureBlock];
        }else{ //直接上传下一组
            failureBlock(nil,@"传入的图片有问题，请确保上传的图片正常!");
        }
    }];
}

@end
