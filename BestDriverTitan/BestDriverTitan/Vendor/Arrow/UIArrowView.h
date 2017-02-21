//
//  UIArrowView.h
//  BestDriverTitan
//
//  Created by admin on 16/12/7.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ArrowDirect) {
    ArrowDirectLeft,
    ArrowDirectRight,
    ArrowDirectUp,
    ArrowDirectDown,
};

@interface UIArrowView : UIControl

@property(nonatomic,assign)ArrowDirect direction;
@property(nonatomic,assign)CGFloat lineThinkness;
@property(nonatomic,assign)BOOL isClosed;
@property(nonatomic,assign)BOOL isGuide;
@property(nonatomic,assign)CGFloat arrowHeightRate;
@property(nonatomic,retain)UIColor* lineColor;
@property(nonatomic,retain)UIColor* fillColor;

@end
