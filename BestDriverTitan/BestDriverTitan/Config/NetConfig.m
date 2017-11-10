//
//  NetConfig.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "NetConfig.h"

@implementation NetConfig

static NetModeType netMode;//默认T8生产环境
+(void)load{
    if (DEBUG_MODE) {
        netMode = NetModeTypeTest;
    }else if(T9_Environment){
        netMode = NetModeTypeReleaseT9;//T9专用
    }else{
        netMode = NetModeTypeRelease;
    }
}

+(NetModeType)getCurrentNetMode{
    return netMode;
}

+(void)setCurrentNetMode:(NetModeType)mode{
    netMode = mode;
}

+(NSString*)getDriverNetUrl:(NetModeType)mode{
    switch (mode) {
        case NetModeTypePersonYan:return [SERVER_URL_PERSON_YAN stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypePersonZhou:return [SERVER_URL_PERSON_ZHOU stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypePersonLiu:return [SERVER_URL_PERSON_LIU stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypePersonWang:return [SERVER_URL_PERSON_WANG stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypePersonZhu:return [SERVER_URL_PERSON_ZHU stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypePersonZheng:return [SERVER_URL_PERSON_ZHENG stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypePersonGao:return [SERVER_URL_PERSON_GAO stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypePersonGuo:return [SERVER_URL_PERSON_GUO stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypeDemo:return [SERVER_URL_DEMO stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypeTest:return [SERVER_URL_TEST stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypeUat:return [SERVER_URL_UAT stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypeRelease:return [SERVER_URL_RELEASE stringByAppendingString:SERVER_REST_POSTFIX];
        case NetModeTypeReleaseT9:return [SERVER_URL_RELEASE_T9 stringByAppendingString:SERVER_REST_POSTFIX];
    }
    return [SERVER_URL_TEST stringByAppendingString:SERVER_REST_POSTFIX];
}

+(NSString *)getDownloadHtmlUrl:(NetModeType)mode{
    switch (mode) {
        case NetModeTypeRelease:
        case NetModeTypeReleaseT9:
            return [SERVER_URL_RELEASE stringByAppendingString:SERVER_DOWNLOAD_HTML];
            break;
        default:
            return [SERVER_URL_TEST stringByAppendingString:SERVER_DOWNLOAD_HTML];
            break;
    }
    return [SERVER_URL_TEST stringByAppendingString:SERVER_DOWNLOAD_HTML];
}

static NSArray* netModes;
+(NSArray *)getNetModes{
    if (!netModes) {
        netModes = @[@(NetModeTypeTest),@(NetModeTypeDemo),@(NetModeTypeUat),@(NetModeTypeRelease),@(NetModeTypeReleaseT9),@(NetModeTypePersonLiu),@(NetModeTypePersonWang),@(NetModeTypePersonZheng),
            @(NetModeTypePersonGuo),@(NetModeTypePersonGao)];
    }
    return netModes;
}

@end
