//
//  AdminViewController.h
//  BestDriverTitan
//
//  Created by admin on 2017/8/4.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AdminViewDelegate <NSObject>

@optional
-(void)adminLoginComplete:(User *)user;//登录(自己或监控模式开始)
@optional
-(void)adminWillReturnBack;//返回上一页 界面将要消失
@optional
-(void)adminDidReturnBack;//返回上一页
@end

@interface AdminViewController : UIViewController

@property (nonatomic, weak) id<AdminViewDelegate> delegate;

@end
