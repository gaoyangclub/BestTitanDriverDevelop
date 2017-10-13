//
//  RoundBackView.h
//  BestDriverTitan
//
//  Created by admin on 2017/10/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

//cell backgroundView专用 圆角矩形背景
@interface RoundBackView : UIView

@property(nonatomic,assign)CGFloat paddingLeft;
@property(nonatomic,assign)CGFloat paddingRight;
@property(nonatomic,assign)CGFloat paddingTop;
@property(nonatomic,assign)CGFloat paddingBottom;
@property(nonatomic,assign)CGFloat cornerRadius;
@property(nonatomic,retain)UIColor* fillColor;

@end
