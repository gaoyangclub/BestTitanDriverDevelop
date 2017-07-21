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

static OwnerViewController* instance;

@interface OwnerViewController ()

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
