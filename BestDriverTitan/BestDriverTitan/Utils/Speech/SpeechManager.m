//
//  SpeechManager.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/18.
//  Copyright © 2017年 admin. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "SpeechManager.h"

static id<SpeechDataSource> soundSource;

@implementation SpeechManager

+(void)setDataSource:(id<SpeechDataSource>)dataSource{
    soundSource = dataSource;
}

+(void)playSoundString:(NSString *)soundString{
    [soundSource playSoundString:soundString];
}

+(void)stopSound{//停止语音
    [soundSource stopSound];
}

+(BOOL)isSpeaking{
    return soundSource.isSpeaking;
}



@end
