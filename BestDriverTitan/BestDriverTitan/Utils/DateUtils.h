//
//  DateUtils.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtils : NSObject

//计算  距离现在的时间 返回:今天、昨天、前天
+(NSString *)getUTCFormateName:(NSDate *)newsDate;

@end
