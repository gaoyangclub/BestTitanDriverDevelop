//
//  ScanCodeItemBean.h
//  BestDriverTitan
//
//  Created by admin on 2017/10/31.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScanTaskOrderBean : NSObject

@property(nonatomic,copy) NSString* orderbaseCode;
@property(nonatomic,retain) NSArray<NSString*>* penddingReportPickupCodes;
@property(nonatomic,retain) NSArray<NSString*>* reportedPickupCodes;

@end

@interface ScanTaskResultBean : NSObject

@property(nonatomic,copy) NSString* activityDefinitionCode;
@property(nonatomic,retain) NSArray<ScanTaskOrderBean*>* orders;
@property(nonatomic,copy) NSString* sourceType;

@end

