//
//  UserDefaultsUtils.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "UserDefaultsUtils.h"

static NSCache* cache;

@implementation UserDefaultsUtils

+(NSCache*)getCache{
    if (!cache) {
        cache = [[NSCache alloc]init];
    }
    return cache;
}

+(void)setObject:(nullable id)value forKey:(NSString *)forKey{
    [[UserDefaultsUtils getCache] setObject:value forKey:forKey];
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:forKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(nullable id)getObject:(NSString *)forKey{
    NSObject * object = [[UserDefaultsUtils getCache] objectForKey:forKey];
    if (object) {
        return object;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:forKey];
}

+(void)removeObject:(NSString *)forKey{
    [[UserDefaultsUtils getCache] removeObjectForKey:forKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:forKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)clearAll{
    [[UserDefaultsUtils getCache] removeAllObjects];
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSDictionary* dict = [defs dictionaryRepresentation];
    for(id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

@end
