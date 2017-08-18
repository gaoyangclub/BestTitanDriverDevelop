//
//  SpeechManager.m
//  BestDriverTitan
//
//  Created by admin on 2017/8/18.
//  Copyright © 2017年 admin. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import "SpeechManager.h"

@interface SpeechManager()

@end

static AVSpeechSynthesizer* synthsizer;

@implementation SpeechManager

+(AVSpeechSynthesizer*)getAVSpeechSynthesizer{
    if (!synthsizer) {
        synthsizer = [[AVSpeechSynthesizer alloc] init];
    }
    return synthsizer;
}

+(void)playSoundString:(NSString *)soundString{
    [SpeechManager playSoundString:soundString speedRate:0.1];
}

+(void)playSoundString:(NSString *)soundString speedRate:(CGFloat)speedRate{
    AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc] initWithString:soundString];//需要转换的文本
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//国家语言
    utterance.rate = speedRate;//声速
    utterance.postUtteranceDelay = 1;//读完后停顿一秒
    [[SpeechManager getAVSpeechSynthesizer] speakUtterance:utterance];
}

+(void)stopSound{//停止语音
    if(synthsizer){
        [synthsizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];//感觉效果一样，对应代理>>>取消
    }
}

+(BOOL)isSpeaking{
    return synthsizer ? synthsizer.isSpeaking : NO;
}



@end
