//
//  AppDelegate.m
//  BestDriverTitan 百事通 司机APP
//
//  Created by admin on 16/11/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "GYTabBarController.h"
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

@interface AppDelegate ()

@end

@implementation AppDelegate

/**
 *  mark 暂时使用NormalTabBar
 */
-(UITabBarController*)createNormalTabBar{
//    [UIColor flatTealColor]
    
    UIViewController* itemCtrl1 = [[TaskHomeController alloc] init];
    
    UIViewController* itemCtrl2 = [[ViewController alloc] init];
//    itemCtrl2.view.backgroundColor = [UIColor grayColor];
    
    UIViewController* itemCtrl3 = [[ViewController alloc] init];
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
                            [TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_DAI_FU_KUAN image:ICON_DAI_FU_KUAN selectedImage:ICON_DAI_FU_KUAN_SELECTED] controller:itemCtrl2],
                            [TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_XIAO_XI image:ICON_XIAO_XI selectedImage:ICON_XIAO_XI_SELECTED] controller:itemCtrl3],
                            [TabData initWithParams:[DIYBarData initWithParams:TABBAR_TITLE_WO image:ICON_WO_DE selectedImage:ICON_WO_DE_SELECTED] controller:itemCtrl4],
                            ];
    //    tabBarCtl.view.backgroundColor = [UIColor yellowColor];
    
    //\U00003439 \U000035ad \U000035ae \U000035af \U000035eb \U000035ec \U00003605"
    [tabBarCtl setItemBadge:20 atIndex:0];
    [tabBarCtl setItemBadge:5 atIndex:2];
    tabBarCtl.view.backgroundColor = [UIColor whiteColor];
//    tabBarCtl.view.alpha = 0.3;
    //    [tabBarCtl setItemBadge:80 atIndex:2];
//    [tabBarCtl setItemBadge:100 atIndex:3];
    return tabBarCtl;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    
//    NSNumber* aStr = @0x0135315;
//    NSLog(@"aStr指针内存地址：%x",&aStr);
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    double version = [UIDevice currentDevice].systemVersion.doubleValue;
    if (version >= 8.0) { //添加通知图标等信任设置
        UIUserNotificationSettings* settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    
    OwnerViewController* navigationController = [OwnerViewController sharedInstance];
    navigationController.hairlineHidden = YES;
    navigationController.hairlineColor = COLOR_LINE;
    navigationController.navigationColor = COLOR_PRIMARY;
    [navigationController setViewControllers:@[[self createNormalTabBar]]];
    
    ViewController* leftViewController = [[ViewController alloc]init];//AccountSideHomeController()
    [leftViewController showSwitchArea];
    
    MMDrawerController* drawerController = [[MMDrawerController alloc]init];
    drawerController.leftDrawerViewController = leftViewController;
    drawerController.centerViewController = navigationController;
//    drawerController.rightDrawerViewController = rightViewController;
    
    
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
    
    CGFloat scale = SYSTEM_SCALE_FACTOR;//([UIApplication sharedApplication].delegate).window.screen.scale;
    
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
    
    return YES;
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
