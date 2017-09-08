//
//  AmapLocationService.h
//  BestDriverTitan
//
//  Created by admin on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AMapLocationKit/AMapLocationKit.h>

typedef NS_ENUM(NSInteger,LocationMarkType) {
    LocationMarkTypePoint = 0,//定位点
    LocationMarkTypeInfo,
    LocationMarkTypeDebug,
    LocationMarkTypeWarn,
    LocationMarkTypeError,
};

@interface LocationInfo : NSObject

@property(nonatomic,retain)NSValue* locationPoint;
@property(nonatomic,copy)NSString* dateString;
@property(nonatomic,copy)NSString* markInfo;
@property(nonatomic,assign)LocationMarkType markType;

-(void)addLocationPoint:(NSValue*)locationPoint;
-(void)saveDateString;

@end

@interface AmapLocationService : NSObject

+(instancetype)sharedInstance;

+(void)startUpdatingLocation;
+(void)stopUpdatingLocation;

+(NSValue*)getLastLocationPoint;

+(NSMutableArray<LocationInfo*>*)getAllLocationInfos;

+(NSMutableArray<LocationInfo *> *)getAllLocationPoints;//仅获取LocationMarkTypePoint的数据

+(NSMutableArray<NSString*>*)getLocationList;

+(void)clearLocationList;

+(void)addMarkInfo:(NSString*)mark type:(LocationMarkType)type;

+(void)setHasSendLocation:(BOOL)value;

@end
