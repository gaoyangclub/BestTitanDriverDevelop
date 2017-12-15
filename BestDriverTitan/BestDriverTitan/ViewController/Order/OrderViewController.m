//
//  OrderViewController.m
//  BestDriverTitan
//
//  Created by 高扬 on 17/3/26.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderViewSection.h"
#import "OrderTabView.h"
#import "OrderNormalCell.h"
#import "ShipmentActivityBean.h"
#import "FlatButton.h"
#import "HudManager.h"
#import "OrderPhotoCell.h"
#import "ShipmentTaskBean.h"
#import "OrderReceiptCell.h"
#import "OrderEditModelView.h"
#import "OrderViewModel.h"
#import "PhotoSelectionView.h"
#import "OwnerViewController.h"

#define VIEW_MARGIN rpx(4)
#define BUTTON_AREA_HEIGHT rpx(55)

@interface TestTableViewCell3 : MJTableViewCell

@end
@implementation TestTableViewCell3

-(void)showSubviews{
    //    self.backgroundColor = [UIColor magentaColor];
    
    self.textLabel.text = (NSString*)self.data;
}

@end

@interface OrderViewController()<OrderTabViewDelegate>{//,OrderEditModelDelegate
    BOOL isClickTab;
    ShipmentActivityBean* currentActivity;//当前选中的活动
    NSArray<ShipmentTaskBean*>* taskBeanList;//当前活动获取到的任务详情列表
}

@property(nonatomic,retain)OrderTabView* tabView;
@property(nonatomic,retain)UILabel* titleLabel;

@property (nonatomic,retain)ASDisplayNode* addressBottomY;
//地址信息栏区域
@property(nonatomic,retain)ASDisplayNode* addressView;
//@property(nonatomic,retain)ASDisplayNode* addressLine;
@property(nonatomic,retain)ASTextNode* iconAddress;//起点图标
@property(nonatomic,retain)ASTextNode* textAddress;//起点图标

@property(nonatomic,retain)FlatButton* submitButton;

@property(nonatomic,retain)OrderViewModel* viewModel;

@property(nonatomic,retain)PhotoSelectionView* photoView;

@property(nonatomic,retain)UIView* photoContainer;

@end

@implementation OrderViewController

-(ASDisplayNode *)addressView{
    if (!_addressView) {
        _addressView = [[ASDisplayNode alloc]init];
        _addressView.layerBacked = YES;
        _addressView.backgroundColor = [UIColor whiteColor];
        [self.view.layer addSublayer:_addressView.layer];
    }
    return _addressView;
}

//-(ASDisplayNode *)addressLine{
//    if (!_addressLine) {
//        _addressLine = [[ASDisplayNode alloc]init];
//        _addressLine.layerBacked = YES;
//        _addressLine.backgroundColor = COLOR_LINE;
//        [self.addressView addSubnode:_addressLine];
//    }
//    return _addressLine;
//}

-(ASTextNode *)iconAddress{
    if (!_iconAddress) {
        _iconAddress = [[ASTextNode alloc]init];
        _iconAddress.layerBacked = YES;
        [self.addressView addSubnode:_iconAddress];
    }
    return _iconAddress;
}

-(ASTextNode *)textAddress{
    if (!_textAddress) {
        _textAddress = [[ASTextNode alloc]init];
        _textAddress.maximumNumberOfLines = 2;
        _textAddress.truncationMode = NSLineBreakByTruncatingTail;
        _textAddress.layerBacked = YES;
        [self.addressView addSubnode:_textAddress];
    }
    return _textAddress;
}

-(ASDisplayNode *)addressBottomY{
    if(!_addressBottomY){
        _addressBottomY = [[ASDisplayNode alloc]init];
        _addressBottomY.backgroundColor = COLOR_LINE;
        _addressBottomY.layerBacked = YES;
        [self.addressView addSubnode:_addressBottomY];
    }
    return _addressBottomY;
}

-(FlatButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[FlatButton alloc]init];
        _submitButton.titleFontName = ICON_FONT_NAME;
        _submitButton.fillColor = COLOR_PRIMARY;
        _submitButton.titleSize = 18;
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

-(PhotoSelectionView *)photoView{
    if (!_photoView) {
        _photoView = [[PhotoSelectionView alloc]init];
        [self.photoContainer addSubview:_photoView];
        _photoView.maxSelectCount = 50;//最多选50个
        _photoView.parentController = [OwnerViewController sharedInstance];
    }
    return _photoView;
}

-(UIView *)photoContainer{
    if (!_photoContainer) {
        _photoContainer = [[UIView alloc]init];
        _photoContainer.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_photoContainer];
    }
    return _photoContainer;
}

-(OrderViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[OrderViewModel alloc]init];
    }
    return _viewModel;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_ORDER_VIEW superView:nil];
    }
    return _titleLabel;
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:SIZE_LEFT_BACK_ICON] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
//    [UICreationUtils createNavigationLeftButtonItem:[UIColor whiteColor] target:self action:@selector(leftClick)];
    
    //    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(rightItemClick)];
    self.titleLabel.text = NAVIGATION_TITLE_ORDER_VIEW;//self.shipmentBean.code;//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
}

//返回上层
-(void)leftClick{
    if ([self checkCanLeaveTask]) {//可以返回上一页
        [self popToPrevController];
    }else{
        [self showEditedActivityAlert:-1];
    }
}

//跳转到上一层
-(void)popToPrevController{
    [self.navigationController popViewControllerAnimated:YES];
    if (self.stopBean.isComplete) {//已经全部完成
        if (self.returnBlock) {
            self.returnBlock([NSNumber numberWithBool:YES]);
        }
    }
}

-(OrderTabView *)tabView{
    if (!_tabView) {
        _tabView = [[OrderTabView alloc]init];
        [self.view addSubview:_tabView];
    }
    return _tabView;
}

-(CGRect)getTableViewFrame{
    CGFloat margin = VIEW_MARGIN;
    CGFloat squareHeight = TASK_TRIP_SECTION_TOP_HEIGHT;
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.view.bounds);
    
    self.addressView.frame = CGRectMake(0, 0, viewWidth, squareHeight);
    self.tabView.frame = CGRectMake(0, squareHeight, viewWidth, ORDER_TAB_HEIGHT);
    
    self.submitButton.frame = CGRectMake(margin, viewHeight - BUTTON_AREA_HEIGHT + margin, viewWidth - margin * 2, BUTTON_AREA_HEIGHT - margin * 2);
    
    CGFloat tableHeight = self.view.height - BUTTON_AREA_HEIGHT - ORDER_TAB_HEIGHT - TASK_TRIP_SECTION_TOP_HEIGHT - margin;
    if (_photoContainer && !_photoContainer.hidden) {
        tableHeight -= ORDER_PHOTO_CELL_HEIGHT + margin;
    }
    return CGRectMake(margin, squareHeight + margin + ORDER_TAB_HEIGHT, viewWidth - margin * 2, tableHeight);
}

-(void)showPhotoView:(ShipmentTaskBean*)bean{
//    CGFloat margin = VIEW_MARGIN;
    
    self.photoContainer.hidden = NO;
    
    self.photoContainer.frame = CGRectMake(0, self.view.height - BUTTON_AREA_HEIGHT - ORDER_PHOTO_CELL_HEIGHT, self.view.width, ORDER_PHOTO_CELL_HEIGHT);
    
    CGFloat padding = rpx(5);
    CGFloat itemHeight = self.photoContainer.height - padding * 2;
    
    self.photoView.frame = CGRectMake(padding, padding, self.photoContainer.width - padding * 2, itemHeight);
    self.photoView.itemSize = CGSizeMake(itemHeight, itemHeight);
    self.photoView.assetsArray = bean.assetsArray;
    
//    self.tableView.height = self.view.height - BUTTON_AREA_HEIGHT - ORDER_TAB_HEIGHT - ORDER_PHOTO_CELL_HEIGHT - TASK_TRIP_SECTION_TOP_HEIGHT;
    [self.view setNeedsLayout];//重新布局高度位置
}

-(void)hidePhotoView{
    if (_photoContainer) {//说明初始化打开过了
        self.photoContainer.hidden = YES;
        [self.view setNeedsLayout];//重新布局高度位置
    }
}

//按顺序遍历获取没上报的项索引
-(NSInteger)getPendingReportActivityIndex:(NSArray<ShipmentActivityBean*>*)activityBeans isNext:(BOOL)isNext{
    if (!isNext) {
        NSInteger firstSelectIndex = -1;
        for (NSInteger i = 0; i < activityBeans.count; i++) {
            ShipmentActivityBean* activityBean = activityBeans[i];
            if (![activityBean hasReport]) {
                if (self.selectedTaskCode) {
                    if ([activityBean.activityDefinitionCode isEqualToString:self.selectedTaskCode]) {
                        return i;
                    }else{
                        firstSelectIndex = i;
                    }
                }else{//没有优先选中的类型 直接选中
                    return i;//未上报的先选中
                }
            }
        }
        if (firstSelectIndex >= 0) {//全部都找完了也没有优先选中的活动 但是有第一个找到的未选中项 就它了
            return firstSelectIndex;
        }
    }else{
        NSInteger midIndex = self.tabView.selectedIndex;
        for (NSInteger i = midIndex + 1; i < activityBeans.count; i++) {
            ShipmentActivityBean* activityBean = activityBeans[i];
            if (![activityBean hasReport]) {
                return i;//未上报的先选中
            }
        }
        for (NSInteger i = 0; i < midIndex + 1; i++) {
            ShipmentActivityBean* activityBean = activityBeans[i];
            if (![activityBean hasReport]) {
                return i;//未上报的先选中
            }
        }
        return -1;//全部都完成了
    }
    return 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.sectionGap = rpx(5);
    self.tabView.tabDelegate = self;
    
    [self.tabView setActivityBeans:self.activityBeans];

    [self.tabView setSelectedIndex:[self getPendingReportActivityIndex:self.activityBeans isNext:NO]];
    
    CGFloat sectionWidth = self.view.bounds.size.width;
    CGFloat leftpadding = rpx(10);
    CGFloat squareHeight = TASK_TRIP_SECTION_TOP_HEIGHT;
    self.iconAddress.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_PRIMARY size:rpx(24) content:ICON_DIAN_PU];
    CGSize iconStartSize = [self.iconAddress measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconAddress.frame = (CGRect){ CGPointMake(leftpadding,(squareHeight - iconStartSize.height) / 2.),iconStartSize};
    
//    self.addressLine.frame = CGRectMake(0, squareHeight - LINE_WIDTH * 4, sectionWidth, LINE_WIDTH * 4);
    
    NSString* address = self.stopBean.stopName;
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:COLOR_TEXT_PRIMARY size:SIZE_TEXT_PRIMARY content:address];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, address.length)];
    self.textAddress.attributedString = textString;
    
    CGFloat maxStartWidth = sectionWidth - leftpadding * 2 - iconStartSize.width;
    CGSize textStartSize = [self.textAddress measure:CGSizeMake(maxStartWidth, FLT_MAX)];
    self.textAddress.frame = (CGRect){ CGPointMake(leftpadding + iconStartSize.width + leftpadding / 2.,(squareHeight - textStartSize.height) / 2.),textStartSize};
    
    self.addressBottomY.frame = CGRectMake(0, squareHeight - LINE_WIDTH, sectionWidth, LINE_WIDTH);
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(eventOccurred:)
//                                                 name:EVENT_ORDER_PAGE_CHANGE
//                                               object:nil];
}

//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_ORDER_PAGE_CHANGE object:nil];
//}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view endEditing:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)getShowHeader{
    return NO;
}

-(BOOL)getShowFooter{
    return NO;
}

-(void)loadOrderData{
    [self hidePhotoView];
    
    if ([self->currentActivity.activityDefinitionCode isEqualToString:ACTIVITY_CODE_COD]) {
        [HudManager showToast:
         ConcatStrings([Config getActivityLabelByCode:self->currentActivity.activityDefinitionCode],@"暂时无法上报!")
         ];
        self.submitButton.hidden = YES;
        [self.tableView clearSource];
//        handler(NO);
        [self.tableView reloadMJData];
        return;
    }else{
        self.submitButton.hidden = NO;
    }
    
    long shipmentActivityId = self->currentActivity.id;
    
    [SVProgressHUD showWithStatus:@"数据获取中" maskType:SVProgressHUDMaskTypeBlack];
    
    [self.tableView clearSource];//先清除掉
    [self.tableView reloadMJData];
    
    __weak __typeof(self) weakSelf = self;
    [self.viewModel getTaskActivity:shipmentActivityId returnBlock:^(id returnValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf){//界面已经被销毁
            return;
        }
        if (shipmentActivityId != strongSelf->currentActivity.id) {
//            NSLog(@"界面已经被切换掉了");
            [HudManager showToast:@"界面已经被切换掉了"];
//            handler(NO);
            [SVProgressHUD dismiss];
            return;
        }
        
        strongSelf->taskBeanList = [NSArray yy_modelArrayWithClass:[ShipmentTaskBean class] json:returnValue];
        NSInteger count = strongSelf->taskBeanList.count;
        if (count <= 0) {
//            handler(NO);
            [SVProgressHUD dismiss];
            return;
        }
        [strongSelf checkShowPhotoArea];
        
//                for (NSInteger i = 0; i < 30; i++) {//临时测试代码
//                    [strongSelf->taskBeanList.firstObject.shipUnits addObject:[taskBeanList.firstObject.shipUnits.firstObject copy]];
//                }
        
        for (NSInteger i = 0; i < count; i++) {
            NSMutableArray* sourceData = [NSMutableArray<CellVo*> array];
            ShipmentTaskBean* bean = strongSelf->taskBeanList[i];
            if ([strongSelf->currentActivity.activityDefinitionCode isEqualToString:ACTIVITY_CODE_DELIVERY_RECEIPT]) {
                [sourceData addObject:[CellVo initWithParams:ORDER_RECEIPT_CELL_HEIGHT cellClass:[OrderReceiptCell class] cellData:bean]];
            }else{
                if(count == 1){//只有一个订单可以直接显示
                    for (ShipmentActivityShipUnitBean* shipUnitBean in bean.shipUnits) {
                        [sourceData addObject:[CellVo initWithParams:ORDER_VIEW_CELL_HEIGHT cellClass:[OrderNormalCell class] cellData:shipUnitBean]];
                    }
                }else{
                    [sourceData addObject:[CellVo initWithParams:ORDER_PHOTO_CELL_HEIGHT cellClass:[OrderPhotoCell class] cellData:bean]];
                }
            }
            SourceVo* svo = [SourceVo initWithParams:sourceData headerHeight:ORDER_VIEW_SECTION_HEIGHT headerClass:[OrderViewSection class] headerData:bean];
            [strongSelf.tableView addSource:svo];
        }
        
//        handler(count > 0);
        [self.tableView reloadMJData];
        [SVProgressHUD dismiss];
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        //        NSLog(@"%@",errorMsg);
        [HudManager showToast:errorMsg];
        [SVProgressHUD dismiss];
    }];
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    
//    if (![NetRequestClass netWorkReachability]) {//网络异常
//        self.emptyDataSource.netError = YES;
//        [self.tableView clearSource];
//        handler(NO);
//        return;
//    }
    
//    int64_t delay = 1.0 * NSEC_PER_SEC;
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        if(!strongSelf){//界面已经被销毁
//            return;
//        }
//        int count = (arc4random() % 6) + 1; //生成3-10范围的随机数
//    
//        [strongSelf.tableView clearSource];
//        
//        for (NSInteger i = 0; i < count; i++) {
//            NSMutableArray* sourceData = [NSMutableArray<CellVo*> array];
//            ShipmentTaskBean* bean = [[ShipmentTaskBean alloc]init];
//            int count2 = (arc4random() % 15) + 1; //生成1-3范围的随机数
//            
//            if ([strongSelf->currentActivity.activityDefinitionCode isEqualToString:ACTIVITY_CODE_DELIVERY_RECEIPT]) {
//                [sourceData addObject:[CellVo initWithParams:ORDER_RECEIPT_CELL_HEIGHT cellClass:[OrderReceiptCell class] cellData:bean]];
//            }else{
//                for (NSInteger j = 0; j < count2; j++) {
//                    [sourceData addObject:[CellVo initWithParams:ORDER_VIEW_CELL_HEIGHT cellClass:[OrderNormalCell class] cellData:
//                                           @""]];
//                }
//                [sourceData addObject:[CellVo initWithParams:ORDER_PHOTO_CELL_HEIGHT cellClass:[OrderPhotoCell class] cellData:bean]];
//            }
//            
//            SourceVo* svo = [SourceVo initWithParams:sourceData headerHeight:ORDER_VIEW_SECTION_HEIGHT headerClass:[OrderViewSection class] headerData:bean];
//            [strongSelf.tableView addSource:svo];
//        }
////        [self.tabView setTotalCount:count];
//        
//        handler(count > 0);
//    });
}

-(void)checkShowPhotoArea{//检查是否要显示底部附件上传区域
    NSInteger count = self->taskBeanList.count;
    if ([self->currentActivity.activityDefinitionCode isEqualToString:ACTIVITY_CODE_DELIVERY_RECEIPT]) {
        [self hidePhotoView];
    }else{//普通活动上报
        if (count > 1 || count == 0) {
            [self hidePhotoView];
        }else if(count > 0){
            [self showPhotoView:self->taskBeanList.firstObject];
        }
    }
}

//-(void)didScrollToRow:(NSIndexPath *)indexPath{
//    if (!isClickTab) {//非点击左侧tab按钮才可以触发
//        [self.tabView setSelectedIndex:indexPath.section];
//    }
//}

-(void)didEndScrollingAnimation{
    isClickTab = NO;
}

//- (void)eventOccurred:(NSNotification*)eventData{
//    //    DDLog(@"eventOccurred:收到消息");
//    NSNumber* pageIndexValue = eventData.object;
//    NSInteger pageIndex = [pageIndexValue integerValue];
//    NSIndexPath * indexPath;
//    NSInteger sourceCount = [self.tableView getSourceCount];
//    if (sourceCount <= 1) {
//        [HudManager showToast:@"没有下一个订单!"];
//        return;
//    }
//    if (pageIndex < sourceCount - 1) {//下一个
//        indexPath = [NSIndexPath indexPathForRow:0 inSection:pageIndex + 1];
//    }else{//置顶
//        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    }
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}

//-(void)didSelectIndex:(NSInteger)index{
//    isClickTab = YES;
//    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}

-(BOOL)autoRefreshHeader{
    return NO;
}

-(void)clickSubmitButton:(UIView*)sender{
    if ([self->currentActivity.activityDefinitionCode isEqualToString:ACTIVITY_CODE_DELIVERY_RECEIPT]) {
        if ([self checkCanSubmitReceipt:NO]) {
            [self submitReceiptTask];
        }
    }else if ([self->currentActivity.activityDefinitionCode isEqualToString:ACTIVITY_CODE_PICKUP_HANDOVER]
              && ![self->currentActivity hasReport]) {//揽收还未上报过 必须上传凭证
        if ([self checkCanSubmitReceipt:NO]) {
            [self submitNormalTask];
        }
    }else{
        [self submitNormalTask];
    }
}

-(BOOL)checkCanSubmitReceipt:(BOOL)hasOne{
    NSInteger count = self->taskBeanList.count;
    for (NSInteger i = 0; i < count; i++) {
//    for (ShipmentTaskBean* taskBean in self->taskBeanList) {
        ShipmentTaskBean* taskBean = self->taskBeanList[i];
        if (taskBean.assetsArray.count > 0 && hasOne) {//只要有一个存在就可以上传
            return YES;
        }else if (taskBean.assetsArray.count <= 0 && !hasOne) {//必须每个task都添加文件
            [HudManager showToast:[NSString stringWithFormat:@"订单:%@ 没有添加任何凭证，请添加后上报!",taskBean.orderBaseCode]];
            NSInteger count = self->taskBeanList.count;
            if (count > 1) {//2个以上的订单
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
                [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
                UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
                if (cell) {
                    [PopAnimateManager startShakeAnimation:cell];
                }else{
                    double delayInSeconds = 0.3;
                    __weak __typeof(self) weakSelf = self;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        UITableViewCell * cell = [weakSelf.tableView cellForRowAtIndexPath:indexPath];
                        if (cell) {
                            [PopAnimateManager startShakeAnimation:cell];
                        }
                    });
                }
            }else if(count > 0){//单个订单
                [PopAnimateManager startShakeAnimation:self.photoContainer];
            }
            return NO;
        }
    }
    return YES;
}

-(void)submitNormalTask{
    [SVProgressHUD showWithStatus:ConcatStrings([Config getActivityLabelByCode:self->currentActivity.activityDefinitionCode],@"上报中") maskType:SVProgressHUDMaskTypeBlack];
    __weak __typeof(self) weakSelf = self;
    [self.viewModel submitAllTasks:self->taskBeanList returnBlock:^(id returnValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
//        ShipmentActivityBean* newActivity = [ShipmentActivityBean yy_modelWithJSON:returnValue];
//        strongSelf->currentActivity.status = newActivity.status;
//        strongSelf->currentActivity.itemStatus = newActivity.itemStatus;
        
//        [strongSelf.tabView refreshActivityByIndex:strongSelf.tabView.selectedIndex];//重刷下
        [strongSelf changeActivityStatusComplete];
        
        if ([strongSelf checkCanSubmitReceipt:YES]) {
            [strongSelf submitReceiptTask];
        }else{
            [strongSelf showNextActivityAlert];
            [SVProgressHUD dismiss];
        }
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [SVProgressHUD dismiss];
        [HudManager showToast:[NSString stringWithFormat:@"活动上报失败:%@",errorMsg]];
    }];
}

-(void)showEditedActivityAlert:(NSInteger)nextIndex{
    UIAlertController *alertController;
    NSString* alertMessage;
    __weak __typeof(self) weakSelf = self;
    if(nextIndex < 0){//返回上一层
        alertMessage = @"您当前有正在编辑的订单，确定离开当前页面？";
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"留在当前" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf popToPrevController];
        }]];
    }else{
        ShipmentActivityBean* nextActivityBean = self.activityBeans[nextIndex];
        NSString* nextLabel = [Config getActivityLabelByCode:nextActivityBean.activityDefinitionCode];
        alertMessage = [NSString stringWithFormat:@"您当前有正在编辑的订单，确定是否跳转%@活动页面？\n(跳转会清除编辑过的数据)",nextLabel];
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"留在当前" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"去%@",nextLabel] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.tabView setSelectedIndex:nextIndex];
        }]];
    }
    
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)showNextActivityAlert{
    UIAlertController *alertController;
    NSInteger nextIndex = [self getPendingReportActivityIndex:self.activityBeans isNext:YES];
    
    __weak __typeof(self) weakSelf = self;
    if (nextIndex < 0) {//返回上一层
//        NSInteger selectedIndex = self.tabView.selectedIndex;
        NSString* alertMessage;
//        UIAlertAction* nextAction;
//        if (selectedIndex + 1 < self.activityBeans.count) {//有下一个活动
//            nextIndex = selectedIndex + 1;
//            ShipmentActivityBean* nextActivityBean = self.activityBeans[nextIndex];
//             NSString* nextLabel = [Config getActivityLabelByCode:nextActivityBean.activityDefinitionCode];
//            nextAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"去%@",[Config getActivityLabelByCode:nextActivityBean.activityDefinitionCode]] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [weakSelf.tabView setSelectedIndex:nextIndex];
//            }];
//            alertMessage = [NSString stringWithFormat:@"该停靠站下的活动已全部完成，是否仍然进入下一个%@活动，或者返回上一页？",nextLabel];
//        }else{
            alertMessage = @"该停靠站下的活动已全部完成，是否返回上一页？";
//        }
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"留在当前" style:UIAlertActionStyleDefault handler:nil]];
//        if (nextAction) {
//            [alertController addAction:nextAction];
//        }
        [alertController addAction:[UIAlertAction actionWithTitle:@"上一页" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf popToPrevController];
        }]];
    }else{
        ShipmentActivityBean* nextActivityBean = self.activityBeans[nextIndex];
        NSString* nextLabel = [Config getActivityLabelByCode:nextActivityBean.activityDefinitionCode];
        
//        __weak __typeof(self) weakSelf = self;
        alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"活动上报完成，是否进入下一个%@活动？",nextLabel] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"留在当前" style:UIAlertActionStyleCancel handler:nil]];
        [alertController addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"去%@",nextLabel] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf.tabView setSelectedIndex:nextIndex];
        }]];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {//确定
        NSInteger nextIndex = [self getPendingReportActivityIndex:self.activityBeans isNext:YES];
        if (nextIndex < 0) {//返回上一层
            [self popToPrevController];
        }else{
            [self.tabView setSelectedIndex:nextIndex];
        }
    }
}

-(void)submitReceiptTask{
    
    [SVProgressHUD showWithStatus:ConcatStrings([Config getActivityLabelByCode:self->currentActivity.activityDefinitionCode],@"单据上传中") maskType:SVProgressHUDMaskTypeBlack];
    __weak __typeof(self) weakSelf = self;
    [self.viewModel uploadAllReceipts:self->taskBeanList returnBlock:^(id returnValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf->currentActivity.status = ACTIVITY_STATUS_REPORTED;//回单上传完成
//        [strongSelf.tabView refreshActivityByIndex:strongSelf.tabView.selectedIndex];//重刷下
        
        [strongSelf changeActivityStatusComplete];
        
        [strongSelf showNextActivityAlert];
        
        [SVProgressHUD dismiss];
    } progressBlock:^(float completed, float total, NSString* title) {
        
        [SVProgressHUD showProgress:completed / total];
        
    } failureBlock:^(NSString *errorCode, NSString *errorMsg) {
        [HudManager showToast:[NSString stringWithFormat:@"单据上传失败:%@",errorMsg]];
        [SVProgressHUD dismiss];
    }];
}

-(void)changeActivityStatusComplete{
    NSString* reportedStatus = ACTIVITY_STATUS_REPORTED;
    self->currentActivity.status = reportedStatus;//回单上传完成
    for (ShipmentTaskBean* taskBean in self->taskBeanList) {
        taskBean.status = reportedStatus;
    }
    [self changeSubmitButtonStatus];
    
//    NSInteger nextIndex = [self getPendingReportActivityIndex:self.activityBeans isNext:YES];
//    if (nextIndex < 0) {//全部活动都已上报完成
//        self.stopBean.isComplete = [self.stopBean getIsComplete];
//    }
}

-(BOOL)checkCanLeaveTask{
    if (self->taskBeanList) {
        for (ShipmentTaskBean* taskBean in self->taskBeanList) {
            if (taskBean.isEdited) {//已经被编辑过了
                return NO;
            }
        }
    }
    return YES;
}

#pragma OrderTabViewDelegate
-(BOOL)shouldSelectIndex:(NSInteger)index{
    if ([self checkCanLeaveTask]) {
        return YES;
    }else{
        [self showEditedActivityAlert:index];
        return NO;
    }
}

#pragma OrderTabViewDelegate
-(void)didSelectItem:(ShipmentActivityBean *)activityBean{
    self->currentActivity = activityBean;
//    [self.tableView headerBeginRefresh];
    [self loadOrderData];
    
    [self changeSubmitButtonStatus];
    
//    if ([activityBean.activityDefinitionCode isEqualToString:ACTIVITY_CODE_DELIVERY_RECEIPT]) {//测试回单...
//        double delayInSeconds = 10.0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            [self submitReceiptTask];
//            [self submitReceiptTask];
//        });
//    }
}

-(void)changeSubmitButtonStatus{
    UIColor* statusColor;
    if ([self->currentActivity hasReport]) {
        statusColor = COLOR_YI_WAN_CHENG;
    }else{
        statusColor = COLOR_DAI_WAN_CHENG;
    }
    self.submitButton.fillColor = statusColor;
    self.submitButton.title = ConcatStrings([Config getActivityIconByCode:self->currentActivity.activityDefinitionCode],@"   确认",[Config getActivityLabelByCode:self->currentActivity.activityDefinitionCode]);//,@"(",[Config getActivityStatusLabel:self->currentActivity.status],@")"
}

-(void)didSelectRow:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SourceVo* source = [self.tableView getSourceByIndex:indexPath.section];
    CellVo* cellVo = source.data[indexPath.row];
    if ([NSStringFromClass(cellVo.cellClass) isEqualToString:NSStringFromClass([OrderNormalCell class])]) {
        OrderEditModelView* editView = [[OrderEditModelView alloc]init];
        editView.shipUnitIndexPath = indexPath;
        editView.shipUnitBean = (ShipmentActivityShipUnitBean*)cellVo.cellData;
//        editView.delegate = self;
        [editView show];
    }
}

//#pragma OrderEditModelDelegate
//-(void)orderEdited:(NSIndexPath *)indexPath{
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];//这行数据刷新
//}


@end
