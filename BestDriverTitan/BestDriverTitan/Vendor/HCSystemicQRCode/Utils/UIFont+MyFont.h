//
//  UIFont+MyFont.h
//  HCSystemicQRCodeDemo
//
//  Created by Caoyq on 16/5/4.
//  Copyright © 2016年 honeycao. All rights reserved.
//

#import <UIKit/UIKit.h>

//以iphone5为基础 坐标都以iphone5为基准 进行代码的适配
#define ratio [[UIScreen mainScreen] bounds].size.width / 320.0

@interface UIFont (MyFont)

/**
 *设置字体方法；根据不同手机型号，改变字体大小
 *@param   size   当前机型下字体大小
 *@return  适配的字体大小
 */
+ (UIFont *)FontWithSize:(CGFloat)size;

@end
