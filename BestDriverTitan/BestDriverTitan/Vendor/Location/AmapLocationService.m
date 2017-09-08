//
//  AmapLocationService.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AmapLocationService.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "LocationViewModel.h"

@implementation LocationInfo

-(void)addLocationPoint:(NSValue *)locationPoint{
    self.locationPoint = locationPoint;
    [self saveDateString];
}

-(void)saveDateString{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* dateString = [dateFormatter stringFromDate:[NSDate date]];
    self.dateString = dateString;
}

@end

@interface AmapLocationService()<AMapLocationManagerDelegate,CLLocationManagerDelegate>

@property (nonatomic,retain) NSValue * lastLocationPoint;

@property (nonatomic,retain) NSMutableArray<LocationInfo*>* locationInfoPoints;//将数据存储起来 间隔时间提报

@property (nonatomic,strong) CLLocationManager* nativeLocationManager;
//@property (nonatomic,retain) AMapLocationManager *locationManager;

@property (nonatomic,retain) NSMutableArray<NSString*>* locationList;

@end

static AmapLocationService* instance;
//static NSInteger submitCount = 20;
//static BOOL hasSendLocation;

@implementation AmapLocationService

+(instancetype)sharedInstance {
    @synchronized (self)    {
        if (instance == nil)
        {
            instance = [[self alloc] init];
        }
    }
    return instance;
}

-(CLLocationManager *)nativeLocationManager{
    if (!_nativeLocationManager) {
        _nativeLocationManager = [[CLLocationManager alloc] init];
        [_nativeLocationManager setDelegate:self];
        [_nativeLocationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
        
        //该模式是抵抗程序在后台被杀，申明不能够被暂停
        _nativeLocationManager.pausesLocationUpdatesAutomatically = NO;
        
        if ([[UIDevice currentDevice]systemVersion].floatValue >= 8) {
            [_nativeLocationManager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
            //        [_nativeLocationManager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        }
        if ([[UIDevice currentDevice]systemVersion].floatValue >= 9) {
            _nativeLocationManager.allowsBackgroundLocationUpdates = YES;
        }
    }
    return _nativeLocationManager;
}

-(NSMutableArray<LocationInfo *> *)locationInfoPoints{
    if (!_locationInfoPoints) {
        _locationInfoPoints = [[NSMutableArray<LocationInfo*> alloc]init];
    }
    return _locationInfoPoints;
}

-(NSMutableArray<NSString *> *)locationList{
    if (!_locationList) {
        _locationList = [[NSMutableArray<NSString *> alloc]init];
    }
    return _locationList;
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // I would get the latest location here
    // but this method never gets called
//    NSLog(@"complete: %@", locations);
    if (locations && locations.count > 0) {
        CLLocation * location = locations.firstObject;
        CLLocationCoordinate2D cd = AMapCoordinateConvert(location.coordinate, AMapCoordinateTypeGPS);
        NSValue* pointValue = [NSValue valueWithMKCoordinate:cd];
        self.lastLocationPoint = pointValue;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOCATION_CHANGE object:pointValue];
        
        LocationInfo* info = [[LocationInfo alloc]init];
        [info addLocationPoint:pointValue];
//        [self.locationPoints addObject:info];
        [self.locationInfoPoints insertObject:info atIndex:0];
        
        NSString* pointGroup = ConcatStrings(@"",@(cd.longitude),@",",@(cd.latitude));
        [self.locationList addObject:pointGroup];
        
//        if(hasSendLocation){
//            NSLog(@"hasSendLocation-------------正在发送中--------------");
//        }
//        if(!hasSendLocation && self.locationList.count > submitCount){//每60个点上传一次
//            [LocationViewModel sendLocationPoints];
//        }
        
//        NSLog(@"nativeLocation:{lat:%f; lon:%f; accuracy:%f; dateString:%@;}", location.coordinate.latitude, location.coordinate.longitude,location.horizontalAccuracy,info.dateString);// reGeocode:%@ , reGeocode.formattedAddress
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
}

//-(AMapLocationManager *)locationManager{
//    if (!_locationManager) {
//        _locationManager = [[AMapLocationManager alloc] init];
//        
//        [_locationManager setDelegate:self];
//        
//        //设置不允许系统暂停定位
//        [_locationManager setPausesLocationUpdatesAutomatically:NO];
//        
//        //设置允许在后台定位
//        [_locationManager setAllowsBackgroundLocationUpdates:YES];
//        
//        //    //设置允许连续定位逆地理
//        //    [_locationManager setLocatingWithReGeocode:YES];
//    }
//    return _locationManager;
//}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    self.lastLocationPoint = [NSValue valueWithMKCoordinate:location.coordinate];
    NSLog(@"amapLocation:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude,     location.horizontalAccuracy, reGeocode.formattedAddress);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOCATION_CHANGE object:location];
}

+(void)startUpdatingLocation{
//    AMapLocationManager* a = [AmapLocationService sharedInstance].locationManager;
    CLLocationManager* a = [AmapLocationService sharedInstance].nativeLocationManager;
    [a startUpdatingLocation];//开始连续定位
}

+(void)stopUpdatingLocation{
    [[AmapLocationService sharedInstance].nativeLocationManager stopUpdatingLocation];//停止定位
}

+(NSValue *)getLastLocationPoint{
    return [AmapLocationService sharedInstance].lastLocationPoint;
}

+(NSMutableArray<LocationInfo *> *)getAllLocationInfos{
    return [AmapLocationService sharedInstance].locationInfoPoints;
}

+(NSMutableArray<LocationInfo *> *)getAllLocationPoints{
    NSMutableArray<LocationInfo *> * locationInfos = [AmapLocationService getAllLocationInfos];
    if (locationInfos && locationInfos.count > 0) {
        NSMutableArray<LocationInfo *> * locationPoints = [NSMutableArray<LocationInfo *> array];
        for (LocationInfo* info in locationInfos) {
            if (info.markType == LocationMarkTypePoint) {
                [locationPoints addObject:info];
            }
        }
        return locationPoints;
    }
    return nil;
}

+(NSMutableArray<NSString *> *)getLocationList{
    return [AmapLocationService sharedInstance].locationList;
}

+(void)clearLocationList{
    [[AmapLocationService sharedInstance].locationList removeAllObjects];//清除数据
}

+(void)addMarkInfo:(NSString *)mark type:(LocationMarkType)type{
    LocationInfo* info = [[LocationInfo alloc]init];
    info.markInfo = mark;
    info.markType = type;
    [info saveDateString];
    [[AmapLocationService sharedInstance].locationInfoPoints insertObject:info atIndex:0];
}

+(void)setHasSendLocation:(BOOL)value{
//    hasSendLocation = value;
}

@end
