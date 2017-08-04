//
//  User.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Titoken.h"

@interface User : NSObject

@property(nonatomic,copy)NSString* telphone;
@property(nonatomic,copy)NSString* name;
@property(nonatomic,retain)Titoken* tiToken;
@property(nonatomic,copy)NSString* auditStatus;
@property(nonatomic,copy)NSString* remark;
@property(nonatomic,assign)int role;//默认0 最低权限
@property(nonatomic,assign)int stars;//用户数据

-(BOOL)hasAudited;

-(BOOL)isAdmin;

@end
