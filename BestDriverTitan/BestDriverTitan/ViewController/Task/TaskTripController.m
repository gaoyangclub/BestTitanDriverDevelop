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
#import "RootNavigationController.h"

@interface TestTableViewCell2 : MJTableViewCell

@end

@implementation TestTableViewCell2

-(void)showSubviews{
    //    self.backgroundColor = [UIColor magentaColor];
    
    self.textLabel.text = (NSString*)self.data;
}

@end

@interface TaskTripController (){
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
    self.navigationItem.leftBarButtonItem = [UICreationUtils createNavigationLeftButtonItem:[UIColor whiteColor] target:self action:@selector(leftClick)];
    
//    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(rightItemClick)];
    
    self.titleLabel.text = @"TO12451516161";//标题显示TO号
    [self.titleLabel sizeToFit];
//    self.titleView.bounds = titleLabel.bounds;
    self.navigationItem.titleView = self.titleLabel;//self.titleView;
    
//    titleLabel.center = self.titleView.center;
    
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    int64_t delay = 1.0 * NSEC_PER_SEC;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        [self.tableView clearSource];
        
        NSMutableArray<CellVo*>* sourceData = [NSMutableArray<CellVo*> array];
        int count = 1;//(arc4random() % 18) + 30; //生成3-10范围的随机数
        for (NSUInteger i = 0; i < count; i++) {
            //            [self.sourceData addObject:[NSString stringWithFormat:@"数据: %lu",i]];
            
            [sourceData addObject:
             [CellVo initWithParams:TASK_TRIP_CELL_HEIGHT cellClass:[TaskTripCell class] cellData:[NSString stringWithFormat:@"测试数据: %lu",i]]];
        }
        [self.tableView addSource:[SourceVo initWithParams:sourceData headerHeight:TASK_TRIP_SECTION_HEIGHT headerClass:[TaskTripSection class] headerData:NULL]];
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

-(CGRect)getTableViewFrame{
    CGFloat viewWidth = CGRectGetWidth(self.view.bounds);
    CGFloat viewHeight = CGRectGetHeight(self.view.bounds);
    
    CGFloat padding = 5;
    CGFloat tableHeight = viewHeight - SUBMIT_BUTTON_HEIGHT - padding * 2;
    
    return CGRectMake(0, 0, viewWidth, tableHeight);
}


-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventOccurred:)
                                                 name:EVENT_ADDRESS_SELECT
                                               object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_ADDRESS_SELECT object:nil];
}

- (void)eventOccurred:(NSNotification*)eventData{
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
    UIViewController* controller = [[OrderViewController alloc]init];
    [[RootNavigationController sharedInstance] pushViewController:controller animated:YES];
}

-(UIButton *)attachmentButton{
    if (!_attachmentButton) {
        _attachmentButton = [UIButton buttonWithType:UIButtonTypeSystem];
        //        [_submitButton setShowTouch:YES];
        
        _attachmentButton.backgroundColor = [UIColor whiteColor];
        [_attachmentButton setTitle:ConcatStrings(ICON_HUI_DAN,@"  ",@"回单") forState:UIControlStateNormal];
        [_attachmentButton setTitleColor:COLOR_PRIMARY forState:UIControlStateNormal];
        
        _attachmentButton.underlineNone = YES;
        
        _attachmentButton.layer.borderColor = COLOR_PRIMARY.CGColor;
        _attachmentButton.layer.borderWidth = 1;
        
        _attachmentButton.titleLabel.font = [UIFont fontWithName:ICON_FONT_NAME size:16];
        
        [self.view addSubview:_attachmentButton];
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
    [[PopAnimateManager sharedInstance]startClickAnimation:sender];
    
}


@end
