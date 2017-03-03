//
//  ASControlNode+GY.m
//  BestDriverTitan
//
//  Created by admin on 17/2/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ASControlNode+GY.h"

@implementation ASControlNode (GY)

//@dynamic showTouchEffect;
//static const void *ShowTouchEffectKey2 = &ShowTouchEffectKey2;

//利用runtime进行属性扩展
//-(void)setShowTouchEffect:(BOOL)showTouchEffect{
////    objc_setAssociatedObject(self, ShowTouchEffectKey2, @(showTouchEffect), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
////    [self setNeedsLayout];
//    [self checkTouechEffect:showTouchEffect];
//}

//-(BOOL)showTouchEffect{
//    return objc_getAssociatedObject(self, ShowTouchEffectKey2);
//}

-(void)setShowTouch:(BOOL)value{
    [self checkTouechEffect:value];
}

-(void)checkTouechEffect:(BOOL)showTouchEffect{
    if (showTouchEffect) {
        [self addTarget:self action:@selector(itemTouchedUpInside) forControlEvents:ASControlNodeEventTouchUpInside];
        [self addTarget:self action:@selector(itemTouchedUpOutside) forControlEvents:ASControlNodeEventTouchUpOutside];
        [self addTarget:self action:@selector(itemTouchedDown) forControlEvents:ASControlNodeEventTouchDown];
        [self addTarget:self action:@selector(itemTouchedDown) forControlEvents:ASControlNodeEventTouchDownRepeat];
        [self addTarget:self action:@selector(itemTouchedCancel) forControlEvents:ASControlNodeEventTouchCancel];
    }else{
        [self removeTarget:self action:@selector(itemTouchedUpInside) forControlEvents:ASControlNodeEventTouchUpInside];
        [self removeTarget:self action:@selector(itemTouchedUpOutside) forControlEvents:ASControlNodeEventTouchUpOutside];
        [self removeTarget:self action:@selector(itemTouchedDown) forControlEvents:ASControlNodeEventTouchDown];
        [self removeTarget:self action:@selector(itemTouchedDown) forControlEvents:ASControlNodeEventTouchDownRepeat];
        [self removeTarget:self action:@selector(itemTouchedCancel) forControlEvents:ASControlNodeEventTouchCancel];
    }
}

//-(void)layout{
//    
//    [super layout];
//}

-(void)itemTouchedUpOutside{
    self.alpha = 1;
}
-(void)itemTouchedDown{
    self.opaque = YES;
    self.alpha = 0.5;
//    NSLog(@"ASControlNode点击按下");
}
- (void)itemTouchedUpInside{
    self.alpha = 1;
}
- (void)itemTouchedCancel{
    self.alpha = 1;
}




@end
