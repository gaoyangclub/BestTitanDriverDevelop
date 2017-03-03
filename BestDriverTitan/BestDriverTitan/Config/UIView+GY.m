//
//  UIView+GY.m
//  BestDriverTitan
//
//  Created by admin on 17/3/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "UIView+GY.h"

@implementation UIView (GY)

-(void)removeAllSubViews{
    for (UIView* subView in self.subviews) {//子对象全部移除干净
        [subView removeFromSuperview];
    }
}

@end
