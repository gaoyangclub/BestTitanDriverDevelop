//
//  UpdateVersionManager.h
//  BestDriverTitan
//
//  Created by admin on 2017/8/2.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^UpdateResultHandler)(NSDictionary*);

typedef void(^UpdateCancelHandler)();

@interface UpdateVersionManager : NSObject

-(instancetype)init __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
+(instancetype)new __attribute__((unavailable("Disabled. Use +sharedInstance instead")));
//更多屏蔽初始化方法参照: http://ios.jobbole.com/89329/#comment-90585

+(instancetype)sharedInstance;

-(void)checkVersionUpdate:(UpdateResultHandler)resultHandler;
-(void)checkVersionUpdate:(UpdateResultHandler)resultHandler cancelHandler:(UpdateCancelHandler)cancelHandler;
-(void)checkVersionUpdate:(BOOL)necessary resultHandler:(UpdateResultHandler)resultHandler cancelHandler:(UpdateCancelHandler)cancelHandler;

-(void)getLastVersionInfo:(ReturnValueBlock)returnBlock;

@end
