//
//  HotMarkView.h
//  BestDriverTitan
//
//  Created by admin on 2017/10/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotMarkView : UIView

@property(nonatomic,copy)NSString* title;//标签内的文字
@property(nonatomic,retain)UIColor* titleColor;//标签文字的颜色
@property(nonatomic,assign)CGFloat titleSize;//标签文字大小

@property(nonatomic,retain)UIColor* fillColor;//标签填充色

@end
