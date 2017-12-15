//
//  MessageViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MessageViewController.h"
#import "EmptyDataSource.h"
#import "AppPushMsg.h"
#import "SpeechManager.h"
#import "MessageViewCell.h"
#import "MessageViewSection.h"
#import "AppDelegate.h"
#import "OwnerViewController.h"
#import "TaskTripController.h"

#define MESSAGE_CELL_GAP rpx(10)

@interface MessageViewController ()

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)EmptyDataSource* emptyDataSource;

@end

@implementation MessageViewController

-(BOOL)getShowHeader{
    return NO;
}

-(BOOL)getShowFooter{
    return NO;
}

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
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_MESSAGE superView:nil];
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

-(CGRect)getTableViewFrame{
    return CGRectMake(0, 0, self.view.width, self.view.height - MESSAGE_CELL_GAP);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initEmptyData];
    
    self.tableView.emptyDataSetSource = self.emptyDataSource;
    self.tableView.emptyDataSetDelegate = self.emptyDataSource;
    self.tableView.cellGap = MESSAGE_CELL_GAP;
    [self.tableView reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventMessage:)
                                                 name:EVENT_REFRESH_SHIPMENTS
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventLogout)
                                                 name:EVENT_LOGOUT
                                               object:nil];
    
//    for (NSInteger i = 0; i < 50; i++) {
//        AppPushMsg* pushMsg = [[AppPushMsg alloc]init];//测试专用
//        pushMsg.type = PUSH_TYPE_CREATE;
//        pushMsg.msg = ConcatStrings(@"任务",@(i),@"  您有新的任务，啊哈哈哈哈哈哈\n差个我啊high啊改我高哈根我哦化工我过后爱国hi哦啊个哈哈够i好嗲后端哈哈哈!");
//        
//        [self createPushMsgSource:pushMsg];
//    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOGOUT object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_REFRESH_SHIPMENTS object:nil];
}

-(void)eventLogout{//退出登录后清除掉消息
    [self.tableView clearSource];
    [self.tableView reloadMJData];
    [self showMessageBadge:0];//清除底部badge
}

-(void)eventMessage:(NSNotification*)eventData{
    AppPushMsg* pushMsg = eventData.object;
    [self createPushMsgSource:pushMsg];
}

-(void)createPushMsgSource:(AppPushMsg*)pushMsg{//倒序排列消息
    if (!pushMsg) {
        return;
    }
    
    CellVo* cvo = [CellVo initWithParams:0 cellClass:[MessageViewCell class] cellData:pushMsg];
    
    SourceVo* svo = [self.tableView getFirstSource];//从头部找最新的
    MessageViewSectionVo* mvo = (MessageViewSectionVo*)svo.headerData;
    NSDate* startDate = mvo.dateTime;
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];//"yyyy-MM-dd HH:mm:ss"
    if (![[dateFormatter stringFromDate:startDate] isEqual:[dateFormatter stringFromDate:pushMsg.createTime]]) {//时间不一致
        mvo = [[MessageViewSectionVo alloc]init];
        mvo.dateTime = pushMsg.createTime;
        
        NSMutableArray<CellVo*>* sourceData = [NSMutableArray<CellVo*> array];
        //    for (NSUInteger i = 0; i < sortStopList.count; i++) {
        [sourceData addObject:cvo];
        [self.tableView insertSource:[SourceVo initWithParams:sourceData headerHeight:MESSAGE_VIEW_SECTION_HEIGHT headerClass:[MessageViewSection class] headerData:mvo] atIndex:0];//在头部插入
    }else{
        [svo.data insertObject:cvo atIndex:0];//直接并在上一组头部
    }
    
    [self.tableView reloadMJData];//直接刷新
    
    [self showMessageBadge:[self getNotReadMessageCount]];
}

-(NSInteger)getNotReadMessageCount{
    NSInteger readCount = 0;
    NSInteger count = [self.tableView getSourceCount];
    for (NSInteger i = 0; i < count; i++) {
        SourceVo* svo = [self.tableView getSourceByIndex:i];
        for (CellVo* cvo in svo.data) {
            AppPushMsg* pushMsg = cvo.cellData;
            if (pushMsg && !pushMsg.isRead) {
                readCount ++;
            }
        }
    }
    return readCount;
}

-(void)showMessageBadge:(NSInteger)count{
    AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDelegate.rootTabBarController setItemBadge:count atIndex:1];
}

-(void)didSelectRow:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CellVo* cvo = [self.tableView getCellVoByIndexPath:indexPath];
    if (cvo && cvo.cellData) {
        AppPushMsg* pushMsg = cvo.cellData;
        pushMsg.isRead = YES;
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        [self showMessageBadge:[self getNotReadMessageCount]];
        
        [self gotoTaskTripController:pushMsg];
    }
}

-(void)gotoTaskTripController:(AppPushMsg*)pushMsg{
    if (pushMsg.shipmentId && pushMsg.shipmentCode) {
        TaskTripController* controller = [[TaskTripController alloc]init];
        controller.shipmentId = pushMsg.shipmentId;
        controller.shipmentCode = pushMsg.shipmentCode;
        [[OwnerViewController sharedInstance] pushViewController:controller animated:YES];
    }
}

@end
