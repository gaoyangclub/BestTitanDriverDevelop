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
    [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:self selector:@selector(updateMethod:)];
}

-(void)updateMethod:(NSDictionary*)updateInfo{
    BOOL needUpdate = NO;
    if(updateInfo){
        NSString* updateVersionName = [updateInfo valueForKey:@"versionName"];
        NSInteger updateVersionCode = [[updateInfo valueForKey:@"versionCode"] integerValue];
        int compare = [VersionManager versionComparison:updateVersionName andVersionLocal:[LocalBundleManager getAppVersion]];
        if (compare > 0 || (compare == 0 && updateVersionCode > [LocalBundleManager getAppCode])) {//真正需要更新
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
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self->updateUrl]];
//        [[PgyUpdateManager sharedPgyManager] updateLocalBuildNumber];//更新本地存储的蒲公英Build号
        [self showUpdateAlert];
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
