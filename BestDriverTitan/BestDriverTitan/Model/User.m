//
//  User.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "User.h"

#define ROLE_ADMIN 9

@implementation User

-(BOOL)hasAudited{
    return self.auditStatus && [self.auditStatus isEqualToString:AUDIT_ADMIT];
}

-(BOOL)isAdmin{
    return self.role == ROLE_ADMIN;
}

@end
