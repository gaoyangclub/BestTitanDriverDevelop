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

@interface TestTableViewCell2 : MJTableViewCell

@end

@implementation TestTableViewCell2

-(void)showSubviews{
    //    self.backgroundColor = [UIColor magentaColor];
    
    self.textLabel.text = (NSString*)self.data;
}

@end

@interface TaskTripController()<TaskActivityViewDelegate>{
//    UILabel* titleLabel;
}
//@property(nonatomic,retain)UIView* titleView;
@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)UIButton* submitButton;

@property(nonatomic,retain)UIButton* attachmentButton;

@property(nonatomic,retain)UIControl* moreButton;

@end

@implementation TaskTripController

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

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:[UIColor whiteColor] text:NAVIGATION_TITLE_TASK_TRIP superView:nil];
    }
    return _titleLabel;
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    
//    [UICreationUtils createNavigationLeftButtonItem:[UIColor whiteColor] target:self action:@selector(leftClick)];
    
    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_DI_TU target:self action:@selector(rightClick)];
    
    self.titleLabel.text = @"TO12451516161";//标题显示TO号
    [self.titleLabel sizeToFit];
//    self.titleView.bounds = titleLabel.bounds;
    self.navigationItem.titleView = self.titleLabel;//self.titleView;
    
//    titleLabel.center = self.titleView.center;
    
}

//进入地图详情页
-(void)rightClick{
    
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    int64_t delay = 1.0 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        
        NSMutableArray<ShipmentStopBean*>* stopArr = [NSMutableArray<ShipmentStopBean*> array];
        int stopCount = (arc4random() % 10) + 2;
        for (NSUInteger i = 0; i < stopCount; i++) {
            ShipmentStopBean* bean = [[ShipmentStopBean alloc]init];
            bean.isComplete = (arc4random() % 3) > 0 ? NO : YES;//;
            bean.shortAddress = ConcatStrings(@"横港路李宁店",[NSNumber numberWithInteger:i + 1],@"号店");
            bean.stopName = ConcatStrings(@"上海上海市松江区上海上海市松江区",bean.shortAddress,@"18弄63号");
            
            bean.pickupCount = (arc4random() % 15);
            bean.deliverCount = (arc4random() % 15);
            bean.orderCount = (arc4random() % 10) + 1;
            [stopArr addObject:bean];
        }
        [self.tableView clearSource];
        
        NSMutableArray<CellVo*>* sourceData = [NSMutableArray<CellVo*> array];
//        int count = 1;//(arc4random() % 18) + 30; //生成3-10范围的随机数
        for (NSUInteger i = 0; i < stopCount; i++) {
            //            [self.sourceData addObject:[NSString stringWithFormat:@"数据: %lu",i]];
            [sourceData addObject:
             [CellVo initWithParams:TASK_TRIP_CELL_HEIGHT cellClass:[TaskTripCell class] cellData:stopArr[i]]];
        }
        [self.tableView addSource:[SourceVo initWithParams:sourceData headerHeight:0 headerClass:nil headerData:NULL]];//[TaskTripSection class]
        handler(sourceData.count > 0);
    });
//    handler(NO);
}

//-(void)footerLoadMore:(FooterLoadMoreHandler)handler{
//    int64_t delay = 1.0 * NSEC_PER_SEC;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
//        int count = (arc4random() % 3); //生成0-2范围的随机数
//        if (count <= 0) {
//            handler(NO);
//            return;
//        }
//        SourceVo* svo = self.tableView.getLastSource;
//        NSMutableArray<CellVo*>* sourceData = svo.data;
//        NSUInteger startIndex = [svo getRealDataCount];
//        for (NSUInteger i = 0; i < count; i++) {
//            [sourceData addObject:
//             [CellVo initWithParams:50 cellClass:[TestTableViewCell2 class] cellData:[NSString stringWithFormat:@"测试数据: %lu",startIndex + i]]];
//        }
//        handler(YES);
//    });
//}

//-(CGRect)getTableViewFrame{
//    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
//    CGFloat viewHeight = CGRectGetHeight(self.view.bounds);
//    
//    CGFloat padding = 5;
//    CGFloat tableHeight = viewHeight - SUBMIT_BUTTON_HEIGHT - padding * 2;
//    
//    return CGRectMake(0, 0, viewWidth, tableHeight);
//}

-(void)viewDidLoad{
    [super viewDidLoad];
    self.tableView.clickCellMoveToCenter = YES;
//    self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventOccurredActivity:)
                                                 name:EVENT_ACTIVITY_SELECT
                                               object:nil];
}

-(void)didRefreshComplete{
    SourceVo* sourceVo = self.tableView.dataSourceArray[0];
    NSInteger selectIndex = (arc4random() % sourceVo.data.count);
    self.selectedIndexPath = [NSIndexPath indexPathForRow:selectIndex inSection:0];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_ACTIVITY_SELECT object:nil];
}

- (void)eventOccurredActivity:(NSNotification*)eventData{
    [self jumpOrderViewController:nil];
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

-(void)jumpOrderViewController:(ShipmentActivityBean*)activityBean{
    UIViewController* controller = [[OrderViewController alloc]init];
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
    [self jumpOrderViewController:activityBean];
}

-(void)didSelectRow:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    MJTableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
//    [self showStopActivity:cell.data];
//    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_ADDRESS_SELECT object:cell.data];
    
//    DDLog(@"didSelectRow:%@%@",@"收到选中行消息...",indexPath);
}


@end
