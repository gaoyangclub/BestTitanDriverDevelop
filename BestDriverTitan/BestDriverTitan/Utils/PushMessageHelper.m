//
//  PushMessageHelper.m
//  BestDriverTitan
//
//  Created by admin on 2017/10/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PushMessageHelper.h"
#import "SpeechManager.h"

static NSCache* pushMessageCache;

@implementation PushMessageHelper

+(void)load{
    pushMessageCache = [[NSCache alloc]init];
}

+(void)start{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(eventMessage:)
                                                 name:EVENT_REFRESH_SHIPMENTS
                                               object:nil];
}

+(void)stop{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:EVENT_REFRESH_SHIPMENTS object:nil];
    [PushMessageHelper clear];
}

+(void)clear{
    [pushMessageCache removeAllObjects];//清除掉所有
}

+(void)eventMessage:(NSNotification*)eventData{
    AppPushMsg* pushMsg = eventData.object;
    if ([pushMsg.type isEqualToString: PUSH_TYPE_CREATE]) {
        [SpeechManager playSoundString:
         ConcatStrings(@"您有新的",[LocalBundleManager getAppName],@"调度任务，请及时查收")
         ];//播放语音提示
    }else{
        [SpeechManager playSoundString:pushMsg.msg];//播放语音提示
    }
    [PushMessageHelper addLocalNotification:pushMsg.msg];
    
    [pushMessageCache setObject:pushMsg forKey:[NSString stringWithFormat:@"%ld",pushMsg.shipmentId]];//存储起来
}

+(AppPushMsg*)getPushMsgByLinkId:(long)linkId{
    NSString* pushKey = [NSString stringWithFormat:@"%ld",linkId];
    return [pushMessageCache objectForKey:pushKey];
}

+(BOOL)setPushMessageIsRead:(long)linkId{//设成已读
    AppPushMsg* pushMsg = [PushMessageHelper getPushMsgByLinkId:linkId];
    if (pushMsg && !pushMsg.isRead) {
        pushMsg.isRead = YES;
        return YES;
    }
    return NO;//设置失败
}

#pragma mark 添加本地通知
+(void)addLocalNotification:(NSString*)msg{
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.alertBody = msg;
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0.1]; // 3秒钟后
    
    //--------------------可选属性------------------------------
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.2) {
    //        localNotification.alertTitle = @"推送通知提示标题：alertTitle"; // iOS8.2
    //    }
    
    // 锁屏时在推送消息的最下方显示设置的提示字符串
    localNotification.alertAction = @"查看";//滑动来+查看
    
    // 当点击推送通知消息时，首先显示启动图片，然后再打开App, 默认是直接打开App的
    localNotification.alertLaunchImage = @"splashLogo.png";
    
    // 默认是没有任何声音的 UILocalNotificationDefaultSoundName：声音类似于震动的声音
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    // 传递参数
    //    localNotification.userInfo = @{@"type": @"1"};
    
    //重复间隔：类似于定时器，每隔一段时间就发送通知
    //  localNotification.repeatInterval = kCFCalendarUnitSecond;
    
    //    localNotification.category = @"choose"; // 附加操作
    
    // 定时发送
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
