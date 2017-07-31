//
//  SplashViewController.m
//  SplashViewTest
//
//  Created by admin on 16/9/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()<SplashControllerDelegate>{
    BOOL isWaiting;//
}

@end

@implementation SplashViewController

-(void)setSourceView:(SplashSourceView *)sourceView{
    _sourceView = sourceView;
    if (sourceView.superview != self.view) {
        [self.view addSubview:sourceView];//添加到显示列表
    }
    sourceView.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.sourceView != NULL) {
        self.sourceView.frame = self.view.bounds;
        
        [self startAnimation];//动画开始
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//中间等待中
-(void)waiting{
    // 延迟2秒执行：
//    double delayInSeconds = 3.0;
////    __weak __typeof(self) weakSelf = self;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [self finish];
//    });
    if (self.waitingHandler) {
        self.waitingHandler(^{
            [self finish];
        });
    }
}

//播放结束动画
-(void)finish{
    __weak __typeof(self) weakSelf = self;
    double delay = 0;//TODO 这里无限显示开启界面 实际是根据服务请求等待时间而定
    [UIView animateWithDuration:0.5 delay:delay options:UIViewAnimationOptionCurveEaseIn animations:^{
        //        [self setX:-kScreen_Width];
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.sourceView.alpha = 0;
        if (strongSelf.willCompleteHandler) {
            strongSelf.willCompleteHandler(self);
        }
    } completion:^(BOOL finished) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.view removeFromSuperview];
        if (strongSelf.didCompleteHandler) {
            strongSelf.didCompleteHandler(self);
        }
    }];
}

- (void)startAnimation{
    self.sourceView.alpha = 0.99;
    
    //    __weak __typeof(self) weakSelf = self;
    //    @weakify(self);
    [UIView animateWithDuration:0.6 animations:^{
        self.sourceView.alpha = 1.0;
    } completion:^(BOOL finished) {
        //        @strongify(self);
        if (!isWaiting) {
            isWaiting = YES;
            [self waiting];
        }
    }];
//    [self waiting];
}

-(SplashWaitingHandler)waitingHandler{
    if (!_waitingHandler) {
        _waitingHandler = ^(SplashWillFinishHandler willFinishHandler){
            double delayInSeconds = 3.0;
            //    __weak __typeof(self) weakSelf = self;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                willFinishHandler();
            });
        };
    }
    return _waitingHandler;
}

+(instancetype)initWithSourceView:(SplashSourceView*)sourceView superView:(UIView*)superView  waitingHandler:(SplashWaitingHandler) waitingHandler{
    
    SplashViewController* splashViewController = [[SplashViewController alloc] init];
    splashViewController.view.frame = superView.bounds;//全屏

    splashViewController.sourceView = sourceView;
    splashViewController.waitingHandler = waitingHandler;

    [superView addSubview:splashViewController.view];//添加子对象
    [superView bringSubviewToFront:splashViewController.view];//置顶
    
    [splashViewController viewDidLoad];
    
    [sourceView display];
    
    return splashViewController;
}

@end
