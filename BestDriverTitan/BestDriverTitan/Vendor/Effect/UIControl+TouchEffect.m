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

@dynamic showTouchEffect;

static const void *ShowTouchEffectKey = &ShowTouchEffectKey;

//利用runtime进行属性扩展
-(void)setShowTouchEffect:(BOOL)showTouchEffect{
    objc_setAssociatedObject(self, ShowTouchEffectKey, @(showTouchEffect), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsLayout];
}

-(BOOL)showTouchEffect{
    return objc_getAssociatedObject(self, ShowTouchEffectKey);
}

//-(void)setTouchEffect:(BOOL)open{
////    _openTouchEffect = open;
//    [self setNeedsLayout];
//}

-(void)layoutSubviews{
    if (self.showTouchEffect) {
        [self addTarget:self action:@selector(itemTouchedUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(itemTouchedUpOutside) forControlEvents:UIControlEventTouchUpOutside];
        [self addTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(itemTouchedCancel) forControlEvents:UIControlEventTouchCancel];
    }else{
        [self removeTarget:self action:@selector(itemTouchedUpInside) forControlEvents:UIControlEventTouchUpInside];
        [self removeTarget:self action:@selector(itemTouchedUpOutside) forControlEvents:UIControlEventTouchUpOutside];
        [self removeTarget:self action:@selector(itemTouchedDown) forControlEvents:UIControlEventTouchDown];
        [self removeTarget:self action:@selector(itemTouchedCancel) forControlEvents:UIControlEventTouchCancel];
    }
    [super layoutSubviews];
}

-(void)itemTouchedUpOutside{
    self.alpha = 1;
}
-(void)itemTouchedDown{
    self.alpha = 0.5;
}
- (void)itemTouchedUpInside{
    self.alpha = 1;
}
- (void)itemTouchedCancel{
    self.alpha = 1;
}

@end
