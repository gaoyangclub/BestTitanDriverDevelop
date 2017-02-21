//
//  RootNavigationController.h
//  BestDriverTitan
//
//  Created by admin on 16/12/6.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootNavigationController : UINavigationController

-(instancetype)init __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
+(instancetype)new __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
//更多屏蔽初始化方法参照: http://ios.jobbole.com/89329/#comment-90585

+(instancetype)sharedInstance;

@property(nonatomic,assign)BOOL hairlineHidden;
@property(nonatomic,retain)UIColor* navigationColor;

@end
