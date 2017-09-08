//
//  BackgroundTimer.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackgroundTimer : NSObject

+(void)start:(NSTimeInterval)timeout;
+(void)clear;

@end
