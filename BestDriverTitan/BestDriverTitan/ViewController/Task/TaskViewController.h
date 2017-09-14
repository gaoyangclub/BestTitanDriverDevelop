//
//  TaskViewController.h
//  BestDriverTitan
//
//  Created by admin on 16/12/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJTableViewController.h"
#import "PageListViewController.h"

@interface TaskViewController : PageListViewController

@property(nonatomic,assign)BOOL hasHistory;//是否包含历史任务

@end
