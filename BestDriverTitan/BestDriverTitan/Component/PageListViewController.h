//
//  PageListViewController.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MJTableViewController.h"
#import "EmptyDataSource.h"

@interface PageListViewController : MJTableViewController

@property(nonatomic,retain)EmptyDataSource* emptyDataSource;

-(void)headerRefresh:(HeaderRefreshHandler)handler pageNumber:(NSInteger)pageNumber;
-(void)footerLoadMore:(FooterLoadMoreHandler)handler pageNumber:(NSInteger)pageNumber;

-(void)headerNetError:(HeaderRefreshHandler)handler toast:(NSString*)toast;
-(void)footerNetError:(FooterLoadMoreHandler)handler toast:(NSString*)toast;

@end
