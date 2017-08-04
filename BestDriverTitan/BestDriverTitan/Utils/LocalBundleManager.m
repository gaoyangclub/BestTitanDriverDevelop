
//
//  LocalBundleManager.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LocalBundleManager.h"

static NSString* appNameCache;
static NSString* appVersionCache;
static NSString* appCodeCache;
static NSString* bundleIdentifierCache;

@implementation LocalBundleManager

+(NSString *)getAppName{
    if (!appNameCache) {
        appNameCache = [LocalBundleManager getBundleValue:@"CFBundleName"];
    }
    return appNameCache;
}

+(NSString *)getAppVersion{
    if (!appVersionCache) {
        appVersionCache = [LocalBundleManager getBundleValue:@"CFBundleShortVersionString"];
    }
    return appVersionCache;
}

+(NSInteger)getAppCode{
    if (!appCodeCache) {
        appCodeCache = [LocalBundleManager getBundleValue:@"CFBundleVersion"];;
    }
    return [appCodeCache integerValue];
}

+(NSString *)getBundleIdentifier{
    if (!bundleIdentifierCache) {
        bundleIdentifierCache = [LocalBundleManager getBundleValue:@"CFBundleIdentifier"];
    }
    return bundleIdentifierCache;
}

+(NSString *)getBundleValue:(NSString *)key{
    NSDictionary<NSString *, id> *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    if(infoDictionary && [infoDictionary valueForKey:key]){
        return [infoDictionary valueForKey:key];
    }
    return nil;
}

@end
