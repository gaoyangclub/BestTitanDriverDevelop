//
//  TaskViewSection.h
//  BestDriverTitan
//
//  Created by admin on 17/2/15.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJTableViewSection.h"

@interface TaskViewSectionVo : NSObject

@property(nonatomic,assign)BOOL isComplete;
@property(nonatomic,assign)NSUInteger toCount;
@property(nonatomic,retain)NSDate* dateTime;

@end

@interface TaskViewSection : MJTableViewSection

@end
