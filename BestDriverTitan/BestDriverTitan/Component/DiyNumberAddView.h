//
//  DiyNumberAddView.h
//  BestDriverTitan
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiyNumberAddView : UIView

@property(nonatomic,assign) CGFloat totalCount;
@property(nonatomic,assign) NSInteger minCount;
@property(nonatomic,assign) CGFloat cornerRadius;
@property(nonatomic,retain) UIColor* fillColor;
@property(nonatomic,retain) UIColor* strokeColor;
@property(nonatomic,assign) CGFloat strokeWidth;
@property(nonatomic,assign) NSInteger maxLength;

@end
