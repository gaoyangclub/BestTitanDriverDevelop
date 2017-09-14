//
//  CustomPopModelController.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomPopModelView.h"
#import "AppDelegate.h"

#define DEFAULT_LEFT_MARGIN 50
#define DEFAULT_TOP_MARGIN 140

@interface CustomPopModelView (){
    UIControl* _contentView;
}

@end

@implementation CustomPopModelView

-(UIControl *)contentView{
    if (!_contentView) {
        _contentView = [[UIControl alloc]init];
        _contentView.layer.cornerRadius = 10;
        _contentView.layer.masksToBounds = YES;
        _contentView.backgroundColor = [UIColor whiteColor];
//        _contentView.userInteractionEnabled = YES;
//        [_contentView setShowTouch:YES];
        [self addSubview:_contentView];
    }
    return _contentView;
}

-(instancetype)init{
    self.topMargin = DEFAULT_TOP_MARGIN;
    self.leftMargin = DEFAULT_LEFT_MARGIN;
    self.popFromDirection = CustomPopDirectionTop;
    self.popToDirection = CustomPopDirectionTop;
    self.cancelOnTouchOutside = YES;
    return [super init];
}

-(UIView*)getParentView{
    return [[UIApplication sharedApplication].windows lastObject];
}

-(void)show{
    self.opaque = YES;
    self.backgroundColor = [FlatGrayDark colorWithAlphaComponent:0.5];
    
    UIView* parent = [self getParentView];
//     添加到窗口
    [parent addSubview:self];
    
    //    window.userInteractionEnabled = YES;
    
//    UIViewController* drawerController = (UIViewController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
    
//    [self willMoveToParentViewController:window.rootViewController];
    
//    [window.rootViewController addChildViewController:self];
    
//    [self didMoveToParentViewController:window.rootViewController];
    
    self.frame = parent.bounds;
    
    [self addTarget:self action:@selector(onTouchOutside) forControlEvents:UIControlEventTouchUpInside];
    
//    UITapGestureRecognizer* tapClick = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
//    tapClick.numberOfTapsRequired = 1;//触摸次数
////    self.view.userInteractionEnabled = YES;
//    [self.view addGestureRecognizer:tapClick];
    CGFloat contentHeight = CGRectGetHeight(self.bounds) - self.topMargin * 2;
    if (self.minHeight > 0 && contentHeight < self.minHeight) {
        contentHeight = self.minHeight;
    }
    CGFloat contentWidth = CGRectGetWidth(self.bounds) - self.leftMargin * 2;
    if (self.minWidth > 0 && contentWidth < self.minWidth) {
        contentWidth = self.minWidth;
    }
    self.contentView.frame = CGRectMake(0,0,
                              contentWidth,
                              contentHeight);
    [self viewDidLoad];
    
    [self popContentView];
}

-(void)viewDidLoad{
    
}

-(void)popContentView{
    UIView *toView = self.contentView;
    
    CGFloat contentCenterY;
    
    if (self.popFromDirection == CustomPopDirectionBottom) {
        contentCenterY = CGRectGetHeight(self.bounds);// + self.view.center.y;
    }else{
        contentCenterY = 0;//-self.view.center.y;
    }
    CGPoint center = self.center;
    center.y = contentCenterY;
    toView.center = center;
    
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    positionAnimation.toValue = @(self.center.y);
    positionAnimation.springBounciness = 10;
//    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
//        [transitionContext completeTransition:YES];
//    }];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 20;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    
    [toView.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
    [toView.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

-(void)onTouchOutside{
    if (self.cancelOnTouchOutside) {
        [self dismiss];
    }
}

-(void)dismiss{
    [self dismissContentView];
}

-(void)clear{
    if (self.superview) {
        [self removeFromSuperview];
    }
}

-(void)dismissContentView{
    UIView *toView = self.contentView;
    
    CGFloat contentCenterY;
    if (self.popToDirection == CustomPopDirectionBottom) {
        contentCenterY = CGRectGetHeight(self.bounds) + self.center.y;
    }else{
        contentCenterY = -self.center.y;
    }
    
    POPBasicAnimation *closeAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    closeAnimation.toValue = [NSNumber numberWithFloat:contentCenterY];
    [closeAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [self clear];
    }];
    
    POPBasicAnimation *scaleDownAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleDownAnimation.springBounciness = 20;
    scaleDownAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    
//    closeAnimation.duration = scaleDownAnimation.duration = 5;
    
    [toView.layer pop_addAnimation:closeAnimation forKey:@"closeAnimation"];
    [toView.layer pop_addAnimation:scaleDownAnimation forKey:@"scaleDown"];
}


@end
