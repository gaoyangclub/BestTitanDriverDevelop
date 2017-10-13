//
//  AppPushMsg.m
//  BestDriverTitan
//
//  Created by admin on 2017/10/10.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AppPushMsg.h"

@implementation AppPushMsg

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.createTime = [[NSDate alloc]init];//记录创建时间
    }
    return self;
}

@end
