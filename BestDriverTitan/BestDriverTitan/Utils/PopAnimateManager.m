//
//  PopAnimateManager.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/7/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PopAnimateManager.h"

@interface PopAnimateManager()

//@property(nonatomic,retain)POPSpringAnimation* buttonClickAnimation;

@end


//static PopAnimateManager* instance;

@implementation PopAnimateManager

//+(instancetype)sharedInstance {
//    @synchronized (self)    {
//        if (instance == nil)
//        {
//            instance = [[self alloc] init];
//        }
//    }
//    return instance;
//}

//-(POPSpringAnimation *)buttonClickAnimation{
//    if (!_buttonClickAnimation) {
//        _buttonClickAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//        _buttonClickAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
//        _buttonClickAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(3.0, 3.0)];
//        _buttonClickAnimation.springBounciness = 18.0;
//    }
//    return _buttonClickAnimation;
//}

+(void)startClickAnimation:(UIView*)sender{
    id animation = [sender.layer pop_animationForKey:@"buttonClickAnimation"];
    if (!animation) {//动画不存在
        POPSpringAnimation* _buttonClickAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        _buttonClickAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
        _buttonClickAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(3.0, 3.0)];
        _buttonClickAnimation.springBounciness = 18.0;
        [sender.layer pop_addAnimation:_buttonClickAnimation forKey:@"buttonClickAnimation"];
    }
}

+(void)startShakeAnimation:(UIView *)sender{
    [self startShakeAnimation:sender bounciness:20];
}

+(void)startShakeAnimation:(UIView *)sender bounciness:(CGFloat)bounciness{
    id animation = [sender.layer pop_animationForKey:@"shakeAnimation"];
//    [sender.layer pop_removeAnimationForKey:@"shakeAnimation"];//先移除掉此动画
    if (!animation) {//动画不存在
        POPSpringAnimation *shake = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
        shake.springBounciness = bounciness;
        shake.velocity = @(1000);
        [sender.layer pop_addAnimation:shake forKey:@"shakeAnimation"];
    }
}


@end
