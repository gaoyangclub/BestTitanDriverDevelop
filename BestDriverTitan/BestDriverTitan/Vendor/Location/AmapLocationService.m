//
//  AmapLocationService.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AmapLocationService.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

@implementation LocationInfo

-(void)addLocationPoint:(NSValue *)locationPoint{
    self.locationPoint = locationPoint;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.dateString = [dateFormatter stringFromDate:[NSDate date]];
}

@end

@interface AmapLocationService()<AMapLocationManagerDelegate,CLLocationManagerDelegate>

@property (nonatomic,retain) NSValue * lastLocationPoint;

@property (nonatomic,retain) NSMutableArray<LocationInfo*>* locationPoints;//将数据存储起来 间隔时间提报

@property(nonatomic,strong) CLLocationManager* nativeLocationManager;

@end

static AmapLocationService* instance;

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
        [_nativeLocationManager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [_nativeLocationManager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
    }
    return _nativeLocationManager;
}

-(NSMutableArray<LocationInfo *> *)locationPoints{
    if (!_locationPoints) {
        _locationPoints = [[NSMutableArray<LocationInfo*> alloc]init];
    }
    return _locationPoints;
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
        NSLog(@"nativeLocation:{lat:%f; lon:%f; accuracy:%f; }", location.coordinate.latitude, location.coordinate.longitude,     location.horizontalAccuracy);// reGeocode:%@ , reGeocode.formattedAddress
        [[NSNotificationCenter defaultCenter] postNotificationName:EVENT_LOCATION_CHANGE object:pointValue];
        
        LocationInfo* info = [[LocationInfo alloc]init];
        [info addLocationPoint:pointValue];
        [_locationPoints addObject:info];
    }
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
}

-(AMapLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        
        [_locationManager setDelegate:self];
        
        //设置不允许系统暂停定位
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
        
        //设置允许在后台定位
        [_locationManager setAllowsBackgroundLocationUpdates:YES];
        
        //    //设置允许连续定位逆地理
        //    [_locationManager setLocatingWithReGeocode:YES];
    }
    return _locationManager;
}

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
    [[AmapLocationService sharedInstance].locationManager stopUpdatingLocation];//停止定位
}

+(NSValue *)getLastLocationPoint{
    return [AmapLocationService sharedInstance].lastLocationPoint;
}

+(NSMutableArray<LocationInfo *> *)getAllLocationInfos{
    return [AmapLocationService sharedInstance].locationPoints;
}

@end
