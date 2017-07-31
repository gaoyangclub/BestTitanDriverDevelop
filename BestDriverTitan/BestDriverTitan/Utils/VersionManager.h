//
//  VersionManager.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/24.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionManager : NSObject

#pragma 0表示相同 1表示服务端>本地 -1服务端<本地
+(int)versionComparison:(NSString*)versionServer andVersionLocal:(NSString*)versionLocal;

@end
