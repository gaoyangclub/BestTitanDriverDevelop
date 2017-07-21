//
//  User.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "User.h"

@implementation User

-(BOOL)hasAudited{
    return self.auditStatus && [self.auditStatus isEqualToString:AUDIT_ADMIT];
}

@end
