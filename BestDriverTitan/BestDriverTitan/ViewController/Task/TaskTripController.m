//
//  TaskTripController.m
//  BestDriverTitan
//
//  Created by admin on 16/12/8.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TaskTripController.h"
#import "TaskTripSection.h"
#import "TaskTripCell.h"
#import "OrderViewController.h"
#import "ShipmentStopBean.h"
#import "TaskActivityView.h"
#import "OwnerViewController.h"
#import "MapViewController.h"
#import "AmapLocationService.h"
#import "CircleNode.h"
#import "RoundRectNode.h"
#import "NetRequestClass.h"
#import "EmptyDataSource.h"

@interface TaskFilterButton:UIControl

@property(nonatomic,retain)CircleNode* circleNode;
@property(nonatomic,retain)ASTextNode* titleNode;
@property(nonatomic,retain)RoundRectNode* backNode;

@property(nonatomic,copy)NSString* title;
@property(nonatomic,retain)UIColor* circleColor;

-(void)setSelect:(BOOL)isSelect;

@end

@implementation TaskFilterButton

-(void)setTitle:(NSString *)title{
    _title = title;
    [self setNeedsLayout];
}

-(void)setCircleColor:(UIColor *)circleColor{
    _circleColor = circleColor;
    [self setNeedsLayout];
}

-(ASTextNode *)titleNode{
    if (!_titleNode) {
        _titleNode = [[ASTextNode alloc]init];
        _titleNode.layerBacked = YES;
        [self.layer addSublayer:_titleNode.layer];
    }
    return _titleNode;
}

-(RoundRectNode *)backNode{
    if (!_backNode) {
        _backNode = [[RoundRectNode alloc]init];
        _backNode.layerBacked = YES;
//        _backNode.fillColor = [UIColor whiteColor];
        _backNode.strokeColor = COLOR_LINE;
        _backNode.strokeWidth = 1;
        _backNode.cornerRadius = 5;
        [self.layer addSublayer:_backNode.layer];
    }
    return _backNode;
}

-(CircleNode *)circleNode{
    if (!_circleNode) {
        _circleNode = [[CircleNode alloc]init];
        _circleNode.layerBacked = YES;
        _circleNode.fillColor = COLOR_LINE;//FlatWhite
        _circleNode.strokeColor = [UIColor whiteColor];
        _circleNode.strokeWidth = 1;
        _circleNode.cornerRadius = 5;
        [self.layer addSublayer:_circleNode.layer];
    }
    return _circleNode;
}

-(void)layoutSubviews{
    CGFloat backLeftMargin = 0;
    CGFloat backTopMargin = 5;
    
    self.backNode.frame = CGRectMake(backLeftMargin, backTopMargin, self.width - backLeftMargin * 2, self.height - backTopMargin * 2);
    
    self.titleNode.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:self.title];
    self.titleNode.size = [self.titleNode measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.titleNode.centerY = self.centerY;
    
    if (self.circleColor) {
        CGFloat circleGap = 5;
        
        CGFloat circleWidth = self.circleNode.cornerRadius * 2;
        self.circleNode.fillColor = self.circleColor;
        self.circleNode.size = CGSizeMake(circleWidth, circleWidth);
        self.circleNode.centerY = self.centerY;
        CGFloat baseX = (self.width - (self.titleNode.width + circleWidth + circleGap)) / 2.;
        
        self.circleNode.x = baseX;
        
        self.titleNode.x = self.circleNode.maxX + circleGap;
    }else{
        self.titleNode.x = (self.width - self.titleNode.width) / 2;
    }
}

-(void)setSelect:(BOOL)isSelect{
    if (isSelect) {
        self.backNode.fillColor = COLOR_BACKGROUND;
    }else{
        self.backNode.fillColor = [UIColor whiteColor];
    }
}

@end


@interface TaskTripController()<TaskActivityViewDelegate>{
//    UILabel* titleLabel;
    NSMutableArray<ShipmentStopBean*>* stopBeanList;
    NSString* selectedTaskCode;
}
//@property(nonatomic,retain)UIView* titleView;

@property(nonatomic,retain)UIView* filterView;

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)UIButton* submitButton;

@property(nonatomic,retain)UIButton* attachmentButton;

@property(nonatomic,retain)UIControl* moreButton;

@property(nonatomic,retain)EmptyDataSource* emptyDataSource;

@end

static NSArray<NSString*>* taskCodeArr;
@implementation TaskTripController

-(NSArray<NSString*>*)getTaskCodeArr{
    if (!taskCodeArr) {
        taskCodeArr = @[@"全部",ACTIVITY_CODE_PICKUP_HANDOVER,ACTIVITY_CODE_SIGN_FOR_RECEIPT,ACTIVITY_CODE_COD];
    }
    return taskCodeArr;
}

-(BOOL)getShowFooter{
    return NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = [UIColor whiteColor];//COLOR_BACKGROUND;
}


//-(UIView *)titleView{
//    if (!_titleView) {
//        _titleView = [[UIView alloc]init];
//        
//        titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:[UIColor whiteColor] text:NAVIGATION_TITLE_TASK_TRIP superView:_titleView];
////        _titleView.backgroundColor = [UIColor flatGrayColor];
//    }
//    return _titleView;
//}

-(UIView*)filterView{
    if (!_filterView) {
        _filterView = [[UIView alloc]init];
        _filterView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_filterView];
    }
    return _filterView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_TASK_TRIP superView:nil];
    }
    return _titleLabel;
}

-(EmptyDataSource *)emptyDataSource{
    if (!_emptyDataSource) {
        _emptyDataSource = [[EmptyDataSource alloc]init];
    }
    return _emptyDataSource;
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    
//    [UICreationUtils createNavigationLeftButtonItem:[UIColor whiteColor] target:self action:@selector(leftClick)];
    
    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_DI_TU target:self action:@selector(rightClick)];
    
    self.titleLabel.text = @"TO12451516161";//标题显示TO号
    [self.titleLabel sizeToFit];
//    self.titleView.bounds = titleLabel.bounds;
    self.navigationItem.titleView = self.titleLabel;//self.titleView;
    
//    titleLabel.center = self.titleView.center;
    
}

//进入地图详情页
-(void)rightClick{
    MapViewController* mapController = [[MapViewController alloc]init];//[MapViewController sharedInstance];
//    mapController.locationPoints = [AmapLocationService getAllLocationInfos];
    [self.navigationController pushViewController:mapController animated:YES];
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    int64_t delay = 1.0 * NSEC_PER_SEC;
    
    __weak __typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (![NetRequestClass netWorkReachability]) {//网络异常
            strongSelf.emptyDataSource.netError = YES;
            [strongSelf.tableView clearSource];
            handler(NO);
            return;
        }
        strongSelf.emptyDataSource.netError = NO;
        [strongSelf tempGenerateStopList];
        NSMutableArray<ShipmentStopBean*>* sortStopList = [strongSelf sortStopListByCode:strongSelf->selectedTaskCode];
        handler(sortStopList.count > 0);
    });
//    handler(NO);
}

-(void)tempGenerateStopList{
    self->stopBeanList = [NSMutableArray<ShipmentStopBean*> array];
    int stopCount = (arc4random() % 10);
    for (NSUInteger i = 0; i < stopCount; i++) {
        
        /*--  创建活动列表 start  --*/
        NSMutableArray<NSString*>* codeArr = [NSMutableArray<NSString*> arrayWithObjects:ACTIVITY_CODE_PICKUP_HANDOVER,ACTIVITY_CODE_LOAD,ACTIVITY_CODE_UNLOAD,ACTIVITY_CODE_SIGN_FOR_RECEIPT,ACTIVITY_CODE_DELIVERY_RECEIPT,ACTIVITY_CODE_COD, nil];
        NSInteger removeCount = arc4random() % codeArr.count;
        for(NSInteger i = 0 ; i < removeCount ; i ++){
            NSInteger removeIndex = arc4random() % codeArr.count;
            [codeArr removeObjectAtIndex:removeIndex];
        }
        NSMutableArray<ShipmentActivityBean*>* activityBeans = [NSMutableArray<ShipmentActivityBean*> array];
        for (NSString* code in codeArr) {
            ShipmentActivityBean* bean = [[ShipmentActivityBean alloc]init];
            bean.activityDefinitionCode = code;
            bean.status = arc4random() % 2 > 0 ? ACTIVITY_STATUS_REPORTED : ACTIVITY_STATUS_PENDING_REPORT;
            [activityBeans addObject:bean];
        }
        /*--  创建活动列表 end  --*/
        
        ShipmentStopBean* bean = [[ShipmentStopBean alloc]init];
        bean.isComplete = (arc4random() % 3) > 0 ? NO : YES;//;
        bean.shortAddress = ConcatStrings(@"横港路李宁店",[NSNumber numberWithInteger:i + 1],@"号店");
        bean.stopName = ConcatStrings(@"上海上海市松江区上海上海市松江区",bean.shortAddress,@"18弄63号");
        
        bean.pickupCount = (arc4random() % 15);
        bean.deliverCount = (arc4random() % 15);
        bean.orderCount = (arc4random() % 10) + 1;
        bean.shipmentActivityList = activityBeans;
        [self->stopBeanList addObject:bean];
    }
}

-(CGRect)getTableViewFrame{
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.view.bounds);
    
//    CGFloat padding = 5;
    CGFloat tableHeight = viewHeight - TASK_TRIP_FILTER_HEIGHT;
    
    self.filterView.frame = CGRectMake(0, 0, viewWidth, TASK_TRIP_FILTER_HEIGHT);
    
    return CGRectMake(0, TASK_TRIP_FILTER_HEIGHT, viewWidth, tableHeight);
}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.clickCellMoveToCenter = YES;
    
    [self initEmptyData];
    
    self.tableView.emptyDataSetSource = self.emptyDataSource;
    self.tableView.emptyDataSetDelegate = self.emptyDataSource;
    
    __weak __typeof(self) weakSelf = self;
    self.emptyDataSource.didTapButtonBlock = ^(void){
        [weakSelf.tableView headerBeginRefresh];
    };
    
//    CGFloat count = 4;
//    CGFloat buttonWidth = self.view.width / titleArea.count;
    NSArray* codeArr = [self getTaskCodeArr];
    for (NSInteger i = 0 ; i < codeArr.count ; i ++) {
        TaskFilterButton* button = [[TaskFilterButton alloc]initWithFrame:CGRectMake(0, 0, 0, TASK_TRIP_FILTER_HEIGHT)];
        NSString* code = codeArr[i];
        NSString* activityLabel = [Config getActivityLabelByCode:code];
        button.title = activityLabel ? ConcatStrings(@"未",activityLabel) : code;
        button.tag = i;
        if (i == 0) {
            [button setSelect:YES];
            button.circleColor = nil;
        }else{
            [button setSelect:NO];
            button.circleColor = [Config getActivityColorByCode:code];
        }
        [button addTarget:self action:@selector(clickFilterButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.filterView addSubview:button];
    }
    [UICreationUtils autoEnsureViewsWidth:0 totolWidth:self.view.width views:self.filterView.subviews viewWidths:@[@"100%",@"100%",@"100%",@"100%"] padding:5];
    
//    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventOccurredActivity:)
                                                 name:EVENT_ACTIVITY_SELECT
                                               object:nil];
}

-(void)clickFilterButton:(TaskFilterButton*)sender{
    for (TaskFilterButton* button in self.filterView.subviews) {
        [button setSelect:button == sender];
    }
    //开始筛选
    self->selectedTaskCode = sender.tag ? [self getTaskCodeArr][sender.tag] : nil;
    [self initEmptyData];
    [self sortStopListByCode:self->selectedTaskCode];
    [self.tableView reloadMJData];
}

-(void)initEmptyData{
    self.emptyDataSource.buttonTitle = self->selectedTaskCode ? nil : @"点我刷新";
    self.emptyDataSource.noDataDescription = self->selectedTaskCode ? @"该类型任务已完成!" : @"任务已全部完成";
}

-(NSMutableArray<ShipmentStopBean*>*)sortStopListByCode:(NSString*)code{
    NSMutableArray<ShipmentStopBean*>* sortStopList = [NSMutableArray<ShipmentStopBean*> array];
    for (ShipmentStopBean* stop in self->stopBeanList) {
        if (!code) {//全部
            [sortStopList addObject:stop];
        }else{
            for (ShipmentActivityBean* activityBean in stop.shipmentActivityList) {
                if (![activityBean hasReport] && [activityBean.activityDefinitionCode isEqualToString:code]) {
                    [sortStopList addObject:stop];
                    break;
                }
            }
        }
    }
    [self.tableView clearSource];
    
    NSMutableArray<CellVo*>* sourceData = [NSMutableArray<CellVo*> array];
    //        int count = 1;//(arc4random() % 18) + 30; //生成3-10范围的随机数
    for (NSUInteger i = 0; i < sortStopList.count; i++) {
        //            [self.sourceData addObject:[NSString stringWithFormat:@"数据: %lu",i]];
        [sourceData addObject:
         [CellVo initWithParams:TASK_TRIP_CELL_HEIGHT cellClass:[TaskTripCell class] cellData:sortStopList[i]]];
    }
    [self.tableView addSource:[SourceVo initWithParams:sourceData headerHeight:0 headerClass:nil headerData:NULL]];//[TaskTripSection class]
    
    return sortStopList;
}

-(void)didRefreshComplete{
    if (!self->selectedTaskCode && [self.tableView getSourceCount] > 0) {//全部
        SourceVo* sourceVo = self.tableView.dataSourceArray[0];
        if(sourceVo.data.count){//有数据
            NSInteger selectIndex = (arc4random() % sourceVo.data.count);
            self.selectedIndexPath = [NSIndexPath indexPathForRow:selectIndex inSection:0];
            
            [self.tableView moveSelectedIndexPathToCenter];
        }
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_ACTIVITY_SELECT object:nil];
}

- (void)eventOccurredActivity:(NSNotification*)eventData{
    ShipmentStopBean* stopBean = eventData.object;
    [self jumpOrderViewController:stopBean.shipmentActivityList];
}

//- (void)eventOccurred:(NSNotification*)eventData{
//    
//    ShipmentStopBean* bean = eventData.object;
//    
//    [self showStopActivity:bean];
//}

-(void)showStopActivity:(ShipmentStopBean*)bean{
    NSInteger activityCount = arc4random() % 3 + 1;
    BOOL showAttach = arc4random() % 2;
    if (showAttach) {
        activityCount -= 1;
    }
    self.attachmentButton.hidden = !showAttach;
    self.moreButton.hidden = !(activityCount >= 2);
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.view.bounds);
    CGFloat padding = 5;
    CGFloat tableHeight = viewHeight - SUBMIT_BUTTON_HEIGHT - padding * 2;
    CGFloat mWidth = MORE_BUTTON_RADIUS * 2;
    
    //    [self.submitButton setTitle:ConcatStrings(ICON_QIAN_SHOU,@"  ",@"签收",[NSNumber numberWithInteger:activityCount]) forState:UIControlStateNormal];
    
    if (!self.moreButton.hidden) {
        self.moreButton.frame = CGRectMake(0, tableHeight + padding + (SUBMIT_BUTTON_HEIGHT - mWidth) / 2., mWidth, mWidth);
    }
    if (!self.attachmentButton.hidden) {
        self.attachmentButton.frame = CGRectMake(0, tableHeight + padding, 0, SUBMIT_BUTTON_HEIGHT);
    }
    //    if (!self.submitButton.hidden) {
    self.submitButton.frame = CGRectMake(0, tableHeight + padding, 0, SUBMIT_BUTTON_HEIGHT);
    //    }
    [UICreationUtils autoEnsureViewsWidth:0 totolWidth:viewWidth views:@[self.moreButton,self.attachmentButton,self.submitButton] viewWidths:@[[NSNumber numberWithFloat:mWidth],@"40%",@"60%"] padding:padding];
}

-(UIButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_submitButton setShowTouch:YES];
        
        _submitButton.backgroundColor = COLOR_PRIMARY;
        [_submitButton setTitle:ConcatStrings(ICON_QIAN_SHOU,@"  ",@"签收") forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _submitButton.titleLabel.font = [UIFont fontWithName:ICON_FONT_NAME size:16];
//        _submitButton.titleLabel.attributedText = 
        
        _submitButton.underlineNone = YES;
        
        [self.view addSubview:_submitButton];
        
        [_submitButton setShowTouch:YES];
        
        
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(void)clickSubmitButton:(UIButton*)sender{
    [self jumpOrderViewController:nil];
}

-(void)jumpOrderViewController:(NSArray<ShipmentActivityBean*>*)activityBeans{
    OrderViewController* controller = [[OrderViewController alloc]init];
    controller.activityBeans = activityBeans;
    [[OwnerViewController sharedInstance] pushViewController:controller animated:YES];
}

-(UIButton *)attachmentButton{
    if (!_attachmentButton) {
        _attachmentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [_submitButton setShowTouch:YES];
        
        _attachmentButton.backgroundColor = [UIColor whiteColor];
        [_attachmentButton setTitle:ConcatStrings(ICON_HUI_DAN,@"  ",@"回单") forState:UIControlStateNormal];
        [_attachmentButton setTitleColor:COLOR_PRIMARY forState:UIControlStateNormal];
        
        _attachmentButton.underlineNone = YES;
        
        _attachmentButton.layer.borderColor = COLOR_PRIMARY.CGColor;
        _attachmentButton.layer.borderWidth = 1;
        
        _attachmentButton.titleLabel.font = [UIFont fontWithName:ICON_FONT_NAME size:16];
        
        [self.view addSubview:_attachmentButton];
        
        [_attachmentButton setShowTouch:YES];
    }
    return _attachmentButton;
}

-(UIControl *)moreButton{
    if (!_moreButton) {
        _moreButton = [[UIControl alloc]init];
        [_moreButton setShowTouch:YES];
        
        [_moreButton.layer addSublayer:[UICreationUtils createRangeLayer:MORE_BUTTON_RADIUS textColor:[UIColor whiteColor]
                                                                        backgroundColor:COLOR_PRIMARY]];
        [self.view addSubview:_moreButton];
        
        [_moreButton addTarget:self action:@selector(clickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

-(void)clickMoreButton:(UIView*)sender{
    [PopAnimateManager startClickAnimation:sender];
    
    NSMutableArray<NSString*>* codeArr = [NSMutableArray<NSString*> arrayWithObjects:ACTIVITY_CODE_PICKUP_HANDOVER,ACTIVITY_CODE_LOAD,ACTIVITY_CODE_UNLOAD,ACTIVITY_CODE_SIGN_FOR_RECEIPT,ACTIVITY_CODE_DELIVERY_RECEIPT,ACTIVITY_CODE_COD, nil];
//  @[ACTIVITY_CODE_PICKUP_HANDOVER,ACTIVITY_CODE_LOAD,ACTIVITY_CODE_UNLOAD,ACTIVITY_CODE_SIGN_FOR_RECEIPT,ACTIVITY_CODE_DELIVERY_RECEIPT,ACTIVITY_CODE_COD
//                                    ];
    NSInteger removeCount = arc4random() % codeArr.count;
    for(NSInteger i = 0 ; i < removeCount ; i ++){
        NSInteger removeIndex = arc4random() % codeArr.count;
        [codeArr removeObjectAtIndex:removeIndex];
    }
    
    NSMutableArray<ShipmentActivityBean*>* activityBeans = [NSMutableArray<ShipmentActivityBean*> array];
    for (NSString* code in codeArr) {
        ShipmentActivityBean* bean = [[ShipmentActivityBean alloc]init];
        bean.activityDefinitionCode = code;
        [activityBeans addObject:bean];
    }

    TaskActivityView* activityView = [[TaskActivityView alloc]init];
    activityView.activityBeans = activityBeans;
    activityView.taskActivityDelegate = self;
    [activityView show];
    
//    activityController.transitioningDelegate = activityController;
//    activityController.modalPresentationStyle = UIModalPresentationCustom;
    
//    [self presentViewController:activityController animated:YES completion:nil];
}

-(void)activitySelected:(ShipmentActivityBean *)activityBean{
    [self jumpOrderViewController:@[activityBean]];
}

-(void)didSelectRow:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MJTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
//    [self showStopActivity:cell.data];
//    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_ADDRESS_SELECT object:cell.data];
    
//    DDLog(@"didSelectRow:%@%@",@"收到选中行消息...",indexPath);
}

@end
