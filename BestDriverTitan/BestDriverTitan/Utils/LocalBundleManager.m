
//
//  LocalBundleManager.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LocalBundleManager.h"

@implementation LocalBundleManager

+(NSString *)getAppName{
    return [LocalBundleManager getBundleValue:@"CFBundleName"];
}

+(NSString *)getAppVersion{
    return [LocalBundleManager getBundleValue:@"CFBundleShortVersionString"];
}

+(NSString *)getAppCode{
    return [LocalBundleManager getBundleValue:@"CFBundleVersion"];
}

+(NSString *)getBundleValue:(NSString *)key{
    NSDictionary<NSString *, id> *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    if(infoDictionary && [infoDictionary valueForKey:key]){
        return [infoDictionary valueForKey:key];
    }
    return nil;
}

@end
