//
//  OpenUrlUtils.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OpenUrlUtils.h"

@implementation OpenUrlUtils

+(void)openTelephone:(NSString *)phone{
    NSString* string = [NSString stringWithFormat:@"tel://%@",phone];
    [OpenUrlUtils openUrlByString:string];
}

+(void)openUrlByString:(NSString*)string{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string]];
}

@end
