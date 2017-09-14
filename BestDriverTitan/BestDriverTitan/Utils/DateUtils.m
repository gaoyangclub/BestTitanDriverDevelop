//
//  DateUtils.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "DateUtils.h"

@implementation DateUtils

+(NSString *)getUTCFormateName:(NSDate *)newsDate{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    NSDate *today = [[NSDate alloc] init];
    NSDate *yearsterDay = [[NSDate alloc] initWithTimeIntervalSinceNow: -secondsPerDay];
    NSDate *beforeYearsterDay = [[NSDate alloc] initWithTimeIntervalSinceNow: -2 * secondsPerDay];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    if ([[dateFormatter stringFromDate:today] isEqualToString:[dateFormatter stringFromDate:newsDate]]) {
        return @"今天";
    }
    else if ([[dateFormatter stringFromDate:yearsterDay] isEqualToString:[dateFormatter stringFromDate:newsDate]]) {
        return @"昨天";
    }
    else if ([[dateFormatter stringFromDate:beforeYearsterDay] isEqualToString:[dateFormatter stringFromDate:newsDate]]) {
        return @"前天";
    }
    //假设这是你要比较的date：NSDate *yourDate = ……
    //日历
//    NSCalendar* calendar = [NSCalendar currentCalendar];
//    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
//    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:newsDate];
//    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:yearsterDay];
//    NSDateComponents* comp3 = [calendar components:unitFlags fromDate:qianToday];
//    NSDateComponents* comp4 = [calendar components:unitFlags fromDate:today];
//    if (comp1.year == comp4.year && comp1.month == comp4.month && comp1.day == comp4.day)
//    {
//        dateContent = @"今天";
//    }
//    else if ( comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day) {
//        dateContent = @"昨天";
//    }
//    else if (comp1.year == comp3.year && comp1.month == comp3.month && comp1.day == comp3.day)
//    {
//        dateContent = @"前天";
//    }
    return nil;
}

@end
