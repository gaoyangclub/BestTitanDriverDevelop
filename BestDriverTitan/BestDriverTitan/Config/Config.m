//
//  Config.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "Config.h"

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

@end
