//
//  ContactBean.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ContactBean.h"

@implementation ContactBean

-(NSString *)getPhoneCall{
    if (self.mobel) {
        return self.mobel;
    }
    return self.telePhone;
}

@end
