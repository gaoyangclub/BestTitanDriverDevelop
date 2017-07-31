//
//  OwnerViewController.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/21.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "RootNavigationController.h"

//根容器 用来控制一些模态界面
@interface OwnerViewController : RootNavigationController

-(instancetype)init __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
+(instancetype)new __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
//更多屏蔽初始化方法参照: http://ios.jobbole.com/89329/#comment-90585

+(instancetype)sharedInstance;

-(void)showSplashView;

-(void)checkPopLoginView;

-(void)popLoginview:(BOOL)animated completion:(void (^)(void))completion;

@end
