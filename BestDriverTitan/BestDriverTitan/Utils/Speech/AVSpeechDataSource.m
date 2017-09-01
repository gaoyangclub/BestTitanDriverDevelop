//
//  AVSpeechDataSource.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "AVSpeechDataSource.h"

static AVSpeechSynthesizer* synthsizer;

@implementation AVSpeechDataSource

+(AVSpeechSynthesizer*)getAVSpeechSynthesizer{
    if (!synthsizer) {
        //简单配置一个AVAudioSession以便可以在后台播放声音，更多细节参考AVFoundation官方文档
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:NULL];
        
        synthsizer = [[AVSpeechSynthesizer alloc] init];
    }
    return synthsizer;
}

-(void)playSoundString:(NSString *)soundString{
    CGFloat speedRate = 0.45;
    //iOS语音合成在iOS8及以下版本系统上语速异常
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)
    {
        speedRate = 0.25;//iOS7设置为0.25
    }
    else if ([[[UIDevice currentDevice] systemVersion] floatValue] < 9.0)
    {
        speedRate = 0.15;//iOS8设置为0.15
    }
    AVSpeechUtterance * utterance = [[AVSpeechUtterance alloc] initWithString:soundString];//需要转换的文本
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//国家语言
    utterance.rate = speedRate;//声速
    //    utterance.postUtteranceDelay = 1;//读完后停顿一秒
    if ([self isSpeaking])
    {
        [self stopSound];
    }
    [[AVSpeechDataSource getAVSpeechSynthesizer] speakUtterance:utterance];
}

-(void)stopSound{
    if(synthsizer){
        [synthsizer stopSpeakingAtBoundary:AVSpeechBoundaryWord];//感觉效果一样，对应代理>>>取消
    }
}

-(BOOL)isSpeaking{
    return synthsizer ? synthsizer.isSpeaking : NO;
}

@end
