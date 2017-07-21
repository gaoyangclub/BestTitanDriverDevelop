//
//  PopAnimateManager.h
//  BestDriverTitan
//
//  Created by 高扬 on 17/7/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PopAnimateManager : NSObject

//-(instancetype)init __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
//+(instancetype)new __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
////更多屏蔽初始化方法参照: http://ios.jobbole.com/89329/#comment-90585
//
//+(instancetype)sharedInstance;

+(void)startClickAnimation:(UIView*)sender;
+(void)startShakeAnimation:(UIView*)sender;
+(void)startShakeAnimation:(UIView*)sender bounciness:(CGFloat)bounciness;

@end
