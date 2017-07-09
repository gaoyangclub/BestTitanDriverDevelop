//
//  FollowAnimateUtil.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/6.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "FollowAnimateManager.h"

@interface FollowAnimateManager()

@property (nonatomic,retain) CAAnimationGroup* followAnimate;
@property (nonatomic,retain) CAKeyframeAnimation* followPathAnimate;
@property (nonatomic,retain) UILabel* iconTag;

@end

static FollowAnimateManager* instance;

@implementation FollowAnimateManager

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

-(CAAnimationGroup *)followAnimate{
    if (!_followAnimate) {
        _followAnimate = [CAAnimationGroup animation];
        
        // 旋转动画
        CABasicAnimation* an1Opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        an1Opacity.fromValue = @1;
        an1Opacity.toValue = @0;
        an1Opacity.fillMode = kCAFillModeForwards;
        an1Opacity.beginTime = 0.5;
        an1Opacity.duration = 0.3;
        an1Opacity.removedOnCompletion = NO;
        
        _followAnimate.animations = @[self.followPathAnimate, an1Opacity];//a1,
        
        //设置组动画的时间
        _followAnimate.duration = 9.9;
        //    groupAnima.fillMode = kCAFillModeForwards;
        _followAnimate.removedOnCompletion = NO;
        _followAnimate.delegate = self;
        
        _followAnimate.fillMode = kCAFillModeForwards;
        
    }
    return _followAnimate;
}

-(CAKeyframeAnimation *)followPathAnimate{
    if (!_followPathAnimate) {
        _followPathAnimate = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        //        pathAnimation.path = path.CGPath;
        _followPathAnimate.duration = 0.5;
        _followPathAnimate.fillMode = kCAFillModeForwards;
        _followPathAnimate.removedOnCompletion = NO;
        //    pathAnimation.delegate = self;
    }
    return _followPathAnimate;
}

-(UILabel *)iconTag{
    if (!_iconTag) {
        _iconTag = [[UILabel alloc]init];
        _iconTag.font = [UIFont fontWithName:ICON_FONT_NAME size:24];
        _iconTag.text = ICON_GUAN_ZHU;
        _iconTag.textColor = FlatOrange;
        
    }
    return _iconTag;
}

-(void)startAnimate:(CGRect)iconFrame{
    self.iconTag.frame = iconFrame;
    [self.iconTag sizeToFit];
    
    if (self.iconTag.superview) {
        [self.iconTag removeFromSuperview];
//        [self.iconTag.layer removeAllAnimations];
        self.followPathAnimate.beginTime = 0;
    }
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    // 添加到窗口
    [window addSubview:self.iconTag];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:self.iconTag.center];
    
    CGFloat rightX = window.bounds.size.width * 0.95;
    
    CGFloat naviHeight = 64;//导航栏高度
    
    [path addCurveToPoint:CGPointMake(rightX,naviHeight + PAGE_MENU_HEIGHT / 2.) controlPoint1:CGPointMake(iconFrame.origin.x, iconFrame.origin.y / 2.) controlPoint2:CGPointMake(rightX, 0)];
    
    self.followPathAnimate.path = path.CGPath;
    
    [self.iconTag.layer addAnimation:self.followAnimate forKey:@"follow"];
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if(flag){
        if (self.iconTag.superview) {
            [self.iconTag removeFromSuperview];
        }
//        NSLog(@"动画组播放结束");
    }
    //    iconTag = nil;
}



@end
