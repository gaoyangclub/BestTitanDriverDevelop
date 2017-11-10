//
//  TaskHomeController.m
//  BestDriverTitan
//
//  Created by admin on 17/3/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TaskHomeController.h"
#import "MMDrawerController.h"
#import "AppDelegate.h"
#import "TaskViewController.h"
#import "CAPSPageMenu.h"
#import "LoginViewController.h"
#import "ScanHomeController.h"
#import "OwnerViewController.h"

@interface TaskHomeController (){
    CAPSPageMenu* pageMenu;
}

@property(nonatomic,retain)UIView* titleView;
@property (nonatomic,retain) ASDisplayNode* lineBottomY;

@end

@implementation TaskHomeController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(UIView *)titleView{
    if (!_titleView) {
        _titleView = [[UIView alloc]init];
        
        [UICreationUtils createNavigationTitleLabel:20 color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_TASK_HOME superView:_titleView];
    }
    return _titleView;
}

-(ASDisplayNode *)lineBottomY{
    if(!_lineBottomY){
        _lineBottomY = [[ASDisplayNode alloc]init];
        _lineBottomY.backgroundColor = COLOR_LINE;
        _lineBottomY.layerBacked = YES;
        [self.view.layer addSublayer:_lineBottomY.layer];
    }
    return _lineBottomY;
}

-(void)initTitleArea{
//    UIView* temp = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
//    temp.backgroundColor = FlatBrownDark;
//    [self.view addSubview:temp];
    
    if (DEBUG_MODE) {
        self.tabBarController.navigationItem.leftBarButtonItem =
        [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(leftItemClick)];
        self.tabBarController.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SAO_MIAO target:self action:@selector(rightItemClick)];
    }else{
        self.tabBarController.navigationItem.leftBarButtonItem = self.tabBarController.navigationItem.rightBarButtonItem = nil;
    }
    
    self.tabBarController.navigationItem.titleView = self.titleView;
}

-(void)leftItemClick{
    MMDrawerController* drawerController = (MMDrawerController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
    [drawerController toggleDrawerSide:(MMDrawerSideLeft) animated:YES completion:nil];
}

-(void)rightItemClick{
    [[OwnerViewController sharedInstance]pushViewController:[ScanHomeController alloc] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self initPageMenu];
    
    self.lineBottomY.frame = CGRectMake(0, PAGE_MENU_HEIGHT - LINE_WIDTH, self.view.width, LINE_WIDTH);
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                      selector:@selector(eventLoginComplete:)
                                                          name:EVENT_LOGIN_COMPLETE
                                                        object:nil];
}

-(void)initPageMenu{
    
    if (self->pageMenu) {//已经初始化完毕
        return;
//        [self->pageMenu removeFromParentViewController];
    }
    
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    
    //    if (!self->pageMenu) {
    NSArray* titleList = [NSArray arrayWithObjects:
                          [NSArray arrayWithObjects:@"最新任务",@(NO), nil],
                          [NSArray arrayWithObjects:@"全部任务",@(YES), nil],
                          //                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
                          //                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
                          //                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
                          //                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
                          //                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
                          //                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
                          //                              [NSArray arrayWithObjects:@"收藏夹",@(YES), nil],
                          nil];
    
    NSMutableArray<UIViewController*>* controllerArray = [NSMutableArray<UIViewController*> array];
    //        CGFloat listHeight = self.view.frame.size.height - 45;
    for (NSArray* obj in titleList) {
        TaskViewController* controller = [[TaskViewController alloc]init];
        //        controller.autoRefreshHeader = NO;
        controller.title = obj[0];
        BOOL boolValue = [obj[1] boolValue];
        controller.hasHistory = boolValue;
        //            controller.view.frame = (CGRect){
        //                CGPointMake(0,0),
        //                CGSizeMake(self.view.frame.size.width, listHeight)
        //            };
        [controllerArray addObject:controller];
    }
    
    CGFloat itemWidth = (CGRectGetWidth(self.view.bounds) - 10.0) / titleList.count;
    CGFloat minItemWidth = 90;
    if (itemWidth < minItemWidth) {
        itemWidth = minItemWidth;
    }
    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionMenuHeight:@(PAGE_MENU_HEIGHT),
                                 CAPSPageMenuOptionMenuItemWidth:@(itemWidth),
                                 CAPSPageMenuOptionMenuMargin:@(0),
                                 CAPSPageMenuOptionScrollMenuBackgroundColor:[UIColor whiteColor],
                                 CAPSPageMenuOptionViewBackgroundColor:[UIColor clearColor],
                                 CAPSPageMenuOptionSelectionIndicatorColor:COLOR_PRIMARY,
                                 CAPSPageMenuOptionUnselectedMenuItemLabelColor:COLOR_BLACK_ORIGINAL,
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor:COLOR_PRIMARY,
                                 CAPSPageMenuOptionMenuItemFont:[UIFont systemFontOfSize:16],
                                 CAPSPageMenuOptionSelectionIndicatorHeight:@(2),
                                 CAPSPageMenuOptionCenterMenuItems:@(YES),
                                 CAPSPageMenuOptionAddBottomMenuHairline:@(NO)
                                 };
    
    self->pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 0.0, viewWidth, viewHeight) options:parameters];
    //
    //    // Lastly add page menu as subview of base view controller view
    //    // or use pageMenu controller in you view hierachy as desired
    [self.view addSubview:pageMenu.view];
    //    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)eventLoginComplete:(NSNotification*)eventData{
    [self initPageMenu];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOGIN_COMPLETE object:nil];
}

@end
