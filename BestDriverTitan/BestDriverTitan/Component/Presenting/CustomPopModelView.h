//
//  CustomPopModelController.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/12.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CustomPopDirection) {
    CustomPopDirectionTop = 1,
    CustomPopDirectionBottom,
    CustomPopDirectionCenter
};

@interface CustomPopModelView : UIControl

@property(nonatomic,assign)CustomPopDirection popFromDirection;
@property(nonatomic,assign)CustomPopDirection popToDirection;

@property(nonatomic,assign)BOOL cancelOnTouchOutside;
@property(nonatomic,assign)CGFloat topMargin;
@property(nonatomic,assign)CGFloat leftMargin;
@property(nonatomic,assign)CGFloat minHeight;
@property(nonatomic,assign)CGFloat minWidth;

@property(nonatomic,retain,readonly)UIControl* contentView;

-(void)show;
-(void)dismiss;

@end
