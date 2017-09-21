//
//  OrderViewModel.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/14.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderViewModel.h"
#import "AmapLocationService.h"

@interface SubmitTaskBean : NSObject

@property(nonatomic,retain)NSArray<ShipmentTaskBean*>* activityTaskList;
@property(nonatomic,assign)CLLocationCoordinate2D position;

@end

@implementation SubmitTaskBean

@end

@implementation OrderViewModel

-(void)getTaskActivity:(long)shipmentActivityId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self sendRequest:TASK_ACTIVITY_URL(shipmentActivityId) returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)submitAllTasks:(NSArray<ShipmentTaskBean*>*)taskBeans returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    SubmitTaskBean* submitBean = [[SubmitTaskBean alloc]init];
    submitBean.activityTaskList = taskBeans;
    
    NSValue* coordinateValue = [AmapLocationService getLastLocationPoint];
    if (coordinateValue) {//传入当前位置
        submitBean.position = coordinateValue.MKCoordinateValue;
    }
    
    [self sendRequest:TASK_SUBMIT_URL sendType:NetSendTypePost body:GetBody(submitBean) responseJson:YES returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)uploadAllReceipts:(NSArray<ShipmentTaskBean*>*)taskBeans returnBlock:(ReturnValueBlock)returnBlock
           progressBlock:(ProgressValueBlock) progressBlock
            failureBlock:(FailureBlock)failureBlock{
    
    [self startUploadReceipts:taskBeans uploadIndex:0 returnBlock:returnBlock progressBlock:progressBlock failureBlock:failureBlock];
}

-(void)startUploadReceipts:(NSArray<ShipmentTaskBean*>*)taskBeans uploadIndex:(NSInteger)uploadIndex
               returnBlock:(ReturnValueBlock) returnBlock
             progressBlock:(ProgressValueBlock) progressBlock
              failureBlock:(FailureBlock) failureBlock{
    if (uploadIndex < taskBeans.count) {
        ShipmentTaskBean* taskBean = taskBeans[uploadIndex];
        if(taskBean.assetsArray && taskBean.assetsArray.count > 0){
            __weak __typeof(self) weakSelf = self;
           [self uploadRequest:TASK_RECEIPT_URL(taskBean.id) assetsArray:taskBean.assetsArray returnBlock:^(id returnValue) {
               [weakSelf startUploadReceipts:taskBeans uploadIndex:uploadIndex + 1 returnBlock:returnBlock progressBlock:progressBlock failureBlock:failureBlock];
           } progressBlock:progressBlock failureBlock:failureBlock];
        }else{//直接上传下一组
            [self startUploadReceipts:taskBeans uploadIndex:uploadIndex + 1 returnBlock:returnBlock progressBlock:progressBlock failureBlock:failureBlock];
        }
    }else{
        if (returnBlock) {
            returnBlock(nil);
        }
    }
    
}

@end
