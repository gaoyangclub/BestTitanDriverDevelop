//
//  BackgroundTimer.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/5.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BackgroundTimer.h"
#import "LocationViewModel.h"

static dispatch_source_t _timer;//timer必须是全局变量handler才会生效

@implementation BackgroundTimer

+(void)start:(NSTimeInterval)timeout{
    if (timeout < 600) {
        timeout = 600;//最小间隔时间必须是600毫秒
    }
    
//    BOOL backgroundAccepted = [[UIApplication sharedApplication] setKeepAliveTimeout:600 handler:^{
//        NSLog(@"startingKeepAliveTimeout");
//        //处理时间只有10秒左右 请在此完成事务 超时后线程阻塞
//        [BackgroundTimer submitLocationPoints];
//    }];//注册一个周期性执行的任务, 而不管是否运行在后台.
//    if (backgroundAccepted)
//    {
//        NSLog(@"VOIP backgrounding accepted");
//    }
    
    NSTimeInterval period = timeout / 1000; //设置时间间隔
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, period * NSEC_PER_SEC);
    dispatch_after(popTime, queue, ^(void){
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
        
        dispatch_source_set_event_handler(_timer, ^{    //在这里执行事件
            [BackgroundTimer submitLocationPoints];
        });
        
        dispatch_resume(_timer);
    });
    
}

+(void)clear{
    if(_timer){//计时器清除
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
//    [[UIApplication sharedApplication] clearKeepAliveTimeout];//清除计时器
}

+(void)submitLocationPoints{//上传轨迹数据
    NSLog(@"开始上传定位数据");
    [LocationViewModel sendLocationPoints];
}

@end
