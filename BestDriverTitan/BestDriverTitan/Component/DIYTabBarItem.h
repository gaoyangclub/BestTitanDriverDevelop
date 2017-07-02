//
//  DIYTabBarItem.h
//  CustomTabViewController
//
//  Created by admin on 16/10/24.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "GYTabBarItem.h"

@interface DIYTabBarItem : GYTabBarItem

@end

@interface  DIYBarData: NSObject

+(instancetype)initWithParams:(NSString *)title image:(NSString *)image;
+(instancetype)initWithParams:(NSString*)title image:(NSString*)image selectedImage:(NSString*)selectedImage;

@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* image;
@property(nonatomic,copy) NSString* selectedImage;

@end
