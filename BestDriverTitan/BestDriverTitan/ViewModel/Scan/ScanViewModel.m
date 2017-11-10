//
//  ScanViewModel.m
//  BestDriverTitan
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ScanViewModel.h"

@implementation ScanCodePickUpBean
@end
@implementation ScanTaskPickUpBean

-(void)addScanCodeBean:(ScanCodePickUpBean *)scanCodeBean{
    if (!self.scanActivityTaskItemBeanList) {
        self.scanActivityTaskItemBeanList = [NSMutableArray<ScanCodePickUpBean*> array];
    }
    [(NSMutableArray*)self.scanActivityTaskItemBeanList addObject:scanCodeBean];
}

@end
@implementation ScanCodeSignBean
@end
@implementation ScanTaskSignBean
@end

@implementation ScanViewModel

-(void)checkScanRepeat:(NSString *)result code:(NSString *)code sourceCodeList:(NSMutableArray<NSString *> *)sourceCodeList
returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    BOOL canAdded = YES;
    if (sourceCodeList) {
        if (sourceCodeList.count > 0) {
            for (NSString* source in sourceCodeList) {
                if ([source isEqual:result]) {
                    canAdded = NO;//重复扫码
                    break;
                }
            }
        }
        if (canAdded) {
            if ([code isEqual:ACTIVITY_CODE_PICKUP_HANDOVER]) {//揽收需要验证
                [self checkScanCodeForPickUp:result code:code returnBlock:returnBlock failureBlock:failureBlock];
                return;
            }
            [sourceCodeList addObject:result];
            if (returnBlock) {
                returnBlock(nil);
            }
        }else{
            if (returnBlock) {
                returnBlock(nil);
            }
        }
    }
}

-(void)checkScanCodeForPickUp:(NSString *)result code:(NSString *)code
returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    ScanCodeSignBean* scanCodePickUpBean = [[ScanCodeSignBean alloc]init];
    scanCodePickUpBean.activityDefinitionCode = code;
    scanCodePickUpBean.sourceCode = result;
    scanCodePickUpBean.sourceType = SCAN_SOURCETYPE_PICKUP;//揽收
    
    [self getScanCodePickUpResult:scanCodePickUpBean returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)getScanCodePickUpResult:(ScanCodeSignBean*)scanCodePickUpBean
                   returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self getScanTaskResult:nil body:GetBody(scanCodePickUpBean) returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)getScanTaskPickUpResult:(ScanTaskPickUpBean*) scanTaskPickUpBean
                   returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self getScanTaskResult:ACTIVITY_CODE_PICKUP_HANDOVER body:GetBody(scanTaskPickUpBean) returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)getScanTaskSignResult:(ScanTaskSignBean*) scanTaskSignBean
                   returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    [self getScanTaskResult:ACTIVITY_CODE_SIGN_FOR_RECEIPT body:GetBody(scanTaskSignBean) returnBlock:returnBlock failureBlock:failureBlock];
}

-(void)getScanTaskResult:(NSString *)code body:(NSData *)body
                returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock{
    
    NSString* requestUrl;
    if ([ACTIVITY_CODE_PICKUP_HANDOVER isEqual:code]) {
        requestUrl = SCAN_TASK_PICKUP_URL;//body为ScanTaskPickUpBean
    }else if ([ACTIVITY_CODE_SIGN_FOR_RECEIPT isEqual:code]) {
        requestUrl = SCAN_TASK_SIGN_URL;//body为ScanTaskSignBean
    }else{
        requestUrl = SCAN_CODE_PICKUP_URL;//body为ScanCodePickUpBean
    }
    [self sendRequest:requestUrl sendType:NetSendTypePost body:body responseJson:YES returnBlock:returnBlock failureBlock:failureBlock];
}


@end
