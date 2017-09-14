//
//  GeographyUtils.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "GeographyUtils.h"

@implementation GeographyUtils

+(double)rad:(double)d{
    return d * 3.141592653589793 / 180.0;
}

+(double)getLantitudeLongitudeDist:(double)lon1 lat1:(double)lat1 lon2:(double)lon2 lat2:(double)lat2{
    double radLat1 = [GeographyUtils rad:lat1];
    double radLat2 = [GeographyUtils rad:lat2];
    double radLon1 = [GeographyUtils rad:lon1];
    double radLon2 = [GeographyUtils rad:lon2];
    if(radLat1 < 0.0) {
        radLat1 = 1.5707963267948966 + fabs(radLat1);
    }
    
    if(radLat1 > 0.0) {
        radLat1 = 1.5707963267948966 - fabs(radLat1);
    }
    
    if(radLon1 < 0.0) {
        radLon1 = 6.283185307179586 - fabs(radLon1);
    }
    
    if(radLat2 < 0.0) {
        radLat2 = 1.5707963267948966 + fabs(radLat2);
    }
    
    if(radLat2 > 0.0) {
        radLat2 = 1.5707963267948966 - fabs(radLat2);
    }
    
    if(radLon2 < 0.0) {
        radLon2 = 6.283185307179586 - fabs(radLon2);
    }
    
    double x1 = 6378137.0 * cos(radLon1) * sin(radLat1);
    double y1 = 6378137.0 * sin(radLon1) * sin(radLat1);
    double z1 = 6378137.0 * cos(radLat1);
    double x2 = 6378137.0 * cos(radLon2) * sin(radLat2);
    double y2 = 6378137.0 * sin(radLon2) * sin(radLat2);
    double z2 = 6378137.0 * cos(radLat2);
    double d = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2) + (z1 - z2) * (z1 - z2));
    double theta = acos((8.1361263181538E13 - d * d) / 8.1361263181538E13);
    double dist = theta * 6378137.0;
    return dist;
}

@end
