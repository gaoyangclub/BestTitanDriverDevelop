//
//  SplashViewController.h
//  SplashViewTest
//
//  Created by admin on 16/9/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SplashSourceView.h"

@class SplashViewController;

typedef void(^SplashWillFinishHandler)();

typedef void(^SplashWaitingHandler)(SplashWillFinishHandler);

typedef void(^SplashFinishHandler)(SplashViewController*);

@interface SplashViewController : UIViewController

@property(nonatomic,retain)SplashSourceView* sourceView;//显示内容区域
@property(nonatomic,copy)SplashFinishHandler willCompleteHandler;//将要完成 开始完成动画
@property(nonatomic,copy)SplashFinishHandler didCompleteHandler;//完成后回调

@property(nonatomic,copy)SplashWaitingHandler waitingHandler;//等待中
//@property()

-(void)finish;

-(void)waiting;

//+(instancetype)initBySourceView:(UIView*)superView andSource:(SplashSourceView*)sourceView;
+(instancetype)initWithSourceView:(SplashSourceView*)sourceView superView:(UIView*)superView  waitingHandler:(SplashWaitingHandler) waitingHandler;

@end
