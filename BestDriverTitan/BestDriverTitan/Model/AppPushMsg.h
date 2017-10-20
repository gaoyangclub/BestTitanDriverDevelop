//
//  AppPushMsg.h
//  BestDriverTitan
//
//  Created by admin on 2017/10/10.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppPushMsg : NSObject

@property(nonatomic,copy)NSString* type;
@property(nonatomic,copy)NSString* msg;
@property(nonatomic,copy)NSString* shipmentCode;
@property(nonatomic,assign)long shipmentId;
@property(nonatomic,retain)NSDate* createTime;//创建时间
@property(nonatomic,assign)BOOL isRead;

@end
