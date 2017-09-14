//
//  LocationViewModel.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LocationViewModel.h"
#import "HeartBeat.h"

static LocationViewModel* instance;

@implementation LocationViewModel

+(instancetype)sharedInstance {
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

-(void)submitLocationPoints:(NSMutableArray<NSString*>*)locationList returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    
    HeartBeat* heartBeat = [[HeartBeat alloc]init];
    heartBeat.locationList = locationList;
    
    [self sendRequest:HEART_BEAT_URL sendType:NetSendTypePost body:GetBody(heartBeat) fillHeader:YES responseJson:YES returnBlock:returnBlock failureBlock:failureBlock];
}

+(void)sendLocationPoints{
    NSMutableArray<NSString *> *locationList = [AmapLocationService getLocationList];
    NSInteger sendCount = locationList.count;
    [AmapLocationService addMarkInfo:ConcatStrings(@"定位上传发起请求 发送个数:",@(sendCount)) type:LocationMarkTypeInfo];//开始上传
    [AmapLocationService setHasSendLocation:YES];
    [[LocationViewModel sharedInstance] submitLocationPoints:locationList returnBlock:^(id returnValue) {
        [AmapLocationService clearLocationList];//上传完毕清除掉
        [AmapLocationService addMarkInfo:ConcatStrings(@"定位上传回执成功 发送个数:",@(sendCount)) type:LocationMarkTypeDebug];//记录成功日志
        [AmapLocationService setHasSendLocation:NO];
     } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
         [AmapLocationService addMarkInfo:ConcatStrings(@"定位上传回执失败 发送个数:",@(sendCount),@"\n报错信息:",errorMsg) type:LocationMarkTypeError];//记录失败日志
         [AmapLocationService setHasSendLocation:NO];
     }];
}

@end
