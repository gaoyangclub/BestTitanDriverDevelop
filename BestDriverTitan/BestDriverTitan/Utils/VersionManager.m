//
//  VersionManager.m
//  BestDriverTitan
//
//  Created by admin on 2017/7/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "VersionManager.h"

@implementation VersionManager

+(int)versionComparison:(NSString *)versionServer andVersionLocal:(NSString *)versionLocal{
    if (versionServer && versionServer.length > 0 && versionLocal && versionLocal.length > 0) {
        int index1 = 0;
        NSArray<NSNumber*>* segments2;
        for(int index2 = 0; index1 < versionServer.length && index2 < versionLocal.length; index2 = segments2[1].intValue + 1) {
            NSArray<NSNumber*>* segments1 = [VersionManager getValue:versionServer index:index1];
            segments2 = [VersionManager getValue:versionLocal index:index2];
            if(segments1[0] < segments2[0]) {
                return -1;
            }
            if(segments1[0] > segments2[0]) {
                return 1;
            }
            index1 = segments1[1].intValue + 1;
        }
        NSArray* segments11 = [versionServer componentsSeparatedByString:@"\\."];
        NSArray* segments21 = [versionLocal componentsSeparatedByString:@"\\."];
        return segments11.count > segments21.count ? 1 : (segments11.count < segments21.count ? -1 : 0);
    }
    return -1;
}

+(NSArray<NSNumber*>*)getValue:(NSString*)version index:(int)index{
//    int[] value_index = new int[2];
//    StringBuilder sb;
//    for(sb = new StringBuilder(); index < version.length() && version.charAt(index) != 46; ++index) {
//        sb.append(version.charAt(index));
//    }
//    value_index[0] = Integer.parseInt(sb.toString());
//    value_index[1] = index;
    NSString* sub = @"";
    for (; index < version.length && [version characterAtIndex:index] != 46; ++index) {
        unichar charCode = [version characterAtIndex:index];
//        DDLog(@"charCode:%hu",charCode);
        sub = [sub stringByAppendingString:[NSNumber numberWithChar:charCode].stringValue];
    }
    NSArray<NSNumber*>* value_index = [NSArray arrayWithObjects:[NSNumber numberWithInt:[sub intValue]],[NSNumber numberWithInt:index], nil];
    return value_index;
}

@end
