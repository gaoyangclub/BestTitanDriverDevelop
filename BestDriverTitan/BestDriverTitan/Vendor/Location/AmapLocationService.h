//
//  AmapLocationService.h
//  BestDriverTitan
//
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AMapLocationKit/AMapLocationKit.h>

@interface LocationInfo : NSObject

@property(nonatomic,retain)NSValue* locationPoint;
@property(nonatomic,copy)NSString* dateString;

-(void)addLocationPoint:(NSValue*)locationPoint;

@end

@interface AmapLocationService : NSObject

@property (nonatomic,retain) AMapLocationManager *locationManager;

+(instancetype)sharedInstance;

+(void)startUpdatingLocation;
+(void)stopUpdatingLocation;

+(NSValue*)getLastLocationPoint;

+(NSMutableArray<LocationInfo*>*)getAllLocationInfos;

@end
