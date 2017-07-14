//
//  CustomModalViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomModalViewController.h"
#import "CustomPresentingController.h"
#import "CustomDismissingController.h"

@interface CustomModalViewController ()

@end

@implementation CustomModalViewController

-(instancetype)init{
    self.transitioningDelegate = self;
    self.modalPresentationStyle = UIModalPresentationCustom;
    return [super init];
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
////    self.transitioningDelegate = self;
////    self.modalPresentationStyle = UIModalPresentationCustom;
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

#pragma mark - UIViewControllerTransitionDelegate -

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[CustomPresentingController alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[CustomDismissingController alloc] init];
}

-(void)cancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
