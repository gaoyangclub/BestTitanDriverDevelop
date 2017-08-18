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
    self.tabBarController.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(leftItemClick)];
    
    self.tabBarController.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SAO_MIAO target:self action:@selector(rightItemClick)];
    
    self.tabBarController.navigationItem.titleView = self.titleView;
}

-(void)leftItemClick{
    MMDrawerController* drawerController = (MMDrawerController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
    [drawerController toggleDrawerSide:(MMDrawerSideLeft) animated:YES completion:nil];
}

-(void)rightItemClick{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat viewHeight = self.view.frame.size.height;
    
//    if (!self->pageMenu) {
        NSArray* titleList = [NSArray arrayWithObjects:
                              [NSArray arrayWithObjects:@"最近任务",@(NO), nil],
                              [NSArray arrayWithObjects:@"所有任务",@(YES), nil],
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
    
    self.lineBottomY.frame = CGRectMake(0, PAGE_MENU_HEIGHT - LINE_WIDTH, viewWidth, LINE_WIDTH);
    
    
//    var controllerArray:[UIViewController] = []
////    for title in titleList{
////        let controller:DetailsPageInfoController = DetailsPageInfoController()
////        controller.title = title.0
////        controller.formKey = title.1
////        controller.delegate = self
////        controllerArray.append(controller)
////    }
//    
//    let itemWidth = self.view.frame.width / 2 - 10
//    let parameters: [CAPSPageMenuOption] = [
//                                            .MenuHeight(45),
//                                            .MenuItemWidth(itemWidth),
//                                            .MenuMargin(0),
//                                            //                CAPSPageMenuOption.MenuItemWidthBasedOnTitleTextWidth(true),
//                                            .ScrollMenuBackgroundColor(UIColor.clearColor()),
//                                            .ViewBackgroundColor(UIColor.clearColor()),
//                                            CAPSPageMenuOption.SelectionIndicatorColor(BestUtils.deputyColor),
//                                            //            CAPSPageMenuOption.MenuItemSeparatorColor(UIColor.orangeColor()),
//                                            //            .BottomMenuHairlineColor(UIColor.grayColor()),
//                                            //            .UseMenuLikeSegmentedControl(true),
//                                            //            .MenuItemSeparatorPercentageHeight(0.5),
//                                            .UnselectedMenuItemLabelColor(UICreaterUtils.colorBlack),
//                                            .SelectedMenuItemLabelColor(BestUtils.deputyColor),
//                                            //                CAPSPageMenuOption.MenuItemSeparatorUnderline(true),//下划线
//                                            .MenuItemFont(UIFont.systemFontOfSize(16)),//,weight:1.2
//                                            .SelectionIndicatorHeight(2),
//                                            .CenterMenuItems(true),
//                                            .AddBottomMenuHairline(false)
//                                            ]
//    pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame:CGRectMake(0,0,self.view.frame.width,0),pageMenuOptions: parameters)
//    // frame: CGRectMake(0.0, 0.0, self.view.frame.width, self.view.frame.height - DetailsPageHomeController.BOTTOM_HEIGHT)
//    //        pageMenu.currentPageIndex = selectedIndex
//    //        pageMenu.moveToPage(selectedIndex)
//    self.view.addSubview(pageMenu!.view)
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
