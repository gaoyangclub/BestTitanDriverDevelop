//
//  FlatButton.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlatButton : UIControl

@property(nonatomic,assign) CGFloat cornerRadius;
@property(nonatomic,copy) NSString* title;
@property(nonatomic,retain) UIColor* titleColor;
@property(nonatomic,retain) NSString* titleFontName;
@property(nonatomic,assign) CGFloat titleSize;

@property(nonatomic,retain) UIColor* fillColor;
@property(nonatomic,retain) UIColor* strokeColor;
@property(nonatomic,assign) CGFloat strokeWidth;

@property(nonatomic,assign) CGFloat angle;//旋转角度


@end
