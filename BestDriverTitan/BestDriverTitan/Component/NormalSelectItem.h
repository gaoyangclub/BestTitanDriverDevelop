//
//  NormalSelectItem.h
//  BestDriverTitan
//
//  Created by 高扬 on 17/7/23.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NormalSelectItem : UIControl

@property(nonatomic,assign)BOOL showTopLine;
@property(nonatomic,assign)BOOL showBottomLine;
@property(nonatomic,retain)UIColor* strokeColor;
@property(nonatomic,assign)CGFloat strokeWidth;

@property(nonatomic,assign)BOOL showRightArrow;
@property(nonatomic,assign)CGSize arrowSize;
@property(nonatomic,assign)CGFloat arrowStrokeWidth;

@property(nonatomic,assign)CGFloat lineTopLeftMargin;
@property(nonatomic,assign)CGFloat lineTopRightMargin;
@property(nonatomic,assign)CGFloat lineBottomLeftMargin;
@property(nonatomic,assign)CGFloat lineBottomRightMargin;

@property(nonatomic,assign)CGFloat iconMargin;

@property(nonatomic,copy)NSString* iconName;
@property(nonatomic,assign)CGFloat iconSize;
@property(nonatomic,retain)UIColor* iconColor;
@property(nonatomic,retain)UIColor* iconBackColor;
@property(nonatomic,assign)CGFloat iconCornerRadius;
@property(nonatomic,assign)BOOL showIconLine;

@property(nonatomic,assign)BOOL showLabel;
@property(nonatomic,copy)NSString* labelName;
@property(nonatomic,assign)CGFloat labelSize;
@property(nonatomic,retain)UIColor* labelColor;

@end
