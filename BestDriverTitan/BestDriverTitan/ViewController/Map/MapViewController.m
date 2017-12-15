//
//  MapViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "CommonUtility.h"
#import "FlatButton.h"
#import "MapNaviViewController.h"
#import "OwnerViewController.h"
#import "HudManager.h"
#import "CustomAnnotationView.h"


@interface DiyPointAnnotation : MAPointAnnotation

@property(nonatomic,assign) BOOL isFirst;
@property(nonatomic,assign) BOOL isLast;
//@property(nonatomic,assign) BOOL isSingle;//只有一个条目数据
@property(nonatomic,assign) NSInteger index;//第几个索引

@end

@implementation DiyPointAnnotation

@end

@interface MapViewController ()<MAMapViewDelegate,AMapSearchDelegate>{
    MAPolyline *commonPolyline;
    NSMutableArray<id<MAAnnotation>>* markAnnotaions;
    BOOL firstUserLocation;//初次定位成功
}

@property(nonatomic,retain)UILabel* titleLabel;

@property (nonatomic, retain) MAMapView *mapView;

@property (nonatomic, retain) MAAnnotationView *userLocationAnnotationView;

@property (nonatomic, retain) UIButton *gpsButton;

@property (nonatomic, retain) UIView *zoomPannelView;

@property(nonatomic,retain)AMapSearchAPI* searchAPI;

@end

static MapViewController* instance;

@implementation MapViewController

+(instancetype)sharedInstance {
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UICreationUtils createNavigationTitleLabel:SIZE_NAVI_TITLE color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_TASK_TRIP superView:nil];
    }
    return _titleLabel;
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:SIZE_LEFT_BACK_ICON] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.titleLabel.text = @"地图";//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
}

-(AMapSearchAPI *)searchAPI{
    if (!_searchAPI) {
        _searchAPI = [[AMapSearchAPI alloc]init];
        _searchAPI.delegate = self;
    }
    return _searchAPI;
}

//返回上层
-(void)leftClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(MAMapView *)mapView{
    if (!_mapView) {
        _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];//[[MAMapView alloc]init];
        _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _mapView.delegate = self;
        [self.view addSubview:_mapView];
        
        _mapView.showsScale = YES;
        
        _mapView.showsUserLocation = YES;
        _mapView.userLocation.title = @"您的位置在这里";
    }
    return _mapView;
}

-(UIButton *)gpsButton{
    if(!_gpsButton){
        _gpsButton = [self makeGPSButtonView];
//        _gpsButton.center = CGPointMake(CGRectGetMidX(self.gpsButton.bounds) + 10,
//                                            self.view.bounds.size.height -  CGRectGetMidY(self.gpsButton.bounds) - 20);
        [self.view addSubview:_gpsButton];
        _gpsButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
    }
    return _gpsButton;
}

- (UIButton *)makeGPSButtonView {
    UIButton *ret = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    ret.backgroundColor = [UIColor whiteColor];
    ret.layer.cornerRadius = 4;
    
    [ret setImage:[UIImage imageNamed:@"gpsStat1"] forState:UIControlStateNormal];
    [ret addTarget:self action:@selector(gpsAction) forControlEvents:UIControlEventTouchUpInside];
    
    return ret;
}

-(UIView *)zoomPannelView{
    if(!_zoomPannelView){
        _zoomPannelView = [self makeZoomPannelView];
        _zoomPannelView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        [self.view addSubview:_zoomPannelView];
    }
    return _zoomPannelView;
}

- (UIView *)makeZoomPannelView
{
    UIView *ret = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 53, 98)];
    
    UIButton *incBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 53, 49)];
    [incBtn setImage:[UIImage imageNamed:@"increase"] forState:UIControlStateNormal];
    [incBtn sizeToFit];
    [incBtn addTarget:self action:@selector(zoomPlusAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *decBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 49, 53, 49)];
    [decBtn setImage:[UIImage imageNamed:@"decrease"] forState:UIControlStateNormal];
    [decBtn sizeToFit];
    [decBtn addTarget:self action:@selector(zoomMinusAction) forControlEvents:UIControlEventTouchUpInside];
    
    [ret addSubview:incBtn];
    [ret addSubview:decBtn];
    
    return ret;
}


#pragma mark - Action Handlers
- (void)zoomPlusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom + 1) animated:YES];
//    self.mapView.showsScale = YES;
}

- (void)zoomMinusAction
{
    CGFloat oldZoom = self.mapView.zoomLevel;
    [self.mapView setZoomLevel:(oldZoom - 1) animated:YES];
//    self.mapView.showsScale = NO;
}

- (void)gpsAction {
    if(self.mapView.userLocation.updating && self.mapView.userLocation.location) {
        [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
        [self.gpsButton setSelected:YES];
    }
}

-(void)viewDidLayoutSubviews{
    self.mapView.frame = self.view.bounds;
    
    self.zoomPannelView.maxX = self.view.width - 10;
    self.zoomPannelView.maxY = self.view.height - 10;
    
    self.gpsButton.x = self.view.x + 10;
    self.gpsButton.maxY = self.view.height - 20;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
    if (self.mode == MapViewModeNormal) {
        self.mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    }else if(self.mode == MapViewModeMark){
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self showMarkPoints];
    }else if(self.mode == MapViewModeRoute){
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self showRoutePoints];
    }
}

//static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
//static const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
static const NSInteger RoutePlanningPaddingEdge                    = 50;

-(void)showRoutePoints{
    if (self->commonPolyline) {
        [self.mapView removeOverlay:self->commonPolyline];
    }
    if (self.routePoints) {//开始划线
        NSInteger count = self.routePoints.count;
        //构造折线数据对象
        CLLocationCoordinate2D commonPolylineCoords[count];
        for (NSInteger i = 0; i < count; i++) {
            LocationInfo* info = self.routePoints[i];
            if(info.markType == LocationMarkTypePoint){//坐标点形式的展示
                CLLocationCoordinate2D coordinate = info.locationPoint.MKCoordinateValue;
                commonPolylineCoords[i].longitude = coordinate.longitude;
                commonPolylineCoords[i].latitude = coordinate.latitude;
            }
        }
//        //构造折线对象
        self->commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:count];
        //在地图上添加折线对象
        [self.mapView addOverlay:commonPolyline];
        [self.mapView setVisibleMapRect:commonPolyline.boundingMapRect
                            edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                               animated:YES];
    }
}

-(void)showMarkPoints{
    self->markAnnotaions = [NSMutableArray<id<MAAnnotation>> array];
    NSInteger count = self.markPoints.count;
    
    for (NSInteger i = 0 ; i < count; i++) {
        LocationInfo* markPoint = self.markPoints[i];
        CLLocationCoordinate2D coordinate = markPoint.locationPoint.MKCoordinateValue;
        if (coordinate.latitude && coordinate.longitude) {
            [self createDiyPointAnnotationByIndex:i];
        }else{
            AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
            geo.address = markPoint.detailInfo;
            [self.searchAPI AMapGeocodeSearch:geo];
        }
    }
//    [self->markAnnotaions addObject:self.mapView.userLocation];
    /* 缩放地图使其适应markAnnotaions的展示. */
    [self.mapView setVisibleMapRect:[CommonUtility minMapRectForAnnotations:self->markAnnotaions]
                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                           animated:YES];
}

-(void)createDiyPointAnnotationByIndex:(NSInteger)index{
    if (index < self.markPoints.count) {
        LocationInfo* markPoint = self.markPoints[index];
        
        DiyPointAnnotation *pointAnnotation = [[DiyPointAnnotation alloc] init];
        CLLocationCoordinate2D coordinate = markPoint.locationPoint.MKCoordinateValue;
        pointAnnotation.coordinate = coordinate;
        
        pointAnnotation.title = markPoint.markInfo;
        pointAnnotation.subtitle = markPoint.detailInfo;//ConcatStrings(@"xxxx大街",@(i),@"号");
        pointAnnotation.isFirst = index == 0;
        pointAnnotation.isLast = index == self.markPoints.count - 1;
        pointAnnotation.index = index;
        
        [_mapView addAnnotation:pointAnnotation];
        [self->markAnnotaions addObject:pointAnnotation];
    }
}

-(NSInteger)getMarkPointIndexByAddress:(NSString*)detailInfo{
    NSInteger count = self.markPoints.count;
    for (NSInteger i = 0; i < count; i++) {
        LocationInfo* markPoint = self.markPoints[i];
        if (markPoint.detailInfo && [markPoint.detailInfo isEqualToString:detailInfo]) {//搜索到了
            CLLocationCoordinate2D coordinate = markPoint.locationPoint.MKCoordinateValue;
            if (!coordinate.latitude || !coordinate.longitude) {
                return i;
            }
        }
    }
    return -1;
}

#pragma AMapSearchDelegate
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if (response.geocodes.count == 0)
    {
        [HudManager showToast:@"该地址逆地理编码不存在，请检查该地址描述是否准确!"];
        return;
    }
    //解析response获取地理信息，具体解析见 Demo
    AMapGeocode* geoCode = response.geocodes.firstObject;
    if (geoCode.location) {
        NSInteger index = [self getMarkPointIndexByAddress:request.address];
        if (index >= 0) {
            LocationInfo* markPoint = self.markPoints[index];
            markPoint.locationPoint = [NSValue valueWithMKCoordinate:CLLocationCoordinate2DMake(geoCode.location.latitude, geoCode.location.longitude)];
            [self createDiyPointAnnotationByIndex:index];
            /* 缩放地图使其适应markAnnotaions的展示. */
            [self.mapView setVisibleMapRect:[CommonUtility minMapRectForAnnotations:self->markAnnotaions]
                                edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                                   animated:YES];
        }
    }
}

#pragma mark - mapview delegate
#pragma mark - MAMapViewDelegate
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    /* 自定义定位精度对应的MACircleView. */
    else if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        accuracyCircleRenderer.lineWidth    = 2.f;
        accuracyCircleRenderer.strokeColor  = [UIColor lightGrayColor];
        accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return accuracyCircleRenderer;
    }
    
    return nil;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    /* 自定义userLocation对应的annotationView. */
    if ([annotation isKindOfClass:[MAUserLocation class]])
    {
        static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:userLocationStyleReuseIndetifier];
        }
        
        annotationView.image = [UIImage imageNamed:@"userPosition"];
        
        self.userLocationAnnotationView = annotationView;
        
        return annotationView;
    }
    else if ([annotation isKindOfClass:[DiyPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        CustomAnnotationView*annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout = YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        
        FlatButton* rightButton = [[FlatButton alloc]init];
        rightButton.frame = CGRectMake(0, 0, 30, 50);
        rightButton.titleFontName = ICON_FONT_NAME;
        rightButton.title = ICON_DAO_HANG;
        rightButton.titleColor = FlatSkyBlue;
        rightButton.titleSize = 28;
        rightButton.fillColor = [UIColor clearColor];
        
        annotationView.rightCalloutAccessoryView = rightButton;
        
//        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
        DiyPointAnnotation* diyAnnotation = (DiyPointAnnotation*)annotation;
        
        LocationInfo* locationInfo = self.markPoints[diyAnnotation.index];
        UIColor* completeColor;
        if (locationInfo.markType == LocationMarkTypeDebug) {//已完成
            completeColor = FlatGrayDark;
        }
        if(diyAnnotation.isFirst){
            annotationView.title = @"起";
            annotationView.titleSize = 14;
            annotationView.backColor = completeColor ? completeColor : FlatSkyBlue;
//            annotationView.image = [UIImage imageNamed:@"default_navi_route_startpoint"];
        }else if(diyAnnotation.isLast){
//            annotationView.image = [UIImage imageNamed:@"default_navi_route_endpoint"];
            annotationView.title = @"终";
            annotationView.titleSize = 14;
            annotationView.backColor = completeColor ? completeColor : FlatRed;
        }else{
//            annotationView.image = [UIImage imageNamed:@"default_navi_route_waypoint"];
            annotationView.title = [NSString stringWithFormat:@"%ld",(long)(diyAnnotation.index + 1)];
            annotationView.titleSize = 18;
            annotationView.backColor = completeColor ? completeColor : FlatGreen;
        }
//        annotationView.image = [UIImage imageNamed:@"restaurant"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        annotationView.centerOffset = CGPointMake(0, -18);
        
        return annotationView;
    }
    
    return nil;
}

-(void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    id<MAAnnotation> annotation = view.annotation;
    MapNaviViewController* naviController = [[MapNaviViewController alloc]init];
    //            MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    naviController.endLongitude = annotation.coordinate.longitude;
    naviController.endLatitude = annotation.coordinate.latitude;
    naviController.endAddress = annotation.subtitle;
    [[OwnerViewController sharedInstance]pushViewController:naviController animated:YES];
}

//-(UIControl*)getNaviButton{
//    UIControl* naviButton = [[UIControl alloc]init];
//    naviButton.frame = CGRectMake(0,0,50,50);
////    naviButton.width = 50;
////    naviButton.height = 80;
//    
//    ASTextNode* naviIcon = [[ASTextNode alloc]init];
//    naviIcon.layerBacked = YES;
//    [naviButton.layer addSublayer:naviIcon.layer];
//    naviIcon.attributedString = [NSString simpleAttributedString:ICON_FONT_NAME color:COLOR_YI_WAN_CHENG size:26 content:ICON_DAO_HANG];
//    naviIcon.size = [naviIcon measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    
//    ASTextNode* naviLabel = [[ASTextNode alloc]init];
//    naviLabel.layerBacked = YES;
//    [naviButton.layer addSublayer:naviLabel.layer];
//    naviLabel.attributedString = [NSString simpleAttributedString:FlatGray  size:12 content:@"去这里"];
//    naviLabel.size = [naviLabel measure:CGSizeMake(FLT_MAX, FLT_MAX)];
//    
//    naviIcon.centerX = naviLabel.centerX = naviButton.width / 2.;
//    
//    naviIcon.y = (naviButton.height - naviIcon.height - naviLabel.height) / 2.;
//    naviLabel.y = naviIcon.maxY;
//    
////    self.naviLabel.frame = (CGRect){ CGPointMake((naviWidth - naviLabelSize.width) / 2.,naviIconY + naviIconSize.height),naviLabelSize};
//    return naviButton;
//}
//
//-(void)clickNaviButton{
//    NSLog(@"点击rightCalloutAccessoryView");
//}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (self.userLocationAnnotationView != nil)//!updatingLocation &&
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
            
        }];
        if (!firstUserLocation && self->markAnnotaions) {
            [self->markAnnotaions addObject:self.mapView.userLocation];
            /* 缩放地图使其适应markAnnotaions的展示. */
            [self.mapView setVisibleMapRect:[CommonUtility minMapRectForAnnotations:self->markAnnotaions]
                                edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                                   animated:YES];
        }
        firstUserLocation = YES;
    }
}

@end
