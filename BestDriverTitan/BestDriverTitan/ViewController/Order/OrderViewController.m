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

@interface TestTableViewCell3 : MJTableViewCell

@end
@implementation TestTableViewCell3

-(void)showSubviews{
    //    self.backgroundColor = [UIColor magentaColor];
    
    self.textLabel.text = (NSString*)self.data;
}

@end

@interface OrderViewController()<OrderTabViewDelegate>{
    UILabel* titleLabel;
    BOOL isClickTab;
}

@property(nonatomic,retain)OrderTabView* tabView;
@property(nonatomic,retain)UIView* titleView;

//地址信息栏区域
@property(nonatomic,retain)ASDisplayNode* addressView;
//@property(nonatomic,retain)ASDisplayNode* addressLine;
@property(nonatomic,retain)ASTextNode* iconAddress;//起点图标
@property(nonatomic,retain)ASTextNode* textAddress;//起点图标

@property(nonatomic,retain)FlatButton* submitButton;

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
        _textAddress.maximumNumberOfLines = 3;
        _textAddress.truncationMode = NSLineBreakByTruncatingTail;
        _textAddress.layerBacked = YES;
        [self.addressView addSubnode:_textAddress];
    }
    return _textAddress;
}

-(FlatButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [[FlatButton alloc]init];
        _submitButton.titleFontName = ICON_FONT_NAME;
        _submitButton.fillColor = COLOR_PRIMARY;
        _submitButton.titleSize = 18;
        [self.view addSubview:_submitButton];
    }
    return _submitButton;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]init];
        
        titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:[UIColor whiteColor] text:NAVIGATION_TITLE_TASK_TRIP superView:_titleView];
    }
    return _titleView;
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
//    [UICreationUtils createNavigationLeftButtonItem:[UIColor whiteColor] target:self action:@selector(leftClick)];
    
    //    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(rightItemClick)];
    
    self.navigationItem.titleView = self.titleView;
    
    titleLabel.text = @"TO12451516161AAA";//标题显示TO号
    [titleLabel sizeToFit];
    titleLabel.center = self.titleView.center;
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(OrderTabView *)tabView{
    if (!_tabView) {
        _tabView = [[OrderTabView alloc]init];
        [self.view addSubview:_tabView];
    }
    return _tabView;
}

-(CGRect)getTableViewFrame{
    CGFloat margin = 4;
    CGFloat squareHeight = TASK_TRIP_SECTION_TOP_HEIGHT - margin;
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.view.bounds);
    
    self.addressView.frame = CGRectMake(0, 0, viewWidth, squareHeight);
    self.tabView.frame = CGRectMake(0, squareHeight + margin, viewWidth, ORDER_TAB_HEIGHT);
    
    CGFloat buttonAreaHeight = 55;
    
    self.submitButton.frame = CGRectMake(margin, viewHeight - buttonAreaHeight + margin, viewWidth - margin * 2, buttonAreaHeight - margin * 2);
    
    CGFloat tabHeight = CGRectGetHeight(self.view.bounds) - squareHeight - ORDER_TAB_HEIGHT;
    return CGRectMake(margin, squareHeight + margin * 2 + ORDER_TAB_HEIGHT, viewWidth - margin * 2, tabHeight - margin * 2 - buttonAreaHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.sectionGap = 5;
    self.tabView.tabDelegate = self;
    
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
        bean.status = arc4random() % 2 > 0 ? ACTIVITY_STATUS_REPORTED : ACTIVITY_STATUS_PENDING_REPORT;
        [activityBeans addObject:bean];
    }
    [self.tabView setActivityBeans:activityBeans];
    [self.tabView setSelectedIndex:arc4random() % activityBeans.count];
    
    CGFloat sectionWidth = self.view.bounds.size.width;
    CGFloat leftpadding = 10;
    CGFloat squareHeight = TASK_TRIP_SECTION_TOP_HEIGHT - 5;
    self.iconAddress.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:30 content:ICON_JU_LI];
    CGSize iconStartSize = [self.iconAddress measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconAddress.frame = (CGRect){ CGPointMake(leftpadding,(squareHeight - iconStartSize.height) / 2.),iconStartSize};
    
//    self.addressLine.frame = CGRectMake(0, squareHeight - LINE_WIDTH * 4, sectionWidth, LINE_WIDTH * 4);
    
    NSString* address = @"上海上海市松江区上海上海市松江区大港镇松镇公路1339号宝湾物流112号库";
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:FlatBlack size:14 content:address];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, address.length)];
    self.textAddress.attributedString = textString;
    
    CGFloat maxStartWidth = sectionWidth - leftpadding * 2 - iconStartSize.width;
    CGSize textStartSize = [self.textAddress measure:CGSizeMake(maxStartWidth, FLT_MAX)];
    self.textAddress.frame = (CGRect){ CGPointMake(leftpadding + iconStartSize.width + leftpadding / 2.,(squareHeight - textStartSize.height) / 2.),textStartSize};
    
    
//    self.view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    singleTap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:singleTap];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventOccurred:)
                                                 name:EVENT_ORDER_PAGE_CHANGE
                                               object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_ORDER_PAGE_CHANGE object:nil];
}


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

-(BOOL)getShowFooter{
    return NO;
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    int64_t delay = 1.0 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        int count = (arc4random() % 3) + 1; //生成3-10范围的随机数
    
        [self.tableView clearSource];
        
        for (NSInteger i = 0; i < count; i++) {
            NSMutableArray* sourceData = [NSMutableArray<CellVo*> array];
            
            int count2 = (arc4random() % 3) + 1; //生成1-3范围的随机数
            for (NSInteger j = 0; j < count2; j++) {
                [sourceData addObject:[CellVo initWithParams:ORDER_VIEW_CELL_HEIGHT cellClass:[OrderNormalCell class] cellData:@"数据"]];
            }
            
            SourceVo* svo = [SourceVo initWithParams:sourceData headerHeight:ORDER_VIEW_SECTION_HEIGHT headerClass:[OrderViewSection class] headerData:NULL];
            [self.tableView addSource:svo];
        }
//        [self.tabView setTotalCount:count];
        
        handler(count > 0);
    });
}

//-(void)didScrollToRow:(NSIndexPath *)indexPath{
//    if (!isClickTab) {//非点击左侧tab按钮才可以触发
//        [self.tabView setSelectedIndex:indexPath.section];
//    }
//}

-(void)didEndScrollingAnimation{
    isClickTab = NO;
}

- (void)eventOccurred:(NSNotification*)eventData{
    //    DDLog(@"eventOccurred:收到消息");
    NSNumber* pageIndexValue = eventData.object;
    NSInteger pageIndex = [pageIndexValue integerValue];
    NSIndexPath * indexPath;
    NSInteger sourceCount = [self.tableView getSourceCount];
    if (sourceCount <= 1) {
        [HudManager showToast:@"没有下一个订单!"];
        return;
    }
    if (pageIndex < sourceCount - 1) {//下一个
        indexPath = [NSIndexPath indexPathForRow:0 inSection:pageIndex + 1];
    }else{//置顶
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//-(void)didSelectIndex:(NSInteger)index{
//    isClickTab = YES;
//    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
//}

-(BOOL)autoRefreshHeader{
    return NO;
}

-(void)didSelectItem:(ShipmentActivityBean *)activityBean{
    [self.tableView headerBeginRefresh];
    UIColor* statusColor;
    if ([activityBean hasReport]) {
        statusColor = COLOR_YI_WAN_CHENG;
    }else{
        statusColor = COLOR_DAI_WAN_CHENG;
    }
    self.submitButton.fillColor = statusColor;
    self.submitButton.title = ConcatStrings([Config getActivityIconByCode:activityBean.activityDefinitionCode],@"   ",[Config getActivityLabelByCode:activityBean.activityDefinitionCode],@"(",[Config getActivityStatusLabel:activityBean.status],@")");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
