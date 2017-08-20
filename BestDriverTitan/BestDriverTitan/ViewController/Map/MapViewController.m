//
//  MapViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MapViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface MapViewController ()<MAMapViewDelegate>{
    BOOL hasLocationPoint;
    MAPolyline *commonPolyline;
}

@property(nonatomic,retain)UILabel* titleLabel;

@property (nonatomic, retain) MAMapView *mapView;
@property (nonatomic, retain) MAPointAnnotation *pointAnnotaiton;

@property (nonatomic, strong) MAAnnotationView *userLocationAnnotationView;

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
    self->hasLocationPoint = NO;
    [super viewWillAppear:animated];
    [self initTitleArea];
    self.view.backgroundColor = COLOR_BACKGROUND;
}

-(void)viewDidAppear:(BOOL)animated{
    if (animated) {
        //        self.mapView.frame = self.view.bounds;
        if (_mapView) {
            [self viewDidReady];
            if ([AmapLocationService getLastLocationPoint]) {
                [self showMapLocationPoint:[AmapLocationService getLastLocationPoint].MKCoordinateValue];
            }
        }
    }
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
        
        _mapView.showsUserLocation = YES;
//        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
        _mapView.userLocation.title = @"您的位置在这里";
    }
    return _mapView;
}

-(MAPointAnnotation *)pointAnnotaiton{
    if (!_pointAnnotaiton) {
        _pointAnnotaiton = [[MAPointAnnotation alloc] init];
        [self.mapView addAnnotation:_pointAnnotaiton];
    }
    return _pointAnnotaiton;
}

-(void)viewDidLayoutSubviews{
   self.mapView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    // Do any additional setup after loading the view.
    [self viewDidReady];
    if ([AmapLocationService getLastLocationPoint]) {
        double delayInSeconds = 0.5;
        __weak __typeof(self) weakSelf = self;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [weakSelf showMapLocationPoint:[AmapLocationService getLastLocationPoint].MKCoordinateValue];
        });
    }
}

-(void)viewDidReady{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(eventLocationChange:)
//                                                 name:EVENT_LOCATION_CHANGE
//                                               object:nil];
    if (self->commonPolyline) {
        [self.mapView removeOverlay:self->commonPolyline];
    }
    if (self.locationPoints) {//开始划线
        NSInteger count = self.locationPoints.count;
        //构造折线数据对象
        CLLocationCoordinate2D commonPolylineCoords[count];
        for (NSInteger i = 0; i < count; i++) {
            LocationInfo* info = self.locationPoints[i];
            CLLocationCoordinate2D coordinate = info.locationPoint.MKCoordinateValue;
            commonPolylineCoords[i].longitude = coordinate.longitude;
            commonPolylineCoords[i].latitude = coordinate.latitude;
        }
//        //构造折线对象
        self->commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:count];
        //在地图上添加折线对象
        [self.mapView addOverlay:commonPolyline];
//
//        
        [self.mapView setVisibleMapRect:commonPolyline.boundingMapRect animated:YES];
//
//        self->hasLocationPoint = YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    if (animated) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOCATION_CHANGE object:nil];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOCATION_CHANGE object:nil];
}

-(void)showMapLocationPoint:(CLLocationCoordinate2D)coordinate{
    //获取到定位信息，更新annotation
//    [self.pointAnnotaiton setCoordinate:coordinate];
//    
//    if (!self->hasLocationPoint) {
//        self->hasLocationPoint = YES;
//        [self.mapView setCenterCoordinate:coordinate];
//        [self.mapView setZoomLevel:15.1 animated:NO];
//    }
}

- (void)eventLocationChange:(NSNotification*)eventData{
    NSValue * coordinateValue = eventData.object;
    [self showMapLocationPoint:coordinateValue.MKCoordinateValue];
}


#pragma mark - mapview delegate
#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
//    if ([overlay isKindOfClass:[MAPolyline class]])
//    {
//        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
//        
//        polylineRenderer.lineWidth    = 8.f;
//        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
//        polylineRenderer.lineJoinType = kMALineJoinRound;
//        polylineRenderer.lineCapType  = kMALineCapRound;
//        
//        return polylineRenderer;
//    }
//    /* 自定义定位精度对应的MACircleView. */
    if (overlay == mapView.userLocationAccuracyCircle)
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

#pragma mark - MAMapView Delegate
//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
//        MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
//            annotationView.image            = [UIImage imageNamed:@"icon_car"];
//        }
//        
//        annotationView.canShowCallout   = NO;
//        annotationView.animatesDrop     = NO;
//        annotationView.draggable        = NO;
//        
//        return annotationView;
//    }
//    
//    return nil;
//}


//#pragma <MAMapViewDelegate> 协议中的 mapView:rendererForOverlay: 回调函数
//- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
//{
//    if ([overlay isKindOfClass:[MAPolyline class]])
//    {
//        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
//        
//        polylineRenderer.lineWidth    = 8.f;
//        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
//        polylineRenderer.lineJoinType = kMALineJoinRound;
//        polylineRenderer.lineCapType  = kMALineCapRound;
//        
//        return polylineRenderer;
//    }
//    return nil;
//}


@end
