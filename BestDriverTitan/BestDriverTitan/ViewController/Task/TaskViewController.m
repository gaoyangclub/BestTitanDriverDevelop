//
//  TaskViewController.m
//  BestDriverTitan
//
//  Created by admin on 16/12/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TaskViewController.h"
#import "MMDrawerController.h"
#import "AppDelegate.h"
#import "RootNavigationController.h"
#import "TaskTripController.h"
#import "ViewController.h"
#import "TaskViewCell.h"

@interface TestTableViewCell : MJTableViewCell

@end
@implementation TestTableViewCell

-(void)showSubviews{
    //    self.backgroundColor = [UIColor magentaColor];
    
    self.textLabel.text = (NSString*)self.data;
}

@end

@interface TaskHomeController(){
    NSInteger pushCount;
}

@property(nonatomic,retain)UIView* titleView;

@end

@implementation TaskHomeController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(CGRect)getTableViewFrame {
    CGFloat padding = 5;
    return CGRectMake(self.view.frame.origin.x + padding, self.view.frame.origin.y, CGRectGetWidth(self.view.frame) - padding * 2, CGRectGetHeight(self.view.frame));
}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]init];
        
        [UICreationUtils createNavigationTitleLabel:20 color:[UIColor whiteColor] text:NAVIGATION_TITLE_TASK_HOME superView:_titleView];
    }
    return _titleView;
}

-(void)initTitleArea{
    self.tabBarController.navigationItem.leftBarButtonItem = [UICreationUtils createNavigationLeftButtonItem:[UIColor whiteColor] target:self action:@selector(rightItemClick)];
    
    self.tabBarController.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(rightItemClick)];
    
    self.tabBarController.navigationItem.titleView = self.titleView;
}

-(void)rightItemClick{
    MMDrawerController* drawerController = (MMDrawerController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
    [drawerController toggleDrawerSide:(MMDrawerSideRight) animated:YES completion:nil];
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    int64_t delay = 1.0 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        [self.tableView clearSource];
        
        NSMutableArray<CellVo*>* sourceData = [NSMutableArray<CellVo*> array];
        int count = (arc4random() % 18) + 30; //生成3-10范围的随机数
        for (NSUInteger i = 0; i < count; i++) {
            //            [self.sourceData addObject:[NSString stringWithFormat:@"数据: %lu",i]];
            
            [sourceData addObject:
             [CellVo initWithParams:70 cellClass:[TaskViewCell class] cellData:[NSString stringWithFormat:@"数据: %lu",i]]];
        }
        [self.tableView addSource:[SourceVo initWithParams:sourceData headerHeight:0 headerClass:NULL headerData:NULL]];
        
        handler(sourceData.count > 0);
    });
}

-(void)footerLoadMore:(FooterLoadMoreHandler)handler{
    int64_t delay = 1.0 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        int count = (arc4random() % 3); //生成0-2范围的随机数
        if (count <= 0) {
            handler(NO);
            return;
        }
        SourceVo* svo = self.tableView.getLastSource;
        NSMutableArray<CellVo*>* sourceData = svo.data;
        NSUInteger startIndex = [svo getRealDataCount];
        for (NSUInteger i = 0; i < count; i++) {
            [sourceData addObject:
             [CellVo initWithParams:70 cellClass:[TaskViewCell class] cellData:[NSString stringWithFormat:@"数据: %lu",startIndex + i]]];
        }
        handler(YES);
    });
}

-(void)didSelectRow:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController* controller = nil;
    if (pushCount == 0) {
//        controller = [[ViewController alloc]init];
        controller = [[TaskTripController alloc]init];
        [[RootNavigationController sharedInstance] pushViewController:controller animated:YES];
    }else{
        
    }
    
}


@end
