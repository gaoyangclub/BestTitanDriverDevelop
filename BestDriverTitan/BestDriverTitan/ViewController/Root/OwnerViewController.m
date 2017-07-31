//
//  OwnerViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OwnerViewController.h"
#import "LoginViewController.h"
#import "UserDefaultsUtils.h"
#import "SplashSourceView.h"
#import "SplashSourceDaDa.h"
#import "SplashViewController.h"
#import "DIYSplashViewModel.h"
#import "LocalBundleManager.h"
#import "VersionManager.h"
#import "HudManager.h"

#import <PgyUpdate/PgyUpdateManager.h>

static OwnerViewController* instance;

@interface OwnerViewController ()<UIAlertViewDelegate>

@end

@implementation OwnerViewController

+(instancetype)sharedInstance {
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

-(void)showSplashView{
    SplashSourceView* sourceView = [[SplashSourceDaDa alloc] init];
    
    __weak __typeof(self) weakSelf = self;
    SplashViewController* splashController =
    [SplashViewController initWithSourceView:sourceView superView:[[UIApplication sharedApplication].windows lastObject] waitingHandler:
          nil
//     ^(SplashWillFinishHandler willFinishHandler) {
//         [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:weakSelf selector:@selector(updateMethod:)];
//     }
//     ^(SplashWillFinishHandler willFinishHandler) {
//         DIYSplashViewModel* viewModel = [[DIYSplashViewModel alloc] init];
//         [viewModel fetchUpdateVersion:^(id returnValue) {
//             appVersion = [AppVersion yy_modelWithJSON:returnValue];
//             //             NSLog(@"appVersion:%@",appVersion);
//             NSString* versionLocal = [LocalBundleManager getAppVersion];
//             int compare = [VersionManager versionComparison:appVersion.version andVersionLocal:versionLocal];
//             if (compare > 0) {//需要弹窗更新
//                 [weakSelf showUpdateAlert];
////                 UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提醒" message:
////                                                        preferredStyle:UIAlertControllerStyleAlert];
////                 [alertController addAction:[UIAlertAction actionWithTitle:@"更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
////                     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appVersion.downloadUrl]];
////                 }]];
////                 [self presentViewController:alertController animated:NO completion:nil];
//             }else{
//                 willFinishHandler();//成功后关闭
//                 [weakSelf checkPopLoginView];
//             }
//         } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
//             //              willFinishHandler();//成功后关闭
//             [HudManager showToast:errorMsg];
//         }];
//     }
     ];
    splashController.willCompleteHandler = ^(SplashViewController* splashController){
        [weakSelf checkPopLoginView];
    };
}

-(void)updateMethod:(NSDictionary*)updateInfo{
    if(updateInfo){
        [self showUpdateAlert];
    }else{//不需要更新
        [self checkPopLoginView];
    }
}

-(void)showUpdateAlert{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提醒" message:ConcatStrings([LocalBundleManager getAppName],@"有新版本，为了您能更好的使用请立即更新!") delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //appVersion.downloadUrl
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:SERVER_DOWNLOAD_URL]];
    [self showUpdateAlert];
}

-(void)checkPopLoginView{
    if (![UserDefaultsUtils getObject:USER_KEY]) {//没有有缓存数据跳出登录页
        [self popLoginview:NO completion:nil];
    }else{//直接刷新页面
        [self diapatchLoginComplete];
//        [self popLoginview:NO];
    }
}

-(void)popLoginview:(BOOL)animated completion:(void (^ __nullable)(void))completion{
//    double delayInSeconds = 0.2;
//    __weak __typeof(self) weakSelf = self;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        
//    });
    LoginViewController* loginViewController = [[LoginViewController alloc]init];
    [self presentViewController:loginViewController animated:animated completion:completion];
}

-(void)diapatchLoginComplete{
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOGIN_COMPLETE object:nil];
}

@end
