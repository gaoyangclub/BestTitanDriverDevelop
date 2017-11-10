//
//  ScanViewModel.h
//  BestDriverTitan
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BaseViewModel.h"


/**
 * Desc: 扫码-揽收 实体类
 */
@interface ScanCodePickUpBean : NSObject

@property(nonatomic,copy) NSString* activityDefinitionCode;
@property(nonatomic,copy) NSString* weight;
@property(nonatomic,copy) NSString* volume;
@property(nonatomic,copy) NSString* sourceCode;
@property(nonatomic,copy) NSString* sourceType;
@property(nonatomic,assign) BOOL needPickupReport;

@end

/**
 * Desc: 扫码-签收 结果实体类
 */
@interface ScanTaskPickUpBean : NSObject

@property(nonatomic,retain) NSArray<ScanCodePickUpBean*>* scanActivityTaskItemBeanList;

-(void)addScanCodeBean:(ScanCodePickUpBean*)scanCodeBean;

@end

/**
 * Desc: 扫码-签收 实体类
 */
@interface ScanCodeSignBean : NSObject

@property(nonatomic,copy) NSString* activityDefinitionCode;//活动编码 'PICKUP_HANDOVER',
@property(nonatomic,copy) NSString* sourceCode;
@property(nonatomic,copy) NSString* sourceType;

@end
/**
 * Desc: 扫码-签收 结果实体类
 */
@interface ScanTaskSignBean : NSObject

@property(nonatomic,retain) NSArray<ScanCodeSignBean*>* scanActivityTaskBeans;

@end

@interface ScanViewModel : BaseViewModel

-(void)checkScanRepeat:(NSString*)result code:(NSString*)code sourceCodeList:(NSMutableArray<NSString *>*)sourceCodeList
           returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;//检查扫描结果是否重复

-(void)getScanTaskPickUpResult:(ScanTaskPickUpBean*) scanTaskPickUpBean
                   returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;
-(void)getScanTaskSignResult:(ScanTaskSignBean*) scanTaskSignBean
                 returnBlock:(ReturnValueBlock)returnBlock failureBlock:(FailureBlock)failureBlock;

@end
