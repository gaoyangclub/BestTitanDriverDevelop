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
#import "UpdateVersionManager.h"
#import "AdminViewController.h"
#import "AmapLocationService.h"
#import "BackgroundTimer.h"
#import "LocationViewModel.h"


static OwnerViewController* instance;

@interface OwnerViewController ()<UIAlertViewDelegate,LoginViewDelegate,AdminViewDelegate>{
//    SplashWillFinishHandler splashWillFinishHandler;
//    NSString* updateUrl;
//    NSString* updateNote;
}

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
//    SplashViewController* splashController =
    [SplashViewController initWithSourceView:sourceView superView:[[UIApplication sharedApplication].windows lastObject] waitingHandler:
//          nil
     ^(SplashWillFinishHandler willFinishHandler) {
         if (DEBUG_MODE) {//调试版可以避免更新
             [[UpdateVersionManager sharedInstance] checkVersionUpdate:^(NSDictionary * updateInfo) {
                 if(!updateInfo){
                     willFinishHandler();
                     [weakSelf checkPopLoginView];
                 }
             } cancelHandler:^{
                 willFinishHandler();
                 [weakSelf checkPopLoginView];
             }];
         }else{//生产环境不能取消更新
             [[UpdateVersionManager sharedInstance] checkVersionUpdate:YES resultHandler:^(NSDictionary * updateInfo) {
                 if(!updateInfo){
                     willFinishHandler();
                     [weakSelf checkPopLoginView];
                 }
             } cancelHandler:nil];
         }
//         __strong typeof(weakSelf) strongSelf = weakSelf;
//         strongSelf->splashWillFinishHandler = willFinishHandler;
//         [[PgyUpdateManager sharedPgyManager] checkUpdateWithDelegete:strongSelf selector:@selector(updateMethod:)];
     }
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
//    splashController.willCompleteHandler = ^(SplashViewController* splashController){
//        [weakSelf checkPopLoginView];
//    };
}

-(void)checkPopLoginView{
    User* currentUser = [Config getUser];
    if (!currentUser) {//没有有缓存数据跳出登录页
        [self popLoginview:NO completion:nil];
    }else{
        [self autoLoginComplete:currentUser];
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
    loginViewController.delegate = self;
    [self presentViewController:loginViewController animated:animated completion:completion];
}

-(void)autoLoginComplete:(User *)user{
    
    NSNumber* modeValue = [UserDefaultsUtils getObject:NET_MODE_KEY];
    if (modeValue) {
        [NetConfig setCurrentNetMode:[modeValue integerValue]];
    }
    
    if ([user isAdmin]) {//管理员权限
        [self popAdminView:YES completion:nil];
    }else{
        [self checkUserAudit:user];//直接刷新界面
    }
}

-(void)loginWillDismiss:(User *)user{
    if (![user isAdmin]) {//管理员权限
        [self checkUserAudit:user];//直接刷新界面
    }
}

-(void)loginDidDismiss:(User *)user{
    if ([user isAdmin]) {//管理员权限
        [self popAdminView:YES completion:nil];
    }
}

-(void)popAdminView:(BOOL)animated completion:(void (^ __nullable)(void))completion{
    [Config setIsUserProxyMode:NO];//还原普通模式
    AdminViewController* adminViewController = [[AdminViewController alloc]init];
    adminViewController.delegate = self;
    [self presentViewController:adminViewController animated:animated completion:completion];
}

-(void)adminDidReturnBack{//继续返回登录界面
    [self logout:nil];
}

-(void)adminLoginComplete:(User *)user{//直接刷新界面
    [self checkUserAudit:user];
}

-(void)checkUserAudit:(User *)user{
    if ([user hasAudited]) {
        [self diapatchLoginComplete];
    }else{
        [HudManager showToast:@"该用户暂未通过审核，请先到系统中录入用户信息!"];
//        [self pushViewController:<#(nonnull UIViewController *)#> animated:YES];//进入审核界面
    }
}

-(void)diapatchLoginComplete{
    if ([Config getIsUserProxyMode]) {
        self.navigationColor = COLOR_USER_PROXY;
    }else{
        self.navigationColor = [UIColor whiteColor];
        [AmapLocationService startUpdatingLocation];//定位开启
        [BackgroundTimer start:HEART_BEAT_INTERVAL];
        // 延迟2秒执行：
//        double delayInSeconds = 5.0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            
//            [LocationViewModel sendLocationPoints];
//            
//        });
    }
    self.isLogin = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOGIN_COMPLETE object:nil];
}

-(void)logout:(void (^ __nullable)(void))completion{
    if ([Config getIsUserProxyMode]) {
        [self popAdminView:YES completion:completion];
    }else{
        [AmapLocationService stopUpdatingLocation];//关闭定位
        [BackgroundTimer clear];
        [UserDefaultsUtils removeObject:USER_KEY];//清除数据
        [self popLoginview:YES completion:completion];
    }
    self.isLogin = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOGOUT object:nil];
}

@end
