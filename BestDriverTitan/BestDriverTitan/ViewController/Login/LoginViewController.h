//
//  LoginViewController.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/19.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>
@optional
-(void)loginWillDismiss:(User*)user;//界面将要消失
@optional
-(void)loginDidDismiss:(User*)user;//界面完全消失
@end

#define MAX_COUNT_DOWN 30

@interface LoginViewController : UIViewController

@property (nonatomic, weak) id<LoginViewDelegate> delegate;

@end
