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
#import "TaskViewSection.h"
#import "OwnerViewController.h"
#import "EmptyDataSource.h"
#import "TaskViewModel.h"
#import "ShipmentBean.h"

//@interface TestTableViewCell : MJTableViewCell
//
//@end
//@implementation TestTableViewCell
//
//-(void)showSubviews{
//    //    self.backgroundColor = [UIColor magentaColor];
//    
//    self.textLabel.text = (NSString*)self.data;
//}
//
//@end

@interface ShipmentPageBean:NSObject

@property(nonatomic,retain)NSMutableArray<ShipmentBean*>* shipmentBeans;
@property(nonatomic,assign)NSInteger totalCount;

@end
@implementation ShipmentPageBean

#pragma 声明数组、字典或者集合里的元素类型时要重写
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"shipmentBeans":[ShipmentBean class]};
}

@end

@interface TaskViewController(){
    NSInteger pushCount;
//    NSInteger pageNumber;//第几页
}

@property(nonatomic,retain)UIView* titleView;
@property(nonatomic,retain)TaskViewModel* viewModel;

@end


@implementation TaskViewController

//-(BOOL)getShowHeader{
//    return NO;
//}
//
//-(BOOL)getShowFooter{
//    return self.hasHistory;//历史任务需要
//}

-(void)viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
//    [self initTitleArea];
//    self.view.backgroundColor = COLOR_BACKGROUND;
    
//    UIControl* btn = [[UIControl alloc]init];
//    btn.frame = CGRectMake(0, 100, 100, 50);
//    //    btn.userInteractionEnabled = NO;
//    btn.backgroundColor = [UIColor brownColor];
//    btn.showTouchEffect = YES;
////    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
    
//    UIControl* btn = [[UIControl alloc]init];
//    btn.frame = CGRectMake(0, 100, 100, 50);
//    //    btn.userInteractionEnabled = NO;
//    btn.backgroundColor = [UIColor flatPowderBlueColor];
//    //            btn.opaque = YES;
//    //    btn.alpha = 0.95;
//    //        [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
//    [btn setShowTouch:YES];
//    [self.view addSubview:btn];

}

-(void)viewDidAppear:(BOOL)animated{
    if ([OwnerViewController sharedInstance].isLogin && [self.tableView getSourceCount] <= 0) {
        [self refreshAndEmptyDataSource];
    }
}

//-(CGRect)getTableViewFrame {
//    CGFloat padding = 5;
////    self.tableView.sectionGap = 5;
//    return CGRectMake(0, padding, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - padding);
//}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]init];
        
        [UICreationUtils createNavigationTitleLabel:20 color:[UIColor whiteColor] text:NAVIGATION_TITLE_TASK_HOME superView:_titleView];
    }
    return _titleView;
}

-(TaskViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[TaskViewModel alloc]init];
    }
    return _viewModel;
}

//-(void)initTitleArea{
//    self.tabBarController.navigationItem.leftBarButtonItem = [UICreationUtils createNavigationLeftButtonItem:[UIColor whiteColor] target:self action:@selector(rightItemClick)];
//    
//    self.tabBarController.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(rightItemClick)];
//    
//    self.tabBarController.navigationItem.titleView = self.titleView;
//}

//-(void)testScrollToRow{
//    NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:1];
//    [self.tableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}

-(void)rightItemClick{
    MMDrawerController* drawerController = (MMDrawerController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
    [drawerController toggleDrawerSide:(MMDrawerSideRight) animated:YES completion:nil];
}

-(NSMutableArray*)createShipmentList:(int)count startDate:(NSDate*)startDate dateGapPos:(NSInteger)dateGapPos{
    NSMutableArray* shipmentList = [NSMutableArray array];
    int dateGap = (arc4random() % 4);
    int change = 0;
    for (int i = 0; i < count; i++) {
        if (dateGapPos < dateGap) {
            dateGapPos ++;
        }else{
            change ++;
            if (!self.hasHistory && change > 2) {//非历史任务只显示3天
                break;
            }
            dateGapPos = 0;
            dateGap = (arc4random() % 4);//重新计算
            startDate = [startDate dateByAddingTimeInterval:-24 * 3600];//-24小时
        }
        ShipmentBean* bean = [[ShipmentBean alloc]init];
        if(self.hasHistory){
            bean.status = (arc4random() % 3) > 0 ? ACTIVITY_STATUS_PENDING_REPORT : ACTIVITY_STATUS_REPORTED;//;
        }else{
            bean.status = ACTIVITY_STATUS_PENDING_REPORT;
        }
//        bean.pickupCount = (arc4random() % 15);
//        bean.deliverCount = (arc4random() % 15);
//        bean.factor1 = (arc4random() % 3);
//        bean.factor2 = (arc4random() % 3);
//        bean.factor3 = (arc4random() % 3);
        bean.dateTime = startDate.timeIntervalSince1970;
        [shipmentList addObject:bean];
    }
    return shipmentList;
}

-(BOOL)autoRefreshHeader{
    return NO;//self.hasHistory;
}

-(void)refreshAndEmptyDataSource{
    [self.tableView headerBeginRefresh];
    
    self.emptyDataSource.noDataDescription = @"暂时没有任何任务!";
    self.emptyDataSource.buttonTitle = @"点我刷新";
    self.emptyDataSource.noDataIconName = ICON_EMPTY_NO_DATA;
    
    self.tableView.emptyDataSetSource = self.emptyDataSource;
    self.tableView.emptyDataSetDelegate = self.emptyDataSource;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                                 selector:@selector(eventLoginComplete)
//                                                     name:EVENT_LOGIN_COMPLETE
//                                                   object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventLogout)
                                                 name:EVENT_LOGOUT
                                               object:nil];
}

-(void)dealloc{
//    if (!self.hasHistory) {
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOGIN_COMPLETE object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOGOUT object:nil];
//    }
}

- (void)eventLogout{
    self.tableView.emptyDataSetSource = nil;
    self.tableView.emptyDataSetDelegate = nil;
    [self.tableView clearSource];
    [self.tableView reloadData];
//    [self.tableView headerBeginRefresh];
}

//-(void)eventLoginComplete{
//    
//}
-(void)headerRefresh:(HeaderRefreshHandler)handler pageNumber:(NSInteger)pageNumber{
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getRecentList:pageNumber isAll:self.hasHistory returnBlock:^(id returnValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf){//界面已经被销毁
            return;
        }
        [strongSelf.tableView clearSource];
        
        ShipmentPageBean* pageBean = [ShipmentPageBean yy_modelWithJSON:returnValue];
//        NSArray<ShipmentBean*>* shipmentList = [NSArray yy_modelArrayWithClass:[ShipmentBean class] json:returnValue];
        if(!pageBean.shipmentBeans || pageBean.shipmentBeans.count <= 0){
            if (!strongSelf.hasHistory) {//最新任务列表
                [strongSelf showTaskBadge:pageBean.totalCount];
            }
            handler(NO);
            return;
        }
//        ShipmentBean* bean = [ShipmentBean yy_modelWithJSON:returnValue];
        [strongSelf generateSourceDataByShipmentList:pageBean.shipmentBeans svo:nil sourceData:nil startDate:nil];
        if (!strongSelf.hasHistory) {//最新任务列表
            [strongSelf showTaskBadge:pageBean.totalCount];
        }
        handler(pageBean.shipmentBeans.count > 0);
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [weakSelf headerNetError:handler toast:errorMsg];
    }];
    
//    return;
//    
//    int64_t delay = 1.0 * NSEC_PER_SEC;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        if(!strongSelf){//界面已经被销毁
//            return;
//        }
//        if (![NetRequestClass netWorkReachability]) {//网络异常
//            strongSelf.emptyDataSource.netError = YES;
//            [strongSelf.tableView clearSource];
//            handler(NO);
//            return;
//        }
//        strongSelf.emptyDataSource.netError = NO;
//        
//        int count = (arc4random() % 5); //生成3-10范围的随机数
//        
//        NSDate* startDate = nil;
//        if (strongSelf.hasHistory) {
//            startDate = [NSDate dateWithTimeIntervalSinceNow:-3 * 24 * 3600];//3天前开始
//        }else{
//            startDate = [NSDate date];
//        }
//        
//        NSMutableArray* shipmentList = [self createShipmentList:count startDate:startDate dateGapPos:0];
//        
//        [strongSelf.tableView clearSource];
//        
//        
//        [strongSelf generateSourceDataByShipmentList:shipmentList svo:nil sourceData:nil startDate:nil];
//        handler(shipmentList.count > 0);
//    });
}

-(void)showTaskBadge:(NSInteger)count{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.rootTabBarController setItemBadge:count atIndex:0];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = count;
}

-(void)footerLoadMore:(FooterLoadMoreHandler)handler pageNumber:(NSInteger)pageNumber{
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getRecentList:pageNumber isAll:self.hasHistory returnBlock:^(id returnValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf){//界面已经被销毁
            return;
        }
        ShipmentPageBean* pageBean = [ShipmentPageBean yy_modelWithJSON:returnValue];
//        NSArray<ShipmentBean*>* shipmentList = [NSArray yy_modelArrayWithClass:[ShipmentBean class] json:returnValue];
        if (pageBean.shipmentBeans && pageBean.shipmentBeans.count > 0) {
            SourceVo* svo = strongSelf.tableView.getLastSource;
            
            TaskViewSectionVo* hvo = (TaskViewSectionVo*)svo.headerData;
            NSDate* startDate = hvo.dateTime;
            NSMutableArray<CellVo*>* sourceData = svo.data;
            
            [strongSelf generateSourceDataByShipmentList:pageBean.shipmentBeans svo:svo sourceData:sourceData startDate:startDate];
            
//            strongSelf->pageNumber ++;
            if (!strongSelf.hasHistory) {//最新任务列表
                [strongSelf showTaskBadge:strongSelf.tableView.getTotalCellCount];
            }
            
            handler(YES);
        }else{
            handler(NO);
        }
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [weakSelf footerNetError:handler toast:errorMsg];
    }];
    
//    return;
//        
//    int64_t delay = 1.0 * NSEC_PER_SEC;
//    
////    __weak __typeof(self) weakSelf = self;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        if(!strongSelf){//界面已经被销毁
//            return;
//        }
//        int count = (arc4random() % 5); //生成0-5范围的随机数
//        if (count <= 0) {
//            handler(NO);
//            return;
//        }
//        
//        SourceVo* svo = strongSelf.tableView.getLastSource;
//        
//        TaskViewSectionVo* hvo = (TaskViewSectionVo*)svo.headerData;
//        NSDate* startDate = hvo.dateTime;
//        NSMutableArray<CellVo*>* sourceData = svo.data;
//        NSMutableArray* shipmentList = [strongSelf createShipmentList:count startDate:startDate dateGapPos:sourceData.count];
//        
//        [strongSelf generateSourceDataByShipmentList:shipmentList svo:svo sourceData:sourceData startDate:startDate];
//        
////        NSMutableArray<CellVo*>* sourceData = svo.data;
////        NSUInteger startIndex = [svo getRealDataCount];
////        for (NSUInteger i = 0; i < count; i++) {
////            [sourceData addObject:
////             [CellVo initWithParams:TASK_VIEW_CELL_HEIGHT cellClass:[TaskViewCell class] cellData:[NSString stringWithFormat:@"数据: %lu",startIndex + i]]];
////        }
//        handler(YES);
//    });
}

-(void)generateSourceDataByShipmentList:(NSArray*)shipmentList svo:(SourceVo*)svo sourceData:(NSMutableArray<CellVo*>*)sourceData startDate:(NSDate*)startDate{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];//"yyyy-MM-dd HH:mm:ss"
    BOOL isSectionComplete = YES;
    for (ShipmentBean* bean in shipmentList) {
        NSDate* beanDate = bean.date;
        if (!startDate || ![[dateFormatter stringFromDate:startDate] isEqualToString:[dateFormatter stringFromDate:beanDate]]) {
            if (svo) {
                [self checkHeaderData:svo isComplete:isSectionComplete startDate:startDate toCount:sourceData.count];
            }
            //为null或者前后时间不一致
            sourceData = [NSMutableArray<CellVo*> array];
            svo = [SourceVo initWithParams:sourceData headerHeight:TASK_VIEW_SECTION_HEIGHT headerClass:[TaskViewSection class] headerData:NULL];
            [self.tableView addSource:svo];
            isSectionComplete = YES;//重新开始设置
        }
        if (![bean isComplete]) {//只要一个未完成就是未完成
            isSectionComplete = NO;
        }
        startDate = bean.date;
        [sourceData addObject:
         [CellVo initWithParams:TASK_VIEW_CELL_HEIGHT cellClass:[TaskViewCell class] cellData:bean]];
    }
    if (svo) {//还未定义section数据
        [self checkHeaderData:svo isComplete:isSectionComplete startDate:startDate toCount:sourceData.count];
    }
}

-(void)checkHeaderData:(SourceVo*)svo isComplete:(BOOL)isComplete startDate:(NSDate*)startDate toCount:(NSUInteger)toCount{
    TaskViewSectionVo* hvo;
    if (svo.headerData) {
        hvo = svo.headerData;
        if (hvo.isComplete && !isComplete) {//有未完成的 设置为未完成
            hvo.isComplete = NO;
        }
    }else{
        hvo = [[TaskViewSectionVo alloc]init];
        hvo.dateTime = startDate;
        hvo.isComplete = isComplete;
    }
    hvo.toCount = toCount;
    svo.headerData = hvo;
}

-(void)didSelectRow:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SourceVo* source = [self.tableView getSourceByIndex:indexPath.section];
    CellVo* cellVo = source.data[indexPath.row];
//    if (pushCount == 0) {
//        controller = [[ViewController alloc]init];
    TaskTripController* controller = [[TaskTripController alloc]init];
    ShipmentBean* shipmentBean = (ShipmentBean*)cellVo.cellData;
    controller.shipmentBean = shipmentBean;
    [[OwnerViewController sharedInstance] pushViewController:controller animated:YES];
//    }else{
//        
//    }
    __weak __typeof(self) weakSelf = self;
    controller.returnBlock = ^(id returnValue){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        shipmentBean.status = ACTIVITY_STATUS_REPORTED;//运单状态为完成
        if (!strongSelf.hasHistory) {
            [strongSelf.tableView beginUpdates];
            [source.data removeObjectAtIndex:indexPath.row];
            [strongSelf.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];//移除tableView中的数据
            if (source.data.count <= 0) {//数据被清了
                [strongSelf.tableView removeSourceAt:indexPath.section];//头也清了
                [strongSelf.tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section]withRowAnimation:UITableViewRowAnimationTop];
            }
            [strongSelf.tableView endUpdates];
        }else{
            [strongSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            //重新刷新即可
        }
    };
}

//-(NSIndexPath*)getShipmentIndexPath:(ShipmentBean*)shipmentBean{
//    SourceVo* svo = self.tableView.dataSourceArray;
//    for (NSInteger i = 0; i < svo.data.count; i++) {
//        CellVo* cvo = svo.data[i];
//        if (cvo.cellData == stopBean) {
//            return i;
//        }
//    }
//    return -1;
//}


@end
