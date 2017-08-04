//
//  LocalBundleManager.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalBundleManager : NSObject

+(NSString*)getAppName;
+(NSString*)getAppVersion;
+(NSInteger)getAppCode;
+(NSString*)getBundleIdentifier;//CFBundleIdentifier
+(NSString*)getBundleValue:(NSString*)key;

@end
