//
//  MessageViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MessageViewController.h"
#import "EmptyDataSource.h"

@interface MessageViewController ()

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)EmptyDataSource* emptyDataSource;

@end

@implementation MessageViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(void)initTitleArea{
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
//    self.titleLabel.text = @"消息提醒";//@"TO12451516161";//标题显示TO号
//    [self.titleLabel sizeToFit];
    
    self.tabBarController.navigationItem.titleView = self.titleLabel;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_MESSAGE superView:nil];
    }
    return _titleLabel;
}

-(EmptyDataSource *)emptyDataSource{
    if (!_emptyDataSource) {
        _emptyDataSource = [[EmptyDataSource alloc]init];
    }
    return _emptyDataSource;
}

-(void)initEmptyData{
    self.emptyDataSource.buttonTitle = nil;
    self.emptyDataSource.noDataIconName = ICON_EMPTY_NO_DATA;
    self.emptyDataSource.noDataDescription = @"暂时没有新消息";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initEmptyData];
    
    self.tableView.emptyDataSetSource = self.emptyDataSource;
    self.tableView.emptyDataSetDelegate = self.emptyDataSource;
    [self.tableView reloadData];
}

-(BOOL)getShowHeader{
    return NO;
}

-(BOOL)getShowFooter{
    return NO;
}

@end
