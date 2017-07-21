//
//  NetConfig.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "NetConfig.h"

@implementation NetConfig

+(NSString*)getDriverNetUrl:(NetModeType)mode{
    switch (mode) {
        case NetModeTypePersonYan:return SERVER_URL_PERSON_YAN;
        case NetModeTypePersonZhou:return SERVER_URL_PERSON_ZHOU;
        case NetModeTypePersonLiu:return SERVER_URL_PERSON_LIU;
        case NetModeTypePersonWang:return SERVER_URL_PERSON_WANG;
        case NetModeTypePersonZhu:return SERVER_URL_PERSON_ZHU;
        case NetModeTypePersonZheng:return SERVER_URL_PERSON_ZHENG;
        case NetModeTypeDemo:return SERVER_URL_DEMO;
        case NetModeTypeTest:return SERVER_URL_TEST;
        case NetModeTypeUat:return SERVER_URL_UAT;
        case NetModeTypeRelease:return SERVER_URL_RELEASE;
        case NetModeTypeReleaseT9:return SERVER_URL_RELEASE_T9;
    }
    return SERVER_URL_TEST;
}


@end
