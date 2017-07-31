//
//  Config.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "Config.h"
#import "UserDefaultsUtils.h"
#import "LocalBundleManager.h"

static User* user;

@implementation Config

+(NSString *)getActivityIconByCode:(NSString *)code{
    if ([ACTIVITY_CODE_PICKUP_HANDOVER isEqual:code]) {
        return ICON_TI_HUO;
    }else if([ACTIVITY_CODE_LOAD isEqual:code]){
        return ICON_ZHUANG_CHE;
    }else if([ACTIVITY_CODE_UNLOAD isEqual:code]){
        return ICON_XIE_HUO;
    }else if([ACTIVITY_CODE_SIGN_FOR_RECEIPT isEqual:code]){
        return ICON_QIAN_SHOU;
    }else if([ACTIVITY_CODE_DELIVERY_RECEIPT isEqual:code]){
        return ICON_HUI_DAN;
    }else if([ACTIVITY_CODE_COD isEqual:code]){
        return ICON_SHOU_KUAN;
    }
    return nil;
}

+(NSString *)getActivityLabelByCode:(NSString *)code{
    if ([ACTIVITY_CODE_PICKUP_HANDOVER isEqual:code]) {
        return TABBAR_TITLE_TI_HUO;
    }else if([ACTIVITY_CODE_LOAD isEqual:code]){
        return TABBAR_TITLE_ZHUANG_CHE;
    }else if([ACTIVITY_CODE_UNLOAD isEqual:code]){
        return TABBAR_TITLE_XIE_HUO;
    }else if([ACTIVITY_CODE_SIGN_FOR_RECEIPT isEqual:code]){
        return TABBAR_TITLE_QIAN_SHOU;
    }else if([ACTIVITY_CODE_DELIVERY_RECEIPT isEqual:code]){
        return TABBAR_TITLE_HUI_DAN;
    }else if([ACTIVITY_CODE_COD isEqual:code]){
        return TABBAR_TITLE_SHOU_KUAN;
    }
    return nil;
}

+(NSString *)getActivityStatusLabel:(NSString *)status{
    if ([ACTIVITY_STATUS_PENDING_REPORT isEqualToString:status]) {
        return @"未上报";
    }else if ([ACTIVITY_STATUS_REPORTING isEqualToString:status]
              || [ACTIVITY_STATUS_REPORTED isEqualToString:status]) {
        return @"已上报";
    }else if ([ACTIVITY_STATUS_CANCELED isEqualToString:status]) {
        return @"已取消";
    }
    return @"未知";
}

+(NSString *)getAppVersionDescribe{
    NSString* baseName = ConcatStrings(@"v",[LocalBundleManager getAppVersion],@"(",[LocalBundleManager getAppCode],@")");
    switch (netMode) {
        case NetModeTypePersonYan:return ConcatStrings(@"Ywj ",baseName);
        case NetModeTypePersonZhou:return ConcatStrings(@"Zq ",baseName);
        case NetModeTypePersonLiu:return ConcatStrings(@"Lz ",baseName);
        case NetModeTypePersonWang:return ConcatStrings(@"Wsj ",baseName);
        case NetModeTypePersonZhu:return ConcatStrings(@"Zjd ",baseName);
        case NetModeTypePersonZheng:return ConcatStrings(@"Zxx ",baseName);
        case NetModeTypeDemo:return ConcatStrings(@"Demo ",baseName);
        case NetModeTypeTest:return ConcatStrings(@"Test ",baseName);
        case NetModeTypeUat:return ConcatStrings(@"Uat ",baseName);
        case NetModeTypeRelease:return baseName;
        case NetModeTypeReleaseT9:return ConcatStrings(@"T9 ",baseName);;
    }
    return baseName;
}

+(void)setUser:(User *)value{
    user = value;
}

+(User *)getUser{
    if (isUserProxyMode) {
        return userProxy;
    }
    if (!user) {
        id userObj = [UserDefaultsUtils getObject:USER_KEY];
        if (userObj) {
            user = [User yy_modelWithJSON:userObj];//记录userInfo
        }
    }
    return user;
}

+(NSString *)getToken{
    if (isUserProxyMode) {
        return userProxy.tiToken.tiToken;
    }
    User* value = [Config getUser];
    if (value && value.tiToken) {
        return value.tiToken.tiToken;
    }
    return nil;
}




@end
