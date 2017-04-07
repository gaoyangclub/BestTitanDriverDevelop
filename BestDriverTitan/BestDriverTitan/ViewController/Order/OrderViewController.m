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
@property(nonatomic,retain)ASTextNode* iconAddress;//起点图标
@property(nonatomic,retain)ASTextNode* textAddress;//起点图标

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
    self.navigationItem.leftBarButtonItem = [UICreationUtils createNavigationLeftButtonItem:[UIColor whiteColor] target:self action:@selector(leftClick)];
    
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
    CGFloat margin = 5;
    CGFloat squareHeight = TASK_TRIP_SECTION_TOP_HEIGHT - margin;
    
    self.addressView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), squareHeight);
    
    CGFloat tabHeight = CGRectGetHeight(self.view.bounds) - squareHeight;
    self.tabView.frame = CGRectMake(0, squareHeight + margin, ORDER_TAB_WIDTH, tabHeight - margin);
    
    return CGRectMake(ORDER_TAB_WIDTH + margin, squareHeight + margin, CGRectGetWidth(self.view.bounds) - ORDER_TAB_WIDTH + margin * 2, tabHeight - margin);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.sectionGap = 5;
    self.tabView.tabDelegate = self;
//    [self.tabView setTotalCount:15];
    
    CGFloat sectionWidth = self.view.bounds.size.width;
    CGFloat leftpadding = 10;
    CGFloat squareHeight = TASK_TRIP_SECTION_TOP_HEIGHT - 5;
    self.iconAddress.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:30 content:ICON_JU_LI];
    CGSize iconStartSize = [self.iconAddress measure:CGSizeMake(FLT_MAX, FLT_MAX)];
    self.iconAddress.frame = (CGRect){ CGPointMake(leftpadding,(squareHeight - iconStartSize.height) / 2.),iconStartSize};
    
    NSString* address = @"上海上海市松江区上海上海市松江区大港镇松镇公路1339号宝湾物流112号库";
    NSMutableAttributedString* textString = (NSMutableAttributedString*)[NSString simpleAttributedString:FlatBlack size:14 content:address];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc]init];
    style.alignment = NSTextAlignmentLeft;
    [textString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, address.length)];
    self.textAddress.attributedString = textString;
    
    CGFloat maxStartWidth = sectionWidth - leftpadding * 2 - iconStartSize.width;
    CGSize textStartSize = [self.textAddress measure:CGSizeMake(maxStartWidth, FLT_MAX)];
    self.textAddress.frame = (CGRect){ CGPointMake(leftpadding + iconStartSize.width + leftpadding / 2.,(squareHeight - textStartSize.height) / 2.),textStartSize};
    
    
}

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
        int count = (arc4random() % 10) + 5; //生成3-10范围的随机数
    
        [self.tableView clearSource];
        
        for (NSInteger i = 0; i < count; i++) {
            NSMutableArray* sourceData = [NSMutableArray<CellVo*> array];
            [sourceData addObject:[CellVo initWithParams:TASK_VIEW_CELL_HEIGHT cellClass:[OrderNormalCell class] cellData:@"数据"]];
            
            SourceVo* svo = [SourceVo initWithParams:sourceData headerHeight:TASK_VIEW_SECTION_HEIGHT headerClass:[OrderViewSection class] headerData:NULL];
            [self.tableView addSource:svo];
        }
        [self.tabView setTotalCount:count];
        
        handler(count > 0);
    });
}

-(void)didScrollToRow:(NSIndexPath *)indexPath{
    if (!isClickTab) {//非点击左侧tab按钮才可以触发
        [self.tabView setSelectedIndex:indexPath.section];
    }
}

-(void)didEndScrollingAnimation{
    isClickTab = NO;
}

-(void)didSelectIndex:(NSInteger)index{
    isClickTab = YES;
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
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
