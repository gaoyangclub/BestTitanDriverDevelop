//
//  UpdateVersionManager.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "UpdateVersionManager.h"
#import <PgyUpdate/PgyUpdateManager.h>
#import "VersionManager.h"
#import "AppDelegate.h"

static UpdateVersionManager* instance;

@interface UpdateVersionManager()<UIAlertViewDelegate>{
    UpdateResultHandler updateResultHandler;
    NSString* updateUrl;
    NSString* updateNote;
    BOOL updateNecessary;//是否必须更新
    UpdateCancelHandler updateCancelHandler;
}

@end

@implementation UpdateVersionManager

+(instancetype)sharedInstance {
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

-(void)checkVersionUpdate:(UpdateResultHandler)resultHandler{
    [self checkVersionUpdate:resultHandler cancelHandler:nil];
}

-(void)checkVersionUpdate:(UpdateResultHandler)resultHandler cancelHandler:(UpdateCancelHandler)cancelHandler{
    [self checkVersionUpdate:NO resultHandler:resultHandler cancelHandler:cancelHandler];
}

-(void)checkVersionUpdate:(BOOL)necessary resultHandler:(UpdateResultHandler)resultHandler cancelHandler:(UpdateCancelHandler)cancelHandler{
    self->updateNecessary = necessary;
    self->updateResultHandler = resultHandler;
    self->updateCancelHandler = cancelHandler;
    [self startCheckVersionUpdate];
}

-(void)startCheckVersionUpdate{
    if (![NetRequestClass netWorkReachability]) {//网络异常
        UIAlertView *alert;
        NSString* alertTitle;
        NSString* alertMessage;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.000000) {
            alertTitle = [NSString stringWithFormat:@"[使用无线局域网与蜂窝移动的应用]来允许%@使用网络",[LocalBundleManager getAppName]];
            alertMessage = [NSString stringWithFormat:@"请在系统设置中开启网络权限\n(设置>蜂窝移动网络>使用无线局域网与蜂窝移动的应用>%@>开启)",[LocalBundleManager getAppName]];
        }else{
            alertTitle = [NSString stringWithFormat:@"打开wifi来允许%@使用网络",[LocalBundleManager getAppName]];
            alertMessage = @"请在系统设置中开启网络权限\n(设置>无线局域网>开启)";
        }
        alert = [[UIAlertView alloc] initWithTitle:alertTitle message:alertMessage delegate:self cancelButtonTitle:@"去设置" otherButtonTitles:@"取消", nil];
        alert.tag = 404;
        [alert show];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventAppBecomeActive)
                                                     name:EVENT_APP_BECOME_ACTIVE
                                                   object:nil];
    }else{
        [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
    }
}

-(void)eventAppBecomeActive{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_APP_BECOME_ACTIVE object:nil];//先移除掉
    [self startCheckVersionUpdate];//继续检查
}

-(void)updateMethod:(NSDictionary*)updateInfo{
    BOOL needUpdate = NO;
    if(updateInfo){
        NSString* updateVersionName = [updateInfo valueForKey:@"versionName"];
        NSInteger updateVersionCode = [[updateInfo valueForKey:@"versionCode"] integerValue];
//        int compare = [VersionManager versionComparison:updateVersionName andVersionLocal:[LocalBundleManager getAppVersion]];
//        compare > 0 || (compare == 0 && //只判断versionCode
        if (updateVersionCode > [LocalBundleManager getAppCode]) {//真正需要更新
            self->updateUrl = [updateInfo valueForKey:@"appUrl"];
            self->updateNote = [updateInfo valueForKey:@"releaseNote"];
            [self showUpdateAlert];
            needUpdate = YES;
        }
    }
    if (self->updateResultHandler) {
        self->updateResultHandler(needUpdate ? updateInfo : nil);
    }
}

-(void)showUpdateAlert{
    UIAlertView * alert;
    if (self->updateNecessary) {
        alert = [[UIAlertView alloc]initWithTitle:@"有新版本，请立即更新!" message:self->updateNote delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
    }else{
        alert = [[UIAlertView alloc]initWithTitle:@"有新版本，请立即更新!" message:self->updateNote delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:@"稍后更新", nil];
    }
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //appVersion.downloadUrl
    if(buttonIndex == 0){
        if (alertView.tag == 404) {
            NSURL *url;
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.000000) {
                url = [NSURL URLWithString:@"App-Prefs:root=MOBILE_DATA_SETTINGS_ID"];//跳转蜂窝移动设置页面
            }else{
                url = [NSURL URLWithString:@"prefs:root=WIFI"];//跳转wifi
            }
            if( [[UIApplication sharedApplication] canOpenURL:url] ) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }else{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self->updateUrl]];
            //        [[PgyUpdateManager sharedPgyManager] updateLocalBuildNumber];//更新本地存储的蒲公英Build号
            [self showUpdateAlert];
        }
    }else{
        if(self->updateCancelHandler){
            self->updateCancelHandler();
        }
    }
}

-(void)getLastVersionInfo:(ReturnValueBlock)returnBlock{
    [NetRequestClass NetRequestPOSTWithRequestURL:PGY_VERSION_GROUP_URL WithParameter:@{@"aId":PGY_APPID,@"_api_key":PGY_APIKEY} headers:nil WithReturnValeuBlock:returnBlock WithFailureBlock:nil];
}

@end
