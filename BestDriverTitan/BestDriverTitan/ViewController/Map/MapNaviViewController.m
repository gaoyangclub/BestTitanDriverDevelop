//
//  MapNaviViewController.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <AMapNaviKit/AMapNaviKit.h>
#import "MapNaviViewController.h"
#import "AmapLocationService.h"
#import <AVFoundation/AVFoundation.h>
#import "SpeechManager.h"

@interface MapNaviViewController ()<UIAlertViewDelegate,AMapNaviDriveManagerDelegate,MAMapViewDelegate,AMapNaviDriveViewDelegate>

@property(nonatomic,retain)UILabel* titleLabel;

@property(nonatomic,retain)MAMapView* mapView;
@property(nonatomic,retain)AMapNaviDriveManager* driveManager;

@property(nonatomic,retain)AMapNaviDriveView* driveView;

@property(nonatomic,retain)AMapNaviPoint* endPoint;

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

-(void)initTitleArea{
    self.navigationItem.leftBarButtonItem =
    [UICreationUtils createNavigationNormalButtonItem:COLOR_NAVI_TITLE font:[UIFont fontWithName:ICON_FONT_NAME size:25] text:ICON_FAN_HUI target:self action:@selector(leftClick)];
    self.titleLabel.text = @"导航";//标题显示TO号
    [self.titleLabel sizeToFit];
    self.navigationItem.titleView = self.titleLabel;
}

//返回上层
-(void)leftClick{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您确定要退出导航吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
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
    
    self.endPoint   = [AMapNaviPoint locationWithLatitude:30.17105 longitude:120.27121];
    
    NSValue* coordinateValue = [AmapLocationService getLastLocationPoint];
    if (coordinateValue) {
        CLLocationCoordinate2D locationPoint = coordinateValue.MKCoordinateValue;
        [self startCalculateDriveRoute:locationPoint];
    }else{
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(eventLocationChange:)
                                                     name:EVENT_LOCATION_CHANGE
                                                   object:nil];
    }
}

- (void)eventLocationChange:(NSNotification*)eventData{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOCATION_CHANGE object:nil];
    
    NSValue * coordinateValue = eventData.object;
    [self startCalculateDriveRoute:coordinateValue.MKCoordinateValue];
}

-(void)startCalculateDriveRoute:(CLLocationCoordinate2D)locationPoint{
    AMapNaviPoint* startPoint = [AMapNaviPoint locationWithLatitude:locationPoint.latitude longitude:locationPoint.longitude];
    [self.driveManager calculateDriveRouteWithStartPoints:@[startPoint]
                                                endPoints:@[self.endPoint]
                                                wayPoints:nil
                                          drivingStrategy:17];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_LOCATION_CHANGE object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)driveManagerOnCalculateRouteSuccess:(AMapNaviDriveManager *)driveManager
{
    NSLog(@"onCalculateRouteSuccess");
    
    //显示路径或开启导航
    //算路成功后开始GPS导航
    [self.driveManager startGPSNavi];
}

- (BOOL)driveManagerIsNaviSoundPlaying:(AMapNaviDriveManager *)driveManager
{
    return [SpeechManager isSpeaking];
}

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

@end
