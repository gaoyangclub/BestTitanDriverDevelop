//
//  ScanCargoInfoController.h
//  BestDriverTitan
//  货量扫描填写上报
//  Created by admin on 2017/11/6.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScanViewModel.h"

@class ScanOrderEditController;

@protocol ScanOrderEditDelegate <NSObject>
@optional
-(void)orderEdited:(ScanOrderEditController*)controller;//确认编辑
@optional
-(void)orderCanceled:(ScanOrderEditController*)controller;//取消编辑
@end

@interface ScanOrderEditController : UIViewController

@property(nonatomic,retain) ScanCodePickUpBean* scanCodeBean;
@property(nonatomic, weak) id<ScanOrderEditDelegate> delegate;

@end
