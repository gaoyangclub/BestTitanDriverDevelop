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

@interface TaskHomeController (){
    CAPSPageMenu* pageMenu;
}

@property(nonatomic,retain)UIView* titleView;

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
        
        [UICreationUtils createNavigationTitleLabel:20 color:[UIColor whiteColor] text:NAVIGATION_TITLE_TASK_HOME superView:_titleView];
    }
    return _titleView;
}

-(void)initTitleArea{
    self.tabBarController.navigationItem.leftBarButtonItem = [UICreationUtils createNavigationLeftButtonItem:[UIColor whiteColor] target:self action:@selector(rightItemClick)];
    
    self.tabBarController.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:[UIColor whiteColor] font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(rightItemClick)];
    
    self.tabBarController.navigationItem.titleView = self.titleView;
}

-(void)rightItemClick{
    MMDrawerController* drawerController = (MMDrawerController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
    [drawerController toggleDrawerSide:(MMDrawerSideRight) animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    if (!self->pageMenu) {
        NSArray* titleList = [NSArray arrayWithObjects:
                              [NSArray arrayWithObjects:@"最近三天",@(NO), nil],
                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
//                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
//                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
//                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
//                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
//                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
//                              [NSArray arrayWithObjects:@"历史任务",@(YES), nil],
                              [NSArray arrayWithObjects:@"收藏夹",@(YES), nil],
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
                                     CAPSPageMenuOptionUnselectedMenuItemLabelColor:FlatBlack,
                                     CAPSPageMenuOptionSelectedMenuItemLabelColor:COLOR_PRIMARY,
                                     CAPSPageMenuOptionMenuItemFont:[UIFont systemFontOfSize:16],
                                     CAPSPageMenuOptionSelectionIndicatorHeight:@(2),
                                     CAPSPageMenuOptionCenterMenuItems:@(YES),
                                     CAPSPageMenuOptionAddBottomMenuHairline:@(NO)
                                     };
        
        self->pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
        //
        //    // Lastly add page menu as subview of base view controller view
        //    // or use pageMenu controller in you view hierachy as desired
        [self.view addSubview:pageMenu.view];
//    }
    
    
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
