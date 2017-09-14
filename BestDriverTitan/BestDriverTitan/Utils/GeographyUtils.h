//
//  GeographyUtils.h
//  BestDriverTitan
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GeographyUtils : NSObject

+(double)getLantitudeLongitudeDist:(double)lon1 lat1:(double)lat1 lon2:(double)lon2 lat2:(double)lat2;

@end
