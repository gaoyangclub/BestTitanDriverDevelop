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
    self.tableView.sectionGap = 5;
    
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
    
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

//-(CGRect)getTableViewFrame {
//    CGFloat padding = 5;
//    return CGRectMake(self.view.frame.origin.x + padding, self.view.frame.origin.y, CGRectGetWidth(self.view.frame) - padding * 2, CGRectGetHeight(self.view.frame));
//}

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

-(NSMutableArray*)createShipmentList:(int)count startDate:(NSDate*)startDate dateGapPos:(NSInteger)dateGapPos{
    NSMutableArray* shipmentList = [NSMutableArray array];
    int dateGap = (arc4random() % 4);
    for (int i = 0; i < count; i++) {
        if (dateGapPos < dateGap) {
            dateGapPos ++;
        }else{
            dateGapPos = 0;
            dateGap = (arc4random() % 4);//重新计算
            startDate = [startDate dateByAddingTimeInterval:-24 * 3600];//-24小时
        }
        ShipmentBean* bean = [[ShipmentBean alloc]init];
        bean.isComplete = i == 0 ? NO : YES;//(arc4random() % 3) > 0;
        bean.pickupCount = (arc4random() % 15);
        bean.deliverCount = (arc4random() % 15);
        bean.factor1 = (arc4random() % 3);
        bean.factor2 = (arc4random() % 3);
        bean.factor3 = (arc4random() % 3);
        bean.dateTime = startDate;
        [shipmentList addObject:bean];
    }
    return shipmentList;
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    int64_t delay = 1.0 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        int count = (arc4random() % 10) + 5; //生成3-10范围的随机数
        
        NSMutableArray* shipmentList = [self createShipmentList:count startDate:[NSDate date] dateGapPos:0];
        
        [self.tableView clearSource];
        
        NSDate* startDate;
//        NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];//"yyyy-MM-dd HH:mm:ss"
//        dateFormatter stringFromDate:<#(nonnull NSDate *)#>
        NSMutableArray<CellVo*>* sourceData;
        SourceVo* svo;
        
        [self generateSourceDataByShipmentList:shipmentList svo:svo sourceData:sourceData startDate:startDate];
        
//        for (ShipmentBean* bean in shipmentList) {
//            NSDate* beanDate = bean.dateTime;
//            BOOL timeEqual = NO;
//            if(startDate){
//                NSString* prevTimeStr = [dateFormatter stringFromDate:startDate];
//                NSString* nowTimeStr = [dateFormatter stringFromDate:beanDate];
//                timeEqual = [prevTimeStr isEqualToString:nowTimeStr];
//            }
//            if (!startDate || !timeEqual) {
//                if (svo) {
//                    TaskViewSectionVo* hvo = [[TaskViewSectionVo alloc]init];
//                    hvo.isComplete = isSectionComplete;
//                    hvo.dateTime = startDate;
//                    svo.headerData = hvo;
//                }
//                //为null或者前后时间不一致
//                sourceData = [NSMutableArray<CellVo*> array];
//                svo = [SourceVo initWithParams:sourceData headerHeight:TASK_VIEW_SECTION_HEIGHT headerClass:[TaskViewSection class] headerData:NULL];
//                [self.tableView addSource:svo];
//            }
//            if (!bean.isComplete) {//只要一个未完成就是未完成
//                isSectionComplete = NO;
//            }
//            startDate = bean.dateTime;
//            [sourceData addObject:
//                          [CellVo initWithParams:TASK_VIEW_CELL_HEIGHT cellClass:[TaskViewCell class] cellData:bean]];
//            
//        }
//        for (NSUInteger i = 0; i < count; i++) {
//            //            [self.sourceData addObject:[NSString stringWithFormat:@"数据: %lu",i]];
//            
//            [sourceData addObject:
//             [CellVo initWithParams:TASK_VIEW_CELL_HEIGHT cellClass:[TaskViewCell class] cellData:[NSString stringWithFormat:@"数据: %lu",i]]];
//        }
//        [self.tableView addSource:[SourceVo initWithParams:sourceData headerHeight:TASK_VIEW_SECTION_HEIGHT headerClass:[TaskViewSection class] headerData:NULL]];
        handler(shipmentList.count > 0);
    });
}

-(void)footerLoadMore:(FooterLoadMoreHandler)handler{
    int64_t delay = 1.0 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        int count = (arc4random() % 5); //生成0-5范围的随机数
        if (count <= 0) {
            handler(NO);
            return;
        }
        
        SourceVo* svo = self.tableView.getLastSource;
        
        TaskViewSectionVo* hvo = (TaskViewSectionVo*)svo.headerData;
        NSDate* startDate = hvo.dateTime;
        NSMutableArray<CellVo*>* sourceData = svo.data;
        NSMutableArray* shipmentList = [self createShipmentList:count startDate:startDate dateGapPos:sourceData.count];
        
        [self generateSourceDataByShipmentList:shipmentList svo:svo sourceData:sourceData startDate:startDate];
        
//        NSMutableArray<CellVo*>* sourceData = svo.data;
//        NSUInteger startIndex = [svo getRealDataCount];
//        for (NSUInteger i = 0; i < count; i++) {
//            [sourceData addObject:
//             [CellVo initWithParams:TASK_VIEW_CELL_HEIGHT cellClass:[TaskViewCell class] cellData:[NSString stringWithFormat:@"数据: %lu",startIndex + i]]];
//        }
        handler(YES);
    });
}

-(void)generateSourceDataByShipmentList:(NSMutableArray*)shipmentList svo:(SourceVo*)svo  sourceData:(NSMutableArray<CellVo*>*)sourceData startDate:(NSDate*)startDate{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];//"yyyy-MM-dd HH:mm:ss"
    BOOL isSectionComplete = YES;
    for (ShipmentBean* bean in shipmentList) {
        NSDate* beanDate = bean.dateTime;
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
        if (!bean.isComplete) {//只要一个未完成就是未完成
            isSectionComplete = NO;
        }
        startDate = bean.dateTime;
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
    UIViewController* controller = nil;
    if (pushCount == 0) {
//        controller = [[ViewController alloc]init];
        controller = [[TaskTripController alloc]init];
        [[RootNavigationController sharedInstance] pushViewController:controller animated:YES];
    }else{
        
    }
    
}


@end
