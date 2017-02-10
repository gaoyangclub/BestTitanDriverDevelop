//
//  NSString+YCI.m
//  YCIVADemo
//
//  Created by yanchen on 16/6/21.
//  Copyright © 2016年 yanchen. All rights reserved.
//

#import "NSString+YCI.h"

@implementation NSString (YCI)

+ (NSString *)joinedWithSubStrings:(NSString *)firstStr,...NS_REQUIRES_NIL_TERMINATION{
    
    if(firstStr){
        
        NSMutableArray *array = [NSMutableArray array];
        
        va_list args;
        
        [array addObject:firstStr];
        
        va_start(args, firstStr);
        
        id obj;
        
        while ((obj = va_arg(args, NSString*))) {//
            [array addObject:obj];
        }
        
        va_end(args);
        
        return [array componentsJoinedByString:@""];
    }
    return firstStr;
}

@end
