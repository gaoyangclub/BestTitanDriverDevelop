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

#define DEBUG_TAG @"debug"
#define T9_TAG @"t9"

static User* user;
static User* userProxy;//被观察的用户临时信息
static BOOL isUserProxyMode = NO;//是否监控模式
static BOOL hasPermission = YES;//在监控模式(isUserProxyMode = YES)下 不设置此值为YES无权提交和上传数据

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

+(UIColor *)getActivityColorByCode:(NSString *)code{
    if ([ACTIVITY_CODE_PICKUP_HANDOVER isEqual:code]) {
        return FlatGreen;
    }else if([ACTIVITY_CODE_LOAD isEqual:code]){
        return nil;
    }else if([ACTIVITY_CODE_UNLOAD isEqual:code]){
        return nil;
    }else if([ACTIVITY_CODE_SIGN_FOR_RECEIPT isEqual:code]){
        return FlatSkyBlue;
    }else if([ACTIVITY_CODE_DELIVERY_RECEIPT isEqual:code]){
        return nil;
    }else if([ACTIVITY_CODE_COD isEqual:code]){
        return FlatYellowDark;
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

+(NSString*)getActivityTypeName:(NSString*)code{
    if([Config getActivityIsPickupBean:code]){
        return @"提";
    }else{
        return @"送";
    }
}

+(BOOL)getActivityIsPickupBean:(NSString*)code{
    return [code isEqualToString:ACTIVITY_CODE_PICKUP_HANDOVER] || [code isEqualToString:ACTIVITY_CODE_LOAD];
}

+(NSString *)getVersionDescription{
    NSString* mode = @"";
    if (isUserProxyMode) {
        mode = ConcatStrings(@"(监控模式",(hasPermission ? @"可上报" : @""),@")");
    }
    NSString* baseName;
    if (DEBUG_MODE) {
        baseName = ConcatStrings(@"v",[LocalBundleManager getAppVersion],@"(",@([LocalBundleManager getAppCode]),@")",mode);
    }else{
        baseName = ConcatStrings(@"v",[LocalBundleManager getAppVersion],@"(",@([LocalBundleManager getAppCode]),@")",mode);
    }
    switch ([NetConfig getCurrentNetMode]) {
        case NetModeTypePersonYan:return ConcatStrings(@"Ywj ",baseName);
        case NetModeTypePersonZhou:return ConcatStrings(@"Zq ",baseName);
        case NetModeTypePersonLiu:return ConcatStrings(@"Lz ",baseName);
        case NetModeTypePersonWang:return ConcatStrings(@"Wsj ",baseName);
        case NetModeTypePersonZhu:return ConcatStrings(@"Zjd ",baseName);
        case NetModeTypePersonZheng:return ConcatStrings(@"Zxx ",baseName);
        case NetModeTypePersonGao:return ConcatStrings(@"Gy ",baseName);
        case NetModeTypePersonGuo:return ConcatStrings(@"Glq ",baseName);
        case NetModeTypeDemo:return ConcatStrings(@"Demo ",baseName);
        case NetModeTypeTest:return ConcatStrings(@"Test ",baseName);
        case NetModeTypeUat:return ConcatStrings(@"Uat ",baseName);
        case NetModeTypeRelease:return baseName;
        case NetModeTypeReleaseT9:return ConcatStrings(@"T9 ",baseName);;
    }
    return baseName;
}

+(NSString *)getNetModelName:(NetModeType)mode{
    switch (mode) {
        case NetModeTypePersonYan:return @"颜斯基";
        case NetModeTypePersonZhou:return @"周斯基";
        case NetModeTypePersonLiu:return @"刘斯基";
        case NetModeTypePersonWang:return @"王斯基";
        case NetModeTypePersonZhu:return @"朱斯基";
        case NetModeTypePersonZheng:return @"郑斯基";
        case NetModeTypePersonGao:return @"高斯基";
        case NetModeTypePersonGuo:return @"郭斯基";
        case NetModeTypeDemo:return @"Demo环境";
        case NetModeTypeTest:return @"Test环境";
        case NetModeTypeUat:return @"Uat环境";
        case NetModeTypeRelease:return @"生产环境";
        case NetModeTypeReleaseT9:return @"T9生产环境";
    }
    return @"Test环境";
}

+(NSString *)getPushTypeTitle:(NSString *)type{
    if ([PUSH_TYPE_CREATE isEqual:type]) {
        return @"您收到新的调度任务";
    }else if ([PUSH_TYPE_RESCHEDULE isEqual:type]) {
        return @"您的任务已重新调度";
    }else if ([PUSH_TYPE_CHANGE isEqual:type] ||
              [PUSH_TYPE_TERMINATE isEqual:type] ) {
        return @"您的任务信息有变更";
    }
    return nil;
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

+(void)setUserProxy:(User *)value{
    userProxy = value;
}

+(User *)getUserProxy{
    return userProxy;
}

+(void)setIsUserProxyMode:(BOOL)value{
    isUserProxyMode = value;
}

+(BOOL)getIsUserProxyMode{
    return isUserProxyMode;
}

+(void)setHasPermission:(BOOL)value{
    hasPermission = value;
}

+(BOOL)getHasPermission{
    return hasPermission;
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

+(UIColor *)getPrimaryColor{
    if (isUserProxyMode) {
        return COLOR_USER_PROXY;
    }
    return COLOR_PRIMARY;//FlatSkyBlue//COLOR_YI_WAN_CHENG//rgba(23,182,46,1)
}

+(BOOL)isDebugMode{
    NSString* tag = DEBUG_TAG;
    NSString* identifier = [LocalBundleManager getAppVersion];
    NSString* lastTag = [identifier substringWithRange:NSMakeRange(identifier.length - tag.length, tag.length)];
    return [lastTag isEqualToString:tag];
}

+(BOOL)isT9Environment{
    NSInteger lastOffSet = 0;
    if (DEBUG_MODE) {
        lastOffSet = DEBUG_TAG.length;
    }
    NSString* identifier = [LocalBundleManager getAppVersion];
    NSString* tag = T9_TAG;
    NSString* lastTag = [identifier substringWithRange:NSMakeRange(identifier.length - tag.length - lastOffSet, tag.length)];
    return [lastTag isEqualToString:tag];
}

+(NSString *)getPgyerAppID{
    if (DEBUG_MODE) {
//        return @"0e8c9bf2a0d8fcbaf37a90353405c6c0";
        return @"dba51660a44c3e00888ce2a4b24af81a";
    }else if(T9_Environment){
        return @"d0d592c39e4d75348ded19395698058b";
    }
    return @"5953c90ad7c4d2e8ca9450269c1d81ea";
}

+(NSString *)getPgyerApiKey{
    if (DEBUG_MODE) {
        return @"72fabb9ca801817be273e54018a6b42d";
    }else if(T9_Environment){
        return @"6422db4bf374e613062ec9bf9c0b8b85";
    }
    return @"0e11b5e0eaa8fe91f7e3a60efc8fb744";
}

+(NSString *)getUMengAppID{
    if (DEBUG_MODE) {
        return @"59882e6f310c931831001b36";
    }
    return @"596302f007fe6513f20005c9";
}

+(NSString *)getAmapApiKey{
    if (DEBUG_MODE) {
        return @"b4aa0ec101a8d63030738884cf4af870";
    }
    return @"b4aa0ec101a8d63030738884cf4af870";
}


@end
