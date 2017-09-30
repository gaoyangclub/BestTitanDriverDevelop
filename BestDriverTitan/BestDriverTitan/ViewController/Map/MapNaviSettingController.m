//
//  MapNaviSettingController.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MapNaviSettingController.h"
#import "UserDefaultsUtils.h"
#import "MMDrawerController.h"
#import "AppDelegate.h"

#define DEFAULT_DRIVING_STRATEGY AMapNaviDrivingStrategySingleAvoidCostAndCongestion

@interface MapNaviSettingController ()

@property(nonatomic,retain)UISwitch* switchAvoidHighway;//单路径: 不走高速
@property(nonatomic,retain)UILabel* labelAvoidHighway;//单路径: 不走高速
@property(nonatomic,retain)UISwitch* switchAvoidCongestion;//单路径: 躲避拥堵
@property(nonatomic,retain)UILabel* labelAvoidCongestion;//单路径: 躲避拥堵
@property(nonatomic,retain)UISwitch* switchAvoidCost;//单路径: 避免收费
@property(nonatomic,retain)UILabel* labelAvoidCost;//单路径: 避免收费

@end

@implementation MapNaviSettingController

-(UISwitch *)switchAvoidHighway{
    if (!_switchAvoidHighway) {
        _switchAvoidHighway = [[UISwitch alloc] init];
        [self.view addSubview:_switchAvoidHighway];
        [_switchAvoidHighway addTarget:self action:@selector(switchAvoidHighwayChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchAvoidHighway;
}

-(UILabel *)labelAvoidHighway{
    if (!_labelAvoidHighway) {
        _labelAvoidHighway = [UICreationUtils createLabel:16 color:[UIColor whiteColor] text:@"不走高速" sizeToFit:YES superView:self.view];
    }
    return _labelAvoidHighway;
}

-(UISwitch *)switchAvoidCongestion{
    if (!_switchAvoidCongestion) {
        _switchAvoidCongestion = [[UISwitch alloc] init];
        [self.view addSubview:_switchAvoidCongestion];
        [_switchAvoidCongestion addTarget:self action:@selector(switchAvoidCongestionChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchAvoidCongestion;
}

-(UILabel *)labelAvoidCongestion{
    if (!_labelAvoidCongestion) {
        _labelAvoidCongestion = [UICreationUtils createLabel:16 color:[UIColor whiteColor] text:@"躲避拥堵" sizeToFit:YES superView:self.view];
    }
    return _labelAvoidCongestion;
}

-(UISwitch *)switchAvoidCost{
    if (!_switchAvoidCost) {
        _switchAvoidCost = [[UISwitch alloc] init];
        [self.view addSubview:_switchAvoidCost];
        [_switchAvoidCost addTarget:self action:@selector(switchAvoidCostChange) forControlEvents:UIControlEventValueChanged];
    }
    return _switchAvoidCost;
}

-(UILabel *)labelAvoidCost{
    if (!_labelAvoidCost) {
        _labelAvoidCost = [UICreationUtils createLabel:16 color:[UIColor whiteColor] text:@"避免收费" sizeToFit:YES superView:self.view];
    }
    return _labelAvoidCost;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = COLOR_PRIMARY;
    
    CGFloat const leftpadding = 30;
    CGFloat const toppadding = 50;
    CGFloat const gap = 20;
    
    self.labelAvoidCongestion.x = leftpadding;
    self.labelAvoidCongestion.y = toppadding;
    self.switchAvoidCongestion.x = self.labelAvoidCongestion.maxX + gap;
    self.switchAvoidCongestion.centerY = self.labelAvoidCongestion.centerY;
    
    self.labelAvoidCost.x = leftpadding;
    self.labelAvoidCost.y = self.labelAvoidCongestion.maxY + gap;
    self.switchAvoidCost.x = self.labelAvoidCost.maxX + gap;
    self.switchAvoidCost.centerY = self.labelAvoidCost.centerY;
    
    self.labelAvoidHighway.x = leftpadding;
    self.labelAvoidHighway.y = self.labelAvoidCost.maxY + gap;
    self.switchAvoidHighway.x = self.labelAvoidHighway.maxX + gap;
    self.switchAvoidHighway.centerY = self.labelAvoidHighway.centerY;
}

-(void)switchAvoidHighwayChange{
//    MMDrawerController* drawerController = (MMDrawerController*)((AppDelegate*)[UIApplication sharedApplication].delegate).window.rootViewController;
//    [drawerController closeDrawerAnimated:YES completion:nil];
    [self saveNaviDrivingStrategy];
}

-(void)switchAvoidCongestionChange{
    [self saveNaviDrivingStrategy];
}

-(void)switchAvoidCostChange{
    [self saveNaviDrivingStrategy];
}

-(void)viewWillAppear:(BOOL)animated{
    if (animated) {
        [self initData];
    }
}

-(void)initData{
    AMapNaviDrivingStrategy strategy = [MapNaviSettingController getNaviDrivingStrategy];
    switch (strategy) {
        case AMapNaviDrivingStrategySingleDefault:
            [self.switchAvoidCongestion setOn:NO];
            [self.switchAvoidCost setOn:NO];
            [self.switchAvoidHighway setOn:NO];
            break;
        case AMapNaviDrivingStrategySingleAvoidCost:
            [self.switchAvoidCongestion setOn:NO];
            [self.switchAvoidCost setOn:YES];
            [self.switchAvoidHighway setOn:NO];
            break;
        case AMapNaviDrivingStrategySingleAvoidCongestion:
            [self.switchAvoidCongestion setOn:YES];
            [self.switchAvoidCost setOn:NO];
            [self.switchAvoidHighway setOn:NO];
            break;
        case AMapNaviDrivingStrategySingleAvoidHighway:
            [self.switchAvoidCongestion setOn:NO];
            [self.switchAvoidCost setOn:NO];
            [self.switchAvoidHighway setOn:YES];
            break;
        case AMapNaviDrivingStrategySingleAvoidHighwayAndCost:
            [self.switchAvoidCongestion setOn:NO];
            [self.switchAvoidCost setOn:YES];
            [self.switchAvoidHighway setOn:YES];
            break;
        case AMapNaviDrivingStrategySingleAvoidCostAndCongestion:
            [self.switchAvoidCongestion setOn:YES];
            [self.switchAvoidCost setOn:YES];
            [self.switchAvoidHighway setOn:NO];
            break;
        case AMapNaviDrivingStrategyMultipleAvoidHighwayAndCongestion:
            [self.switchAvoidCongestion setOn:YES];
            [self.switchAvoidCost setOn:NO];
            [self.switchAvoidHighway setOn:YES];
            break;
        case AMapNaviDrivingStrategySingleAvoidHighwayAndCostAndCongestion:
            [self.switchAvoidCongestion setOn:YES];
            [self.switchAvoidCost setOn:YES];
            [self.switchAvoidHighway setOn:YES];
            break;
        default:
            break;
    }
}

-(void)saveNaviDrivingStrategy{
    AMapNaviDrivingStrategy strategy = -1;
    if (![self.switchAvoidCongestion isOn] && ![self.switchAvoidCost isOn] && ![self.switchAvoidHighway isOn]) {
        strategy = AMapNaviDrivingStrategySingleDefault;
    }
    else if([self.switchAvoidCongestion isOn] && ![self.switchAvoidCost isOn] && ![self.switchAvoidHighway isOn]){
        strategy = AMapNaviDrivingStrategySingleAvoidCongestion;
    }
    else if(![self.switchAvoidCongestion isOn] && [self.switchAvoidCost isOn] && ![self.switchAvoidHighway isOn]){
        strategy = AMapNaviDrivingStrategySingleAvoidCost;
    }
    else if(![self.switchAvoidCongestion isOn] && ![self.switchAvoidCost isOn] && [self.switchAvoidHighway isOn]){
        strategy = AMapNaviDrivingStrategySingleAvoidHighway;
    }
    else if([self.switchAvoidCongestion isOn] && [self.switchAvoidCost isOn] && ![self.switchAvoidHighway isOn]){
        strategy = AMapNaviDrivingStrategySingleAvoidCostAndCongestion;
    }
    else if(![self.switchAvoidCongestion isOn] && [self.switchAvoidCost isOn] && [self.switchAvoidHighway isOn]){
        strategy = AMapNaviDrivingStrategySingleAvoidHighwayAndCost;
    }
    else if([self.switchAvoidCongestion isOn] && ![self.switchAvoidCost isOn] && [self.switchAvoidHighway isOn]){
        strategy = AMapNaviDrivingStrategyMultipleAvoidHighwayAndCongestion;
    }
    else if([self.switchAvoidCongestion isOn] && [self.switchAvoidCost isOn] && [self.switchAvoidHighway isOn]){
        strategy = AMapNaviDrivingStrategySingleAvoidHighwayAndCostAndCongestion;
    }
    if (strategy >= 0) {
        [UserDefaultsUtils setObject:[NSNumber numberWithInteger:strategy] forKey:NAVI_DRIVING_STRATEGY_KEY];
    }
}

+(AMapNaviDrivingStrategy)getNaviDrivingStrategy{
    NSNumber* strategyNumber = [UserDefaultsUtils getObject:NAVI_DRIVING_STRATEGY_KEY];
    AMapNaviDrivingStrategy strategy = 0;
    if (!strategyNumber) {
        strategy = DEFAULT_DRIVING_STRATEGY;
    }else{
        strategy = [strategyNumber integerValue];
    }
    return strategy;
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
