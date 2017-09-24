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

@interface MapViewController ()<MAMapViewDelegate>{
    MAPolyline *commonPolyline;
}

@property(nonatomic,retain)UILabel* titleLabel;

@property (nonatomic, retain) MAMapView *mapView;

@property (nonatomic, retain) MAAnnotationView *userLocationAnnotationView;

@property (nonatomic, retain) UIButton *gpsButton;

@property (nonatomic, retain) UIView *zoomPannelView;

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
        _titleLabel = [UICreationUtils createNavigationTitleLabel:20 color:COLOR_NAVI_TITLE text:NAVIGATION_TITLE_TASK_TRIP superView:nil];
    }
    return _titleLabel;
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.titleLabel.text = @"地图";//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
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
//        [self showMarks];
    }else if(self.mode == MapViewModeRoute){
        self.mapView.userTrackingMode = MAUserTrackingModeFollow;
        [self showRoutePoints];
    }
}

//static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
//static const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
static const NSInteger RoutePlanningPaddingEdge                    = 50;

-(void)viewDidAppear:(BOOL)animated{
    NSInteger count = 5;
    
    CLLocationCoordinate2D commonPolylineCoords[count];
    commonPolylineCoords[0] = CLLocationCoordinate2DMake(24.2753400000,100.1654600000);
    commonPolylineCoords[1] = CLLocationCoordinate2DMake(23.2753400000,115.2854600000);
    commonPolylineCoords[2] = CLLocationCoordinate2DMake(26.2753400000,114.3654600000);
    commonPolylineCoords[3] = CLLocationCoordinate2DMake(23.3753400000,116.9854600000);
    commonPolylineCoords[4] = CLLocationCoordinate2DMake(22.2753400000,113.1654600000);
    
    NSMutableArray* annotaions = [NSMutableArray array];
    for (NSInteger i = 0 ; i < count; i++) {
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate =  commonPolylineCoords[i];
        
        pointAnnotation.title = @"香港区政府";
        pointAnnotation.subtitle = ConcatStrings(@"xxxx大街",@(i),@"号");
        
        [_mapView addAnnotation:pointAnnotation];
        [annotaions addObject:pointAnnotation];
    }
    [annotaions addObject:self.mapView.userLocation];
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView setVisibleMapRect:[CommonUtility minMapRectForAnnotations:annotaions]
                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                           animated:YES];
}

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
        [self.mapView setVisibleMapRect:commonPolyline.boundingMapRect animated:YES];
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
    else if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout = YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
        annotationView.image = [UIImage imageNamed:@"default_navi_route_waypoint"];
        
//        annotationView.image = [UIImage imageNamed:@"restaurant"];
        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -18);
        
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (self.userLocationAnnotationView != nil)//!updatingLocation &&
    {
        [UIView animateWithDuration:0.1 animations:^{
            
            double degree = userLocation.heading.trueHeading - self.mapView.rotationDegree;
            self.userLocationAnnotationView.transform = CGAffineTransformMakeRotation(degree * M_PI / 180.f );
            
        }];
    }
}

@end
