//
//  UIControl+TouchEffect.m
//  BestDriverTitan
//
//  Created by admin on 16/12/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UIControl+TouchEffect.h"
#import <objc/runtime.h>

@interface UIControl(){
//    BOOL _openTouchEffect;
}

@end

@implementation UIControl (TouchEffect)

//@dynamic showTouchEffect;

//static const void *ShowTouchEffectKey = &ShowTouchEffectKey;

//利用runtime进行属性扩展
//-(void)setShowTouchEffect:(BOOL)showTouchEffect{
////    objc_setAssociatedObject(self, ShowTouchEffectKey, @(showTouchEffect), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
////    [self setNeedsLayout];
//    [self checkTouechEffect:showTouchEffect];
//}

//-(BOOL)showTouchEffect{
//    return objc_getAssociatedObject(self, ShowTouchEffectKey);
//}

//-(void)setTouchEffect:(BOOL)open{
////    _openTouchEffect = open;
//    [self setNeedsLayout];
//}

-(void)setShowTouch:(BOOL)value{
    [self checkTouechEffect:value];
}

//-(void)layoutSubviews{
-(void)checkTouechEffect:(BOOL)showTouchEffect{
    //    if (self.showTouchEffect) {
    if (showTouchEffect) {
//        self.opaque = YES;
//        self.alpha = 0.95;
        [self addTarget:self action:@selector(itemTouchedUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(itemTouchedUpOutside) forControlEvents:UIControlEventTouchUpOutside];
//        [self addTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDragEnter];
        [self addTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDownRepeat];
        [self addTarget:self action:@selector(itemTouchedCancel) forControlEvents:UIControlEventTouchCancel];
    }else{
//        self.alpha = 1;
        [self removeTarget:self action:@selector(itemTouchedUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self removeTarget:self action:@selector(itemTouchedUpOutside) forControlEvents:UIControlEventTouchUpOutside];
        [self removeTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDown];
        [self removeTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDownRepeat];
        [self removeTarget:self action:@selector(itemTouchedCancel) forControlEvents:UIControlEventTouchCancel];
    }
    [super layoutSubviews];
}

-(void)itemTouchedUpOutside{
    self.alpha = 1;
}
-(void)itemTouchedDown{
//    self.opaque = YES;
    self.alpha = 0.5;
//    NSLog(@"按下alpha 0.5");
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(touchDelayEffect:) object:NULL];
}
- (void)itemTouchedUpInside{
    [self performSelector:@selector(touchDelayEffect:) withObject:NULL afterDelay:0.05];
    
//    double delayInSeconds = 0.02;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        // code to be executed on the main queue after delay
//        self.alpha = 1;
//    });
}

-(void)touchDelayEffect:(nullable id)object{
    self.alpha = 1;
}

- (void)itemTouchedCancel{
    self.alpha = 1;
}

@end
