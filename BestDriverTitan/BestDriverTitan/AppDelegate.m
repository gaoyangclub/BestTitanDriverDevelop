//
//  AppDelegate.m
//  BestDriverTitan 百世通 司机APP
//
//  Created by admin on 16/11/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "DIYTabBarItem.h"
#import "ViewController.h"
#import "SplashSourceDaDa.h"
#import "SplashViewController.h"
#import "DIYSplashViewModel.h"
#import "RootNavigationController.h"
#import "MMDrawerController.h"
#import "TaskHomeController.h"
#import "TaskViewController.h"
#import "IQKeyboardManager.h"
#import "YYFPSLabel.h"
#import "HudManager.h"
#import "OwnerViewController.h"
#import "UserHomeController.h"
#import "VersionManager.h"
#import "LocalBundleManager.h"

#import <PgySDK/PgyManager.h>
#import <PgyUpdate/PgyUpdateManager.h>

#import "UMMobClick/MobClick.h"

#import <AMapFoundationKit/AMapFoundationKit.h>
#import "SpeechManager.h"
#import "AVSpeechDataSource.h"
#import "TTSDataSource.h"
#import "GeTuiDataSource.h"
#import "BackgroundTimer.h"
#import "MessageViewController.h"
#import "MapNaviSettingController.h"
#import "LoginViewModel.h"

@interface AppDelegate ()//<GeTuiSdkDelegate>

@end

@implementation AppDelegate

- (void)configureAmapAPIKey
{
    if ([AMAP_APIKEY length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    [[AMapServices sharedServices] setEnableHTTPS:YES];//暂时关闭 上线后开启
    [AMapServices sharedServices].apiKey = AMAP_APIKEY;
}
/**
 *  mark 暂时使用NormalTabBar
 */
-(GYTabBarController*)createNormalTabBar{
//    [UIColor flatTealColor]
    
    UIViewController* itemCtrl1 = [[TaskHomeController alloc] init];
    
//    UIViewController* itemCtrl2 = [[ViewController alloc] init];
//    itemCtrl2.view.backgroundColor = [UIColor grayColor];
    
    UIViewController* itemCtrl3 = [[MessageViewController alloc] init];
//    itemCtrl3.view.backgroundColor = [UIColor greenColor];
    
    UIViewController* itemCtrl4 = [[UserHomeController alloc] init];
//    itemCtrl4.view.backgroundColor = [UIColor blueColor];
    
    //    UITabBarController* tabBarCtl = [[UITabBarController alloc] init];
    //    [tabBarCtl setViewControllers:@[itemCtrl1,itemCtrl2,itemCtrl3] animated:YES];
    
    //    tabBarCtl.tabBar.backgroundColor = [UIColor whiteColor];
    
    //    UITabBarItem* barItem1 = [[UITabBarItem alloc] initWithTitle:@"橙色" image:nil tag:11];
    //    UITabBarItem* barItem2 = [[UITabBarItem alloc] initWithTitle:@"灰色" image:nil tag:11];
    //    UITabBarItem* barItem3 = [[UITabBarItem alloc] initWithTitle:@"绿色" image:nil tag:11];
    //    itemCtrl1.tabBarItem = barItem1;
    //    itemCtrl2.tabBarItem = barItem2;
    //    itemCtrl3.tabBarItem = barItem3;
    
    
    GYTabBarController* tabBarCtl = [[GYTabBarController alloc] init];
    tabBarCtl.itemClass = [DIYTabBarItem class];
    tabBarCtl.dataArray = @[[TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_REN_WU image:ICON_DING_DAN selectedImage:ICON_DING_DAN_SELECTED] controller:itemCtrl1],
//                            [TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_DAI_FU_KUAN image:ICON_DAI_FU_KUAN selectedImage:ICON_DAI_FU_KUAN_SELECTED] controller:itemCtrl2],
                            [TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_XIAO_XI image:ICON_XIAO_XI selectedImage:ICON_XIAO_XI_SELECTED] controller:itemCtrl3],
                            [TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_WO image:ICON_WO_DE selectedImage:ICON_WO_DE_SELECTED] controller:itemCtrl4],
                            ];
    //    tabBarCtl.view.backgroundColor = [UIColor yellowColor];
    
    //\U00003439 \U000035ad \U000035ae \U000035af \U000035eb \U000035ec \U00003605"
//    [tabBarCtl setItemBadge:20 atIndex:0];
//    [tabBarCtl setItemBadge:5 atIndex:2];
    tabBarCtl.view.backgroundColor = [UIColor whiteColor];
//    tabBarCtl.view.alpha = 0.3;
    //    [tabBarCtl setItemBadge:80 atIndex:2];
//    [tabBarCtl setItemBadge:100 atIndex:3];
    return tabBarCtl;
}

//保证语音在后台运行
-(void)configureAudit{
    NSError *error = NULL;
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if(error) {
        // Do some error handling
    }
    [session setActive:YES error:&error];
    if (error) {
        // Do some error handling
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    
//    NSNumber* aStr = @0x0135315;
//    NSLog(@"aStr指针内存地址：%x",&aStr);
//    [self configureAudit];
    [SpeechManager setDataSource:[[TTSDataSource alloc]init]];
    
    [self configureAmapAPIKey];
    
    [NetRequestClass initNetWorkStatus];
    
    [IQKeyboardManager sharedManager].enable = YES;
    
//    [self startGeTuiSdk];
    
//    [GeTuiSdk clientId];
    // 注册 APNs
    [self registerRemoteNotification];
//    double version = [UIDevice currentDevice].systemVersion.doubleValue;
//    if (version >= 8.0) { //添加通知图标等信任设置
//        UIUserNotificationSettings* settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//    }
    
    OwnerViewController* navigationController = [OwnerViewController sharedInstance];
    navigationController.hairlineHidden = YES;
    navigationController.hairlineColor = COLOR_LINE;
    navigationController.navigationColor = [UIColor whiteColor];//COLOR_PRIMARY;
    
    self.rootTabBarController = [self createNormalTabBar];
    
    [navigationController setViewControllers:@[self.rootTabBarController]];
    
    ViewController* leftViewController = [[ViewController alloc]init];//AccountSideHomeController()
    [leftViewController showSwitchArea];
    
    MMDrawerController* drawerController = [[MMDrawerController alloc]init];
    drawerController.leftDrawerViewController = leftViewController;
    drawerController.centerViewController = navigationController;
    drawerController.rightDrawerViewController = [[MapNaviSettingController alloc]init];//导航设置
    
    drawerController.showsShadow = YES;
    drawerController.maximumLeftDrawerWidth = drawerController.maximumRightDrawerWidth = DRAWER_WIDTH;
    drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    drawerController.centerHiddenInteractionMode = MMDrawerOpenCenterInteractionModeNone;
    drawerController.view.backgroundColor = [UIColor clearColor];
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = drawerController;//[self createNormalTabBar];//可替换
    
//    CGFloat scale = SYSTEM_SCALE_FACTOR;//([UIApplication sharedApplication].delegate).window.screen.scale;
    
    YYFPSLabel* _fpsLabel = [YYFPSLabel sharedInstance];
//    _fpsLabel.frame = CGRectMake(200, 200, 50, 30);
    _fpsLabel.center = self.window.center;
    [_fpsLabel sizeToFit];
    _fpsLabel.hidden = YES;
    [drawerController.view addSubview:_fpsLabel];
    
    [navigationController showSplashView];
    
    //启动基本SDK
    [[PgyManager sharedPgyManager] startManagerWithAppId:PGY_APPID];
    //启动更新检查SDK
    [[PgyUpdateManager sharedPgyManager] startManagerWithAppId:PGY_APPID];
    
//    [[PgyUpdateManager sharedPgyManager] checkUpdate];
    
    UMConfigInstance.appKey = UM_APPID;
//    UMConfigInstance.ChannelId = @"App Store";
//    UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
//    [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^(void){}];//注册一个周期性执行的任务, 而不管是否运行在后台. timeout>=600
//    //clearKeepAliveTimeout 清除计时器
    
//    self.rootImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.window.width / 2., self.window.height / 2.)];
//    self.rootImage.image = [UIImage imageNamed:@"application"];
//    [self.window addSubview:self.rootImage];
    
    return YES;
}

//-(void)startGeTuiSdk{
//    [GeTuiSdk startSdkWithAppId:GETUI_APPID appKey:GETUI_APPKEY appSecret:GETUI_APPSECRET delegate:self];
////    [GeTuiSdk runBackgroundEnable:YES];
//}

/** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
////        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
////        center.delegate = self;
////        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
////            if (!error) {
////                NSLog(@"request authorization succeeded!");
////            }
////        }];
////        
////        [[UIApplication sharedApplication] registerForRemoteNotifications];
//#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |
                                                                       UIRemoteNotificationTypeSound |
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}

//为了免除开发者维护DeviceToken的麻烦，个推SDK可以帮开发者管理好这些繁琐的事务。应用开发者只需调用个推SDK的接口汇报最新的DeviceToken，即可通过个推平台推送 APNs 消息。示例代码如下：
/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    
    // 向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
}

//在iOS 10 以前，为处理 APNs 通知点击事件，统计有效用户点击数，需在AppDelegate.m里的didReceiveRemoteNotification回调方法中调用个推SDK统计接口：
/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    
    // 将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
