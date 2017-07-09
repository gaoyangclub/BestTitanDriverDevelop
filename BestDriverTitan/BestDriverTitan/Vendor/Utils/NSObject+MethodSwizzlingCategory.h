//
//  NSObject+MethodSwizzlingCategory.h
//  BestDriverTitan
//
//  Created by 高扬 on 17/7/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MethodSwizzlingCategory)

#pragma 交换实例方法
+ (BOOL)swizzleMethod:(SEL)origSel withMethod:(SEL)altSel;
#pragma 交换class(静态)方法
+ (BOOL)swizzleClassMethod:(SEL)origSel withClassMethod:(SEL)altSel;

@end
