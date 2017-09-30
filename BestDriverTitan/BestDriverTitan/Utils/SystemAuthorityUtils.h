//
//  SystemAuthorityUtils.h
//  BestDriverTitan
//  系统权限设置警告检查等
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemAuthorityUtils : NSObject

/**
 检查定位权限是否开启
 */
+(void)checkLocationAuthority;

@end
