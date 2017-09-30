//
//  LocationInfoViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LocationInfoViewController.h"
#import "AmapLocationService.h"
#import "LocationInfoCell.h"
#import "MapViewController.h"

@interface LocationInfoViewController ()

@property(nonatomic,retain)UILabel* titleLabel;

@end

@implementation LocationInfoViewController

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
    self.titleLabel.text = @"定位点查询";//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
    
    self.navigationItem.rightBarButtonItem = [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_DI_TU target:self action:@selector(rightClick)];
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    self.view.backgroundColor = COLOR_BACKGROUND;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(eventLocationChange:)
//                                                 name:EVENT_LOCATION_CHANGE
//                                               object:nil];
}

//-(void)viewWillDisappear:(BOOL)animated{
//    if (animated) {
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOCATION_CHANGE object:nil];
//    }
//}

//-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOCATION_CHANGE object:nil];
//}

-(void)headerRefresh:(HeaderRefreshHandler)handler{
    int64_t delay = 0.3 * NSEC_PER_SEC;
    __weak __typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue(), ^{//
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf){//界面已经被销毁
            return;
        }
        [strongSelf.tableView clearSource];
        
        NSMutableArray<LocationInfo *>* locationInfos = [AmapLocationService getAllLocationInfos];
        if (locationInfos.count > 0) {
            [strongSelf generateLoctionSource:locationInfos];
        }
        
        handler(locationInfos.count > 0);
    });
}

-(void)generateLoctionSource:(NSMutableArray<LocationInfo *>*)locationInfos{
    NSMutableArray<CellVo*> *sourceData = [NSMutableArray<CellVo*> array];
    SourceVo* svo = [SourceVo initWithParams:sourceData headerHeight:0 headerClass:nil headerData:NULL];
    
    for (LocationInfo * info in locationInfos) {
        [sourceData addObject:
         [CellVo initWithParams:LOCATION_INFO_CELL_HEIGHT cellClass:[LocationInfoCell class] cellData:info]];
    }
    [self.tableView addSource:svo];
}

- (void)eventLocationChange:(NSNotification*)eventData{
//    NSValue * coordinateValue = eventData.object;
//    [self showMapLocationPoint:coordinateValue.MKCoordinateValue];
    [self.tableView clearSource];
    
    NSMutableArray<LocationInfo *>* locationInfos = [AmapLocationService getAllLocationInfos];
    [self generateLoctionSource:locationInfos];
    
    [self.tableView reloadData];
}

-(BOOL)getShowFooter{
    return NO;
}

//进入地图详情页
-(void)rightClick{
//    NSMutableArray<LocationInfo *> * markPoints = [NSMutableArray<LocationInfo *> array];
//    for (NSInteger i = 0;  i < 6; i++) {
//        LocationInfo* markPoint = [[LocationInfo alloc]init];
//        markPoint.locationPoint = [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(23.989631 + i * 2, 112.481018 + i * 0.1)];
//        markPoint.markInfo = ConcatStrings(@"北京大院",@(i));
//        markPoint.detailInfo = ConcatStrings(@"北京大院详情",@(i));
//        [markPoints addObject:markPoint];
//    }
    MapViewController* mapController = [[MapViewController alloc]init];//[MapViewController sharedInstance];
//    mapController.markPoints = markPoints;
    
    mapController.routePoints = [AmapLocationService getAllLocationPoints];
    mapController.mode = MapViewModeRoute;
    [self.navigationController pushViewController:mapController animated:YES];
}

@end
