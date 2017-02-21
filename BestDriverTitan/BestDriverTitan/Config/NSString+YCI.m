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


+ (NSAttributedString *)simpleAttributedString:(UIColor*)color size:(CGFloat)size context:(NSString*)context{
    NSMutableAttributedString* attrString =[[NSMutableAttributedString alloc]initWithString:context];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, context.length)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(0, context.length)];
//    [UIFont fontWithName:<#(nonnull NSString *)#> size:<#(CGFloat)#>]
     return attrString;
}

+ (NSAttributedString *)simpleAttributedString:(NSString*)face color:(UIColor*)color size:(CGFloat)size context:(NSString*)context{
    NSMutableAttributedString* attrString =[[NSMutableAttributedString alloc]initWithString:context];
    [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, context.length)];
    [attrString addAttribute:NSFontAttributeName value:[UIFont fontWithName:face size:size] range:NSMakeRange(0, context.length)];
    return attrString;
}
     
     
     

@end
