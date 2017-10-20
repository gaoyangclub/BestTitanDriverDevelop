//
//  PushMessageHelper.h
//  BestDriverTitan
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppPushMsg.h"

//推送消息管理平台
@interface PushMessageHelper : NSObject

+(void)start;
+(void)stop;
+(void)clear;
+(AppPushMsg*)getPushMsgByLinkId:(long)linkId;
//将目标消息设为已读
+(BOOL)setPushMessageIsRead:(long)linkId;

@end
