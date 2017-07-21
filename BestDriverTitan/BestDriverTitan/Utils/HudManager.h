//
//  HudManager.h
//  BestDriverTitan
//
//  Created by admin on 2017/7/20.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HudManager : NSObject

//-(instancetype)init __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
//+(instancetype)new __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
////更多屏蔽初始化方法参照: http://ios.jobbole.com/89329/#comment-90585
//
//+(instancetype)sharedInstance;

+(void)showToast:(NSString*)value;
+(void)showToast:(NSString*)value delay:(CGFloat)delay;

@end
