//
//  MapNaviViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "MapNaviViewController.h"
#import "AmapLocationService.h"
#import <AVFoundation/AVFoundation.h>
#import "SpeechManager.h"
#import "HudManager.h"
#import "MMDrawerController.h"
#import "AppDelegate.h"
#import "MapNaviSettingController.h"

@interface MapNaviViewController ()<UIAlertViewDelegate,AMapNaviDriveManagerDelegate,MAMapViewDelegate,AMapNaviDriveViewDelegate,AMapSearchDelegate>

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)MAMapView* mapView;
@property(nonatomic,retain)AMapNaviDriveManager* driveManager;

@property(nonatomic,retain)AMapNaviDriveView* driveView;

@property(nonatomic,retain)AMapNaviPoint* startPoint;

@property(nonatomic,retain)AMapNaviPoint* endPoint;

@property(nonatomic,retain)AMapSearchAPI* searchAPI;

@end

@implementation MapNaviViewController

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

-(AMapSearchAPI *)searchAPI{
    if (!_searchAPI) {
        _searchAPI = [[AMapSearchAPI alloc]init];
        _searchAPI.delegate = self;
    }
    return _searchAPI;
}

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.navigationItem.rightBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_SHE_ZHI target:self action:@selector(rightClick)];
    self.titleLabel.text = @"导航";//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
}

//返回上层
-(void)leftClick{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要退出导航吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"准奏", nil];
    [alert show];
}

-(void)rightClick{
    MMDrawerController* drawerController = (MMDrawerController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
    [drawerController setDrawerVisualStateBlock:nil];//先清除掉
    
    AMapNaviDrivingStrategy strategy = [MapNaviSettingController getNaviDrivingStrategy];
    __weak __typeof(self) weakSelf = self;
    [drawerController toggleDrawerSide:(MMDrawerSideRight) animated:YES completion:^(BOOL finished) {
        if (finished) {
            [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
                if(!percentVisible && strategy != [MapNaviSettingController getNaviDrivingStrategy]){//side关闭完毕 且 设置有变化
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    [SpeechManager stopSound];//停止声音
                    [strongSelf.driveManager stopNavi];//停止导航
                    [strongSelf viewDidLoad];
                }
            }];
        }
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [SpeechManager stopSound];
        [self.driveManager stopNavi];//停止导航
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(MAMapView *)mapView{
    if (!_mapView) {
        CGFloat kRoutePlanInfoViewHeight = 60;
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, kRoutePlanInfoViewHeight,
                                                                   self.view.bounds.size.width,
                                                                   self.view.bounds.size.height - kRoutePlanInfoViewHeight)];
        [_mapView setDelegate:self];
        [self.view addSubview:_mapView];
    }
    return _mapView;
}

-(AMapNaviDriveManager *)driveManager{
    if (!_driveManager) {
        _driveManager = [[AMapNaviDriveManager alloc] init];
        [_driveManager setDelegate:self];
        //将driveView添加为导航数据的Representative，使其可以接收到导航诱导数据
        [_driveManager addDataRepresentative:self.driveView];
    }
    return _driveManager;
}

-(AMapNaviDriveView *)driveView{
    if (!_driveView){
        _driveView = [[AMapNaviDriveView alloc] initWithFrame:self.view.bounds];
        _driveView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_driveView setDelegate:self];
        
        [self.view addSubview:_driveView];
    }
    return _driveView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(!self.endPoint){
        if(self.endLatitude && self.endLongitude){
            self.endPoint = [AMapNaviPoint locationWithLatitude:self.endLatitude longitude:self.endLongitude];
        }else{
            AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
            geo.address = self.endAddress;
            [self.searchAPI AMapGeocodeSearch:geo];
            [HudManager showToast:@"目标坐标点不存在!"];
        }
    }
    
    NSValue* coordinateValue = [AmapLocationService getLastLocationPoint];
    if (coordinateValue) {
        CLLocationCoordinate2D locationPoint = coordinateValue.MKCoordinateValue;
        self.startPoint = [AMapNaviPoint locationWithLatitude:locationPoint.latitude longitude:locationPoint.longitude];
        [self checkStartCalculate];
    }else{
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventLocationChange:)
                                                     name:EVENT_LOCATION_CHANGE
                                                   object:nil];
    }
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
        self.endLatitude = geoCode.location.latitude;
        self.endLongitude = geoCode.location.longitude;
        self.endPoint = [AMapNaviPoint locationWithLatitude:self.endLatitude longitude:self.endLongitude];
        [self checkStartCalculate];
    }
}

-(void)checkStartCalculate{
    if (self.startPoint && self.endPoint) {
        [self startCalculateDriveRoute];
    }
}

- (void)eventLocationChange:(NSNotification*)eventData{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOCATION_CHANGE object:nil];
    
    NSValue * coordinateValue = eventData.object;
    CLLocationCoordinate2D locationPoint = coordinateValue.MKCoordinateValue;
    self.startPoint = [AMapNaviPoint locationWithLatitude:locationPoint.latitude longitude:locationPoint.longitude];
    
    [self checkStartCalculate];
}

-(void)startCalculateDriveRoute{
    AMapNaviDrivingStrategy strategy = [MapNaviSettingController getNaviDrivingStrategy];
    [self.driveManager calculateDriveRouteWithStartPoints:@[self.startPoint]
                                                endPoints:@[self.endPoint]
                                                wayPoints:nil
                                          drivingStrategy:strategy];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOCATION_CHANGE object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma AMapNaviDriveManagerDelegate
- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onCalculateRouteSuccess");
    
    //显示路径或开启导航
    //算路成功后开始GPS导航
    [self.driveManager startGPSNavi];
}

#pragma AMapNaviDriveManagerDelegate
- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager
{
    return [SpeechManager isSpeaking];
}

#pragma AMapNaviDriveManagerDelegate
- (void)driveManager:(AMapNaviDriveManager *)driveManager playNaviSoundString:(NSString *)soundString soundStringType:(AMapNaviSoundType)soundStringType
{
    NSLog(@"playNaviSoundString:{%ld:%@}", (long)soundStringType, soundString);
    
//    [[SpeechSynthesizer sharedSpeechSynthesizer] speakString:soundString];
    
//    AVSpeechSynthesizer * synthsizer = [[AVSpeechSynthesizer alloc] init];
//    
//    AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc] initWithString:soundString];//需要转换的文本
//    
//    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//国家语言
//    
//    utterance.rate = 0.4f;//声速
//    
//    [synthsizer speakUtterance:utterance];
    [SpeechManager playSoundString:soundString];
}

#pragma AMapNaviDriveViewDelegate
-(void)driveViewCloseButtonClicked:(AMapNaviDriveView *)driveView{
    [self leftClick];
}

@end
