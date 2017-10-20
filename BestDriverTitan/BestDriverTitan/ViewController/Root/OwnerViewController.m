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
#import "GeTuiSdk.h"
#import "LoginViewModel.h"
#import "AppDelegate.h"
#import "AppPushMsg.h"
#import "PushMessageHelper.h"


static OwnerViewController* instance;

@interface OwnerViewController ()<UIAlertViewDelegate,LoginViewDelegate,AdminViewDelegate,GeTuiSdkDelegate>{
//    SplashWillFinishHandler splashWillFinishHandler;
//    NSString* updateUrl;
//    NSString* updateNote;
}

@property(nonatomic,retain)LoginViewModel* loginViewModel;

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

-(LoginViewModel *)loginViewModel{
    if (!_loginViewModel) {
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
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
    if (DEBUG_MODE) {//调试版要自动设置存储的线路
        NSNumber* modeValue = [UserDefaultsUtils getObject:NET_MODE_KEY];
        if (modeValue) {
            [NetConfig setCurrentNetMode:[modeValue integerValue]];
        }
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
//        [self pushViewController:<#(nonnull UIViewController *)#> animated:YES];//进入审核界面
    }
}

-(void)diapatchLoginComplete{
    if ([Config getIsUserProxyMode]) {
        self.navigationColor = COLOR_USER_PROXY;
    }else{
        self.navigationColor = [UIColor whiteColor];
        
        // 主线程执行：
//        dispatch_async(dispatch_get_main_queue(), ^{
        [self startGeTuiSdk];
//            [(AppDelegate*)[UIApplication sharedApplication].delegate startGeTuiSdk];
//        });
        [PushMessageHelper start];//开启推送存储
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
        [GeTuiSdk destroy];//关闭推送
        [PushMessageHelper stop];//停止并清除数据
        [AmapLocationService stopUpdatingLocation];//关闭定位
        [BackgroundTimer clear];
        [UserDefaultsUtils removeObject:USER_KEY];//清除数据
        [self popLoginview:YES completion:completion];
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;//登出后清除掉
    }
    self.isLogin = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOGOUT object:nil];
}


-(void)startGeTuiSdk{
    [GeTuiSdk startSdkWithAppId:GETUI_APPID appKey:GETUI_APPKEY appSecret:GETUI_APPSECRET delegate:self];//开启推送
    [GeTuiSdk runBackgroundEnable:YES];
    
    NSString* clientId = [GeTuiSdk clientId];
    if(clientId){//sdk早就注册了
        [self registerGeTuiAppClient:clientId];
    }
}

#pragma GeTuiSdkDelegate
/** SDK启动成功返回cid */
-(void)GeTuiSdkDidRegisterClient:(NSString *)clientId{
    //    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    [self registerGeTuiAppClient:clientId];
}

-(void)registerGeTuiAppClient:(NSString*)clientId{
    LoginViewModel* loginViewModel = [[LoginViewModel alloc]init];
    __weak __typeof(self) weakSelf = self;
    [loginViewModel registerGeTuiAppClient:clientId returnBlock:^(id returnValue) {
        NSString *aString = [[NSString alloc] initWithData:returnValue encoding:NSUTF8StringEncoding];
        if ([@"true" isEqualToString:aString]) {
            NSLog(@"registerGeTuiAppClient --------------------------------------> onSuccess result:%@ \n clientId:%@",returnValue,clientId);
        }else{
            NSLog(@"注册个推客户端返回异常 返回值result:%@",returnValue);
        }
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        if (errorMsg) {
            [HudManager showToast:errorMsg];
        }
        [weakSelf registerGeTuiAppClient:clientId];//继续注册
    }];
}

#pragma GeTuiSdkDelegate
-(void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId{
    if (payloadData) {
        NSString *payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes
                                              length:payloadData.length
                                            encoding:NSUTF8StringEncoding];
        NSLog(@"Payload Msg:%@", payloadMsg);
        AppPushMsg* pushMsg = [AppPushMsg yy_modelWithJSON:payloadData];
        [self sendPushMsg:pushMsg];
    }
    // 汇报个推自定义事件
    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];
}

-(void)sendPushMsg:(AppPushMsg*)pushMsg{
    if ([pushMsg.type isEqual:PUSH_TYPE_CREATE] ||
        [pushMsg.type isEqual:PUSH_TYPE_RESCHEDULE] ||
        [pushMsg.type isEqual:PUSH_TYPE_CHANGE] ||
        [pushMsg.type isEqual:PUSH_TYPE_TERMINATE]
        ) {
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_REFRESH_SHIPMENTS object:pushMsg];
    }
}

@end
