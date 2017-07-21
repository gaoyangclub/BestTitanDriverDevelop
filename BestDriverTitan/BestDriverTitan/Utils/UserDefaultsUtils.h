//
//  UserDefaultsUtils.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtils : NSObject

+(void)setObject:(id)value forKey:(NSString*)forKey;
+(id)getObject:(NSString*)forKey;
+(void)removeObject:(NSString*)forKey;
+(void)clearAll;//整个缓存清除掉

@end
