//
//  UICreationUtils.h
//  BestDriverTitan
//
//  Created by admin on 16/12/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UICreationUtils : NSObject

+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color;
+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text sizeToFit:(BOOL)sizeToFit;
+(UILabel*)createLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text sizeToFit:(BOOL)sizeToFit superView:(UIView*)superView;


+(UILabel*)createNavigationTitleLabel:(CGFloat)size color:(UIColor*)color text:(NSString*)text superView:(UIView*)superView;
+(UIBarButtonItem*)createNavigationLeftButtonItem:(UIColor*)themeColor target:(id)target action:(SEL)action;
+(UIBarButtonItem*)createNavigationNormalButtonItem:(UIColor*)themeColor font:(UIFont*)font text:(NSString*)text target:(id)target action:(SEL)action;

@end
