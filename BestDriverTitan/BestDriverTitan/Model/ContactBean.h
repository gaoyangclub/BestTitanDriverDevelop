//
//  ContactBean.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/11.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactBean : NSObject

@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* telePhone;
@property(nonatomic,copy)NSString* mobel;

-(NSString*)getPhoneCall;

@end
