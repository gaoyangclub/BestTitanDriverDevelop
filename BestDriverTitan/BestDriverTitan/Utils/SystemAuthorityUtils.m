//
//  SystemAuthorityUtils.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "SystemAuthorityUtils.h"
#import "AppDelegate.h"
#import "LocalBundleManager.h"

@implementation SystemAuthorityUtils

+(void)checkLocationAuthority{
    //判断定位是否开启
    if ([CLLocationManager locationServicesEnabled])
    {
        //  判断用户是否允许程序获取位置权限
        if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways)
        {
            //用户允许获取位置权限
        }else
        {
            //用户拒绝开启用户权限
            UIAlertController* alertController = [UIAlertController alertControllerWithTitle:
                                                  [NSString stringWithFormat:@"打开[定位服务权限]来允许%@确定您的位置",[LocalBundleManager getAppName]
                                                   ]
                                                   message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //跳转到定位权限页面
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if( [[UIApplication sharedApplication] canOpenURL:url] ) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }]];
            [((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    }
    else
    {
        UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"打开[定位服务]来允许[XXX]确定您的位置"message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>XXX>始终)" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"去设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.000000) {
                //跳转到定位权限页面
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }else {
                //跳转到定位开关界面
                NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
                if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }]];
        [((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController presentViewController:alertController animated:YES completion:nil];
    }
}

@end
