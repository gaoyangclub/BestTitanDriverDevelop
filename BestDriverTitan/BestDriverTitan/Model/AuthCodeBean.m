//
//  AuthCodeBean.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/4.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AuthCodeBean.h"

@implementation AuthCodeBean

-(NSString *)description{
    return ConcatStrings(@"验证码:",self.authCode);//,@" tel:",self.telphone
}

@end
