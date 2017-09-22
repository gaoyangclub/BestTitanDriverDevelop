//
//  OrderDetailController.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderNormalCell.h"
#import "OrderEditModelView.h"

@interface OrderDetailController ()//<OrderEditModelDelegate>

@property(nonatomic,retain) UILabel* titleLabel;//大标题栏
@property(nonatomic,retain) ASDisplayNode * orderTitleArea;
@property(nonatomic,retain) ASTextNode* orderCodeLabel;
@property(nonatomic,retain) ASTextNode* customCodeLabel;//地址信息栏区域
//@property(nonatomic,retain) ASTextNode* textAddress;//起点图标

@property (nonatomic,retain) ASDisplayNode* orderBottomY;

@property(nonatomic,retain) ASTextNode* orderIcon;//订单图标

@property(nonatomic,retain) ASTextNode* shipUintTotalLabel;//预计(实际)提送货量

@end

@implementation OrderDetailController

-(ASDisplayNode *)orderTitleArea{
    if (!_orderTitleArea) {
        _orderTitleArea = [[ASDisplayNode alloc]init];
        _orderTitleArea.layerBacked = YES;
        _orderTitleArea.backgroundColor = [UIColor whiteColor];
        [self.view.layer addSublayer:_orderTitleArea.layer];
    }
    return _orderTitleArea;
}

-(ASTextNode *)orderCodeLabel{
    if (!_orderCodeLabel) {
        _orderCodeLabel = [[ASTextNode alloc]init];
        _orderCodeLabel.layerBacked = YES;
        [self.orderTitleArea addSubnode:_orderCodeLabel];
    }
    return _orderCodeLabel;
}

-(ASTextNode *)customCodeLabel{
    if (!_customCodeLabel) {
        _customCodeLabel = [[ASTextNode alloc]init];
        _customCodeLabel.layerBacked = YES;
        [self.orderTitleArea addSubnode:_customCodeLabel];
    }
    return _customCodeLabel;
}

-(ASDisplayNode *)orderBottomY{
    if(!_orderBottomY){
        _orderBottomY = [[ASDisplayNode alloc]init];
        _orderBottomY.backgroundColor = COLOR_LINE;
        _orderBottomY.layerBacked = YES;
        [self.orderTitleArea addSubnode:_orderBottomY];
    }
    return _orderBottomY;
}

-(ASTextNode *)orderIcon{
    if (!_orderIcon) {
        _orderIcon = [[ASTextNode alloc]init];
        _orderIcon.layerBacked = YES;
        [self.orderTitleArea addSubnode:_orderIcon];
    }
    return _orderIcon;
}

-(ASTextNode *)shipUintTotalLabel{
    if (!_shipUintTotalLabel) {
        _shipUintTotalLabel = [[ASTextNode alloc]init];
        _shipUintTotalLabel.layerBacked = YES;
        [self.orderTitleArea.layer addSublayer:_shipUintTotalLabel.layer];
    }
    return _shipUintTotalLabel;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_TASK_TRIP superView:nil];
    }
    return _titleLabel;
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    
    self.titleLabel.text = NAVIGATION_TITLE_ORDER_DETAIL;//self.taskBean.orderBaseCode;//标题显示SO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
}

-(CGRect)getTableViewFrame{
    CGFloat margin = 4;
    CGFloat squareHeight = ORDER_VIEW_SECTION_HEIGHT;
    
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
//    CGFloat viewHeight = CGRectGetHeight(self.view.bounds);
    
    self.orderTitleArea.frame = CGRectMake(0, 0, viewWidth, squareHeight);
    
    CGFloat buttonAreaHeight = 0;//
    
    CGFloat tabHeight = CGRectGetHeight(self.view.bounds) - squareHeight;
    return CGRectMake(margin, squareHeight + margin, viewWidth - margin * 2, tabHeight - margin - buttonAreaHeight);
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor* iconColor;
    if([self.taskBean hasReport]){
        iconColor = COLOR_YI_WAN_CHENG;
    }else{
        iconColor = COLOR_DAI_WAN_CHENG;
    }
    CGFloat sectionWidth = self.view.width;
    CGFloat leftpadding = 10;
    CGFloat topHeight = ORDER_VIEW_SECTION_HEIGHT * 2 / 3;
    self.orderIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:iconColor size:24 content:ICON_DING_DAN];
    CGSize iconSize = [self.orderIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.orderIcon.frame = (CGRect){ CGPointMake(leftpadding,(topHeight - iconSize.height) / 2.),iconSize};
    
    self.orderCodeLabel.attributedString = [NSString simpleAttributedString:COLOR_BLACK_ORIGINAL size:14 content:self.taskBean.orderBaseCode];
    CGSize orderCodeSize = [self.orderCodeLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.orderCodeLabel.frame = (CGRect){CGPointMake(self.orderIcon.frame.origin.x + self.orderIcon.frame.size.width + 3, topHeight / 2. - 15),orderCodeSize};
    
    NSString* customer = ConcatStrings(@"客户单号",self.taskBean.customCode);
    self.customCodeLabel.attributedString = [NSString simpleAttributedString:[UIColor flatGrayColor] size:12 content:customer];
    CGSize customCodeSize = [self.customCodeLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.customCodeLabel.frame = (CGRect){CGPointMake(self.orderIcon.frame.origin.x + self.orderIcon.frame.size.width + 3, topHeight / 2.),customCodeSize};
    
    CGFloat bottomY = topHeight;
//    CGFloat bottomHeight = ORDER_VIEW_SECTION_HEIGHT - topHeight;
    self.shipUintTotalLabel.attributedString = [self generateShipUnitString:12 color:FlatOrange activityTypeLabel:[Config getActivityTypeName:self.taskBean.activityDefinitionCode] expectedCount:[self.taskBean.expectedPackageCount integerValue] actualCount:self.taskBean.actualPackageCount];
    self.shipUintTotalLabel.size = [self.shipUintTotalLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.shipUintTotalLabel.y = bottomY;
    self.shipUintTotalLabel.x = leftpadding;
    
    self.orderBottomY.frame = CGRectMake(0, ORDER_VIEW_SECTION_HEIGHT - LINE_WIDTH, sectionWidth, LINE_WIDTH);
    
    [self initTableData];
}

-(NSAttributedString *)generateShipUnitString:(CGFloat)size color:(UIColor*)color activityTypeLabel:(NSString*)activityTypeLabel expectedCount:(NSInteger)expectedCount actualCount:(NSInteger)actualCount{
    const NSString* gapString = @" ";
    const NSString* expecteTailString = @" 箱 | ";
    NSString* expectedString = NULL;
    NSString* expectedTag = NULL;
    if (expectedCount) {
        expectedTag = ConcatStrings(@"预计",activityTypeLabel,gapString);
        expectedString = ConcatStrings(expectedTag,@(expectedCount),expecteTailString);
    }
    NSString* actualString = NULL;
    NSString* actualTag = NULL;
    if (actualCount) {
        actualTag = ConcatStrings(@"实际",activityTypeLabel,gapString);
        actualString = ConcatStrings(actualTag,@(actualCount),@" 箱");
    }
    NSString* context = ConcatStrings(expectedString ? expectedString : @"", actualString ? actualString : @"");
    NSMutableAttributedString* attrString = [[NSMutableAttributedString alloc]initWithString:context];
    [attrString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(0, context.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:FlatGray range:NSMakeRange(0, context.length)];
    NSUInteger loc = 0;
    if (expectedCount) {
        loc += expectedTag.length;
        NSUInteger pickupLength = [NSString stringWithFormat:@"%li", (long)expectedCount].length;
        [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(loc, pickupLength)];
        loc += pickupLength + expecteTailString.length;
    }
    if (actualCount) {
        loc += actualTag.length;
        NSUInteger deliverLength = [NSString stringWithFormat:@"%li", (long)actualCount].length;
        [attrString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(loc, deliverLength)];
    }
    return attrString;
}

-(void)initTableData{
    NSMutableArray* sourceData = [NSMutableArray<CellVo*> array];
    for (ShipmentActivityShipUnitBean* shipUnitBean in self.taskBean.shipUnits) {
//        for (NSInteger i = 0; i < 100; i++) {
            [sourceData addObject:[CellVo initWithParams:ORDER_VIEW_CELL_HEIGHT cellClass:[OrderNormalCell class] cellData:shipUnitBean]];
//        }
    }
    SourceVo* svo = [SourceVo initWithParams:sourceData headerHeight:0 headerClass:nil headerData:nil];
    [self.tableView addSource:svo];
    
    [self.tableView reloadData];
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

#pragma OrderEditModelDelegate
//-(void)orderEdited:(NSIndexPath *)indexPath{
//    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];//这行数据刷新
//}

//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

-(BOOL)getShowHeader{
    return NO;
}

-(BOOL)getShowFooter{
    return NO;
}

@end
