//
//  GYTabBarItem.m
//  CustomTabViewController
//
//  Created by admin on 16/10/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "GYTabBarItem.h"

@implementation GYTabBarItem

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self setNeedsLayout];
}

-(void)setItemIndex:(NSInteger)itemIndex{
    _itemIndex = itemIndex;
    [self setNeedsLayout];
}

-(void)setData:(NSObject *)data{
    _data = data;
    [self setNeedsLayout];
}

-(void)setBadgeValue:(NSString *)badgeValue{
    if(_badgeValue != badgeValue){
        _badgeValue = badgeValue;
        [self setNeedsLayout];
    }
}


@end
