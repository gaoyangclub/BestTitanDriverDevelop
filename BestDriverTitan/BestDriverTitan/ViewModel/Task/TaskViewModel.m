//
//  TaskViewModel.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskViewModel.h"

@interface PageBean : NSObject

@property(nonatomic,copy)NSString* dateRange;
@property(nonatomic,assign)NSInteger objectsPerPage;
@property(nonatomic,assign)NSInteger pageNumber;

@end

@implementation PageBean

@end

@implementation TaskViewModel

-(void)getRecentList:(NSInteger)pageNumber returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    return [self getRecentList:pageNumber isAll:NO returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)getRecentList:(NSInteger)pageNumber isAll:(BOOL)isAll returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    
    PageBean* pageBean = [[PageBean alloc]init];
    pageBean.pageNumber = pageNumber;
    pageBean.objectsPerPage = PER_PAGE_COUNT;//每页20个
    pageBean.dateRange = isAll ?  @"": @"LAST_7_DAYS";
    
    [self sendRequest:SHIPMENT_RECENT_URL sendType:NetSendTypePost body:GetBody(pageBean) fillHeader:YES responseJson:YES returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)getStopList:(long)shipmentId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self sendRequest:SHIPMENT_STOP_URL(shipmentId) returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)getRate:(long)shipmentId returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self sendRequest:SHIPMENT_RATE_URL(shipmentId) responseJson:NO returnBlock:returnBlock failureBlock:failureBlock];
}

@end
