//
//  RootNavigationController.m
//  BestDriverTitan
//
//  Created by admin on 16/12/6.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "RootNavigationController.h"

@interface RootNavigationController ()

@property (nonatomic,retain)UIImageView* navBarHairlineImageView;
@property (nonatomic,retain)UIView* hairlineProxy;

@end

//static RootNavigationController* instance;

@implementation RootNavigationController

//+(instancetype)sharedInstance {
//    @synchronized (self)    {
//        if (instance == nil)
//        {
//            instance = [[self alloc] init];
//        }
//    }
//    return instance;
//}

//+(id)allocWithZone:(NSZone *)zone
//{
//    @synchronized (self) {
//        if (instance == nil) {
//            instance = [super allocWithZone:zone];
//            return instance;
//        }
//    }
//    return nil;
//}

-(UIView *)hairlineProxy{
    if (!_hairlineProxy) {
        _hairlineProxy = [[UIView alloc]init];
        [self.navigationBar addSubview:_hairlineProxy];
        _hairlineProxy.frame = self.navBarHairlineImageView.frame;
    }
    return _hairlineProxy;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationBar.translucent = NO;//    Bar的高斯模糊效果，默认为YES
    [super viewWillAppear:animated];
    self.navigationBar.barTintColor = self.navigationColor;
    self.navBarHairlineImageView.hidden = true;
    
    self.hairlineProxy.backgroundColor = self.hairlineColor;
//    self.navigationBar.backIndicatorImage = self.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];
//    [self.navigationBar setShadowImage:[UIImage new]];//去掉navigationbar下面的那条线,并且如果是用storyboard来创建的Viewcontroller一定要加这句话
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navBarHairlineImageView.hidden = true;
    
}
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNavigationColor:(UIColor *)navigationColor{
    _navigationColor = navigationColor;
    self.navigationBar.barTintColor = navigationColor;
}

-(UIImageView *)navBarHairlineImageView{
//    if (!self.hairlineHidden) {
//        return nil;
//    }
    UIImageView * hailline = [self findHairlineImageViewUnder:self.navigationBar];
    return hailline;
}

-(UIImageView *)findHairlineImageViewUnder:(UIView*)view{
//    [view isKindOfClass:[UIImageView class];
    if([view isKindOfClass:[UIImageView class]] && CGRectGetHeight(view.bounds) <= 1.0) {
        return (UIImageView*)view;
    }
    for (UIView* subView in view.subviews) {
        UIImageView* imageView = [self findHairlineImageViewUnder:subView];
        if (imageView != nil) {
            return imageView;
        }
    }
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
