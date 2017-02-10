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

@end

static RootNavigationController* instance;

@implementation RootNavigationController

+(instancetype)sharedInstance {
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
        }
    }
    return instance;
    /**
     替换方案:
     static dispatch_once_t onceToken;
     dispatch_once(&onceToken, ^{
     instance = [[self alloc] init];
     });
     return instance;
     */
}

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

-(void)viewWillAppear:(BOOL)animated{
    self.navigationBar.translucent = YES;//    Bar的高斯模糊效果，默认为YES
    [super viewWillAppear:animated];
    self.navigationBar.barTintColor = self.navigationColor;
    self.navBarHairlineImageView.hidden = true;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navBarHairlineImageView.hidden = false;
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
    if (!self.hairlineHidden) {
        return nil;
    }
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
