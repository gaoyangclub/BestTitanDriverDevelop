//
//  ScanResultViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/11/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ScanResultViewController.h"
#import "ScanTaskResultBean.h"
#import "ScanTaskOrderCell.h"
#import "HudManager.h"
#import "FlatButton.h"
#import "ScanHomeController.h"
#import "EmptyDataSource.h"

#define VIEW_MARGIN rpx(4)

@interface ScanResultViewController (){
    BOOL isAllDone;
    BOOL isAllFinish;//强制上报
    BOOL isError;
    NSArray<NSString*>* allPeddingSourceCodes;
}

@property(nonatomic,retain) UILabel* titleLabel;//大标题栏
@property(nonatomic,retain) FlatButton* submitButton;//完成按钮
@property(nonatomic,retain) EmptyDataSource* emptyDataSource;

@end

@implementation ScanResultViewController

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:@"" superView:nil];
    }
    return _titleLabel;
}

-(FlatButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[FlatButton alloc]init];
        _submitButton.titleFontName = ICON_FONT_NAME;
        _submitButton.fillColor = COLOR_PRIMARY;
        _submitButton.title = @"完   成";
        _submitButton.titleSize = SIZE_TEXT_LARGE;
//        _submitButton.hidden = YES;
        [_submitButton addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

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


-(BOOL)getShowFooter{
    return NO;
}

//-(BOOL)autoRefreshHeader{
//    return NO;//self.hasHistory;
//}

-(void)refreshAndEmptyDataSource{
//    [self.tableView headerBeginRefresh];
    
    self.emptyDataSource.buttonTitle = nil;
    self.emptyDataSource.noDataIconName = ICON_EMPTY_NO_DATA;
    self.emptyDataSource.noDataDescription = @"暂时没有正常扫描的订单";
    
    self.tableView.emptyDataSetSource = self.emptyDataSource;
    self.tableView.emptyDataSetDelegate = self.emptyDataSource;
}

-(CGRect)getTableViewFrame{
//    if (!_submitButton || _submitButton.hidden) {
//        return self.view.bounds;
//    }
    CGFloat const margin = VIEW_MARGIN;
    CGFloat const buttonHeight = rpx(55);
    self.submitButton.frame = CGRectMake(margin, self.view.height - buttonHeight + margin, self.view.width - margin * 2, buttonHeight - margin * 2);
    return CGRectMake(margin, margin, self.view.width - margin * 2, self.submitButton.y - margin * 2);
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self initNavigationItem];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(void)initNavigationItem{
    self.titleLabel.text = ConcatStrings([Config getActivityLabelByCode:self.activityCode],@"结果");
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    self.navigationItem.leftBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:SIZE_NAVI_TITLE] text:ICON_FAN_HUI target:self action:@selector(leftClick)];

}

-(void)leftClick{
    if (!isError) {
        __weak __typeof(self) weakSelf = self;
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否继续扫描？"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"留在当前" style:UIAlertActionStyleCancel handler:nil]];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"去扫描" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //            __strong typeof(weakSelf) strongSelf = weakSelf;
            [weakSelf backToScanViewController];
        }]];
        [self presentViewController:alertCtrl animated:YES completion:nil];
    }else{
        [self backToScanViewController];
    }
}

-(void)backToScanViewController{
    //上一页清除数据!!!
    [self.navigationController popViewControllerAnimated:YES];
}
     
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshAndEmptyDataSource];
    
    self.tableView.cellGap = VIEW_MARGIN;
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    
    if (![NetRequestClass netWorkReachability]) {//网络异常
        self.emptyDataSource.netError = YES;
        [self.tableView clearSource];
        handler(NO);
        return;
    }
    self.emptyDataSource.netError = NO;
    __weak __typeof(self) weakSelf = self;
    ReturnValueBlock returnBlock = ^(id returnValue) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf){//界面已经被销毁
            return;
        }
        
        if (returnValue && strongSelf->isAllFinish) {
            [HudManager showToast:@"全部上报完毕!"];
            [strongSelf backToScanHomeController];
            handler(NO);
            return;
        }
        
        ScanTaskResultBean* resultBean = [ScanTaskResultBean yy_modelWithJSON:returnValue];
        
        [strongSelf.tableView clearSource];
        
        NSMutableArray<CellVo*>* sourceData = [NSMutableArray<CellVo*> array];
        for (ScanTaskOrderBean* orderBean in resultBean.orders) {
            [sourceData addObject:
             [CellVo initWithParams:1 cellClass:[ScanTaskOrderCell class] cellData:orderBean]];
        }
        [strongSelf.tableView addSource:[SourceVo initWithParams:sourceData headerHeight:0 headerClass:nil headerData:NULL]];
        
        strongSelf->isAllDone = [strongSelf checkOrderAllScaned:resultBean];
        strongSelf->allPeddingSourceCodes = [strongSelf getAllPeddingSourceCodes:resultBean];
//        if (!strongSelf->isAllDone) {
//            strongSelf.submitButton.hidden = NO;//显示强制上报
//            [strongSelf.view setNeedsLayout];
//        }
        
        [HudManager showToast:strongSelf->isAllDone ? @"赞,订单已全部完成" : ConcatStrings(@"该地址下还有未扫描",[Config getActivityLabelByCode:strongSelf.activityCode],@"的货物")];
        
        handler(resultBean.orders && resultBean.orders.count > 0);
    };
    FailureBlock failureBlock = ^(NSString *errorCode, NSString *errorMsg) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf->isError = YES;
        [HudManager showToast:errorMsg];
//        strongSelf.emptyDataSource.netError = !errorCode;//errorCode不存在就是网络错误
        [strongSelf.tableView clearSource];
        handler(NO);
    };
    if ([ACTIVITY_CODE_PICKUP_HANDOVER isEqual:self.activityCode]) {
        if (self.taskPickUpBean) {
            [self.viewModel getScanTaskPickUpResult:self.taskPickUpBean returnBlock:returnBlock failureBlock:failureBlock];
        }else{
            [HudManager showToast:@"暂无揽收数据!"];
            self->isError = YES;
            [self.tableView clearSource];
            handler(NO);
        }
    }else if([ACTIVITY_CODE_SIGN_FOR_RECEIPT isEqual:self.activityCode]){
        NSMutableArray<ScanCodeSignBean*>* scanActivityTaskBeans = [NSMutableArray<ScanCodeSignBean*> array];
        for (NSString* sourceCode in self.sourceCodeList) {
            ScanCodeSignBean* codeSignBean = [[ScanCodeSignBean alloc]init];
            codeSignBean.activityDefinitionCode = self.activityCode;
            codeSignBean.sourceCode = sourceCode;
            codeSignBean.sourceType = SCAN_SOURCETYPE_PICKUP;
            [scanActivityTaskBeans addObject:codeSignBean];
        }
        ScanTaskSignBean* scanTaskSignBean = [[ScanTaskSignBean alloc]init];
        scanTaskSignBean.scanActivityTaskBeans = scanActivityTaskBeans;
        [self.viewModel getScanTaskSignResult:scanTaskSignBean returnBlock:returnBlock failureBlock:failureBlock];
    }
}

-(BOOL)checkOrderAllScaned:(ScanTaskResultBean*)resultBean{
    for (ScanTaskOrderBean* orderBean in resultBean.orders) {
        if (orderBean.penddingReportPickupCodes && orderBean.penddingReportPickupCodes.count > 0) {//有未完成的
            return NO;
        }
    }
    return YES;
}

-(NSArray<NSString*>*)getAllPeddingSourceCodes:(ScanTaskResultBean*)resultBean{
    NSMutableArray<NSString*>* peddingSourceCodes = [NSMutableArray<NSString*> array];
    for (ScanTaskOrderBean* orderBean in resultBean.orders) {
        if (orderBean.penddingReportPickupCodes && orderBean.penddingReportPickupCodes.count > 0) {//有未完成的
            [peddingSourceCodes addObjectsFromArray:orderBean.penddingReportPickupCodes];
        }
    }
    return peddingSourceCodes;
}

-(void)clickSubmitButton:(UIView*)sender{
    [PopAnimateManager startClickAnimation:sender];
    if (!self->isAllDone && !isError) {
        __weak __typeof(self) weakSelf = self;
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示" message:
                                        ConcatStrings(@"提交成功，但还有未扫描",[Config getActivityLabelByCode:self.activityCode],@"的货物，是否继续扫描？")
                                         preferredStyle:UIAlertControllerStyleAlert];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"继续扫描" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf backToScanViewController];
        }]];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"强制完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            __strong typeof(weakSelf) strongSelf = weakSelf;
            [weakSelf uploadAllData];
        }]];
        [self presentViewController:alertCtrl animated:YES completion:nil];
    }else{//去operate结果页
        [self backToScanHomeController];
    }
}

-(void)uploadAllData{//强制上报活动
    if ([ACTIVITY_CODE_PICKUP_HANDOVER isEqual:self.activityCode]) {
        ScanTaskPickUpBean* peddingTaskPickUpBean = [[ScanTaskPickUpBean alloc]init];
        
        for (NSString* sourceCode in self->allPeddingSourceCodes) {
            ScanCodePickUpBean* itemBean = [[ScanCodePickUpBean alloc]init];
            itemBean.weight = @"0";
            itemBean.volume = @"0";
            itemBean.activityDefinitionCode = self.activityCode;
            itemBean.sourceCode = sourceCode;
            itemBean.sourceType = SCAN_SOURCETYPE_PICKUP;
            [peddingTaskPickUpBean addScanCodeBean:itemBean];
        }
        self.taskPickUpBean = peddingTaskPickUpBean;
    }else if([ACTIVITY_CODE_SIGN_FOR_RECEIPT isEqual:self.activityCode]){
        self.sourceCodeList = self->allPeddingSourceCodes;
    }
    self->isAllFinish = YES;
    [self.tableView headerBeginRefresh];
}

-(void)backToScanHomeController{//回ScanHomeController界面
    UIViewController* homeController = [self getScanHomeController];
    if (homeController) {
        [self.navigationController popToViewController:homeController animated:YES];
    }else{
        [self backToScanViewController];
    }
}

-(UIViewController*)getScanHomeController{
    NSArray<UIViewController*>* viewControllers = self.navigationController.viewControllers;
    NSInteger const count = viewControllers.count;
    for (NSInteger i = count - 1; i >= 0; i--) {
        UIViewController* viewController = viewControllers[i];
        if ([viewController isKindOfClass:[ScanHomeController class]]) {
            return viewController;
        }
    }
    return nil;
}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
