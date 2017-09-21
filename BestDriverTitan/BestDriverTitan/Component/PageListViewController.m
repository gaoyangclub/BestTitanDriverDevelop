//
//  PageListViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PageListViewController.h"
#import "HudManager.h"

@interface PageListViewController (){
    NSInteger pageNumber;//第几页
}

@end

@implementation PageListViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//}

-(EmptyDataSource *)emptyDataSource{
    if (!_emptyDataSource) {
        _emptyDataSource = [[EmptyDataSource alloc]init];
        __weak __typeof(self) weakSelf = self;
        _emptyDataSource.didTapButtonBlock = ^(void){
            [weakSelf.tableView headerBeginRefresh];
        };
    }
    return _emptyDataSource;
}

-(void)headerNetError:(HeaderRefreshHandler)handler toast:(NSString*)toast{
    [HudManager showToast:toast];
    self.emptyDataSource.netError = YES;
    [self.tableView clearSource];
    handler(NO);
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    if (![NetRequestClass netWorkReachability]) {//网络异常
        [self headerNetError:handler toast:@"网络出现异常，请检查网络状况!"];
        return;
    }
    self.emptyDataSource.netError = NO;
    self->pageNumber = 1;
    [self headerRefresh:handler pageNumber:self->pageNumber];
}

-(void)headerRefresh:(HeaderRefreshHandler)handler pageNumber:(NSInteger)pageNumber{

}

-(void)footerLoadMore:(FooterLoadMoreHandler)handler{
    if (![NetRequestClass netWorkReachability]) {//网络异常
        [self footerNetError:handler toast:@"网络出现异常，请检查网络状况!"];
        return;
    }
    [self footerLoadMore:handler pageNumber:self->pageNumber];
}

-(void)footerLoadMore:(FooterLoadMoreHandler)handler pageNumber:(NSInteger)pageNumber{
    
}

-(void)footerNetError:(FooterLoadMoreHandler)handler toast:(NSString*)toast{
    [HudManager showToast:toast];
    handler(YES);
}

-(void)didRefreshComplete{
    self->pageNumber ++;
}

-(void)didLoadMoreComplete{
    self->pageNumber ++;
}

@end
