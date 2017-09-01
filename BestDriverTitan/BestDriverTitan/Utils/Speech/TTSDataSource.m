//
//  TTSDataSource.m
//  BestDriverTitan
//
//  Created by admin on 2017/9/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TTSDataSource.h"
#import "TTSConfig.h"

@interface TTSDataSource()//<IFlySpeechSynthesizerDelegate>
@end

static IFlySpeechSynthesizer * iFlySpeechSynthesizer;

@implementation TTSDataSource

+(IFlySpeechSynthesizer*)getFlySpeechSynthesizer{
    if (!iFlySpeechSynthesizer) {
        //简单配置一个AVAudioSession以便可以在后台播放声音，更多细节参考AVFoundation官方文档
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setCategory:AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionDuckOthers error:NULL];
        
        //Appid是应用的身份信息，具有唯一性，初始化时必须要传入Appid。
        NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", FLY_APIKEY];
        [IFlySpeechUtility createUtility:initString];
        
        iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
        
//        iFlySpeechSynthesizer.delegate = self;
//        TTSConfig *instance = [TTSConfig sharedInstance];
//        //设置语速1-100
//        [iFlySpeechSynthesizer setParameter:instance.speed forKey:[IFlySpeechConstant SPEED]];
//        //设置音量1-100
//        [iFlySpeechSynthesizer setParameter:instance.volume forKey:[IFlySpeechConstant VOLUME]];
//        //设置音调1-100
//        [iFlySpeechSynthesizer setParameter:instance.pitch forKey:[IFlySpeechConstant PITCH]];
//        //设置采样率
//        [iFlySpeechSynthesizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
//        //设置发音人
//        [iFlySpeechSynthesizer setParameter:instance.vcnName forKey:[IFlySpeechConstant VOICE_NAME]];
//        //设置文本编码格式
//        [iFlySpeechSynthesizer setParameter:@"unicode" forKey:[IFlySpeechConstant TEXT_ENCODING]];
        
        //设置协议委托对象
//        iFlySpeechSynthesizer.delegate = self;
        //设置合成参数
        //设置在线工作方式
        [iFlySpeechSynthesizer setParameter:[IFlySpeechConstant TYPE_CLOUD]
                                      forKey:[IFlySpeechConstant ENGINE_TYPE]];
        //设置音量，取值范围 0~100
        [iFlySpeechSynthesizer setParameter:@"50"
                                      forKey: [IFlySpeechConstant VOLUME]];
        //发音人，默认为”xiaoyan”，可以设置的参数列表可参考“合成发音人列表”
        [iFlySpeechSynthesizer setParameter:@" xiaoyan "
                                      forKey: [IFlySpeechConstant VOICE_NAME]];
        //保存合成文件名，如不再需要，设置为nil或者为空表示取消，默认目录位于library/cache下
        [iFlySpeechSynthesizer setParameter:@" tts.pcm"
                                      forKey: [IFlySpeechConstant TTS_AUDIO_PATH]];
    }
    return iFlySpeechSynthesizer;
}

-(void)playSoundString:(NSString *)soundString{
    if ([self isSpeaking])
    {
        [self stopSound];
    }
    [[TTSDataSource getFlySpeechSynthesizer] startSpeaking:soundString];
}

-(void)stopSound{
    if(iFlySpeechSynthesizer){
        [iFlySpeechSynthesizer stopSpeaking];
    }
}

-(BOOL)isSpeaking{
    return iFlySpeechSynthesizer ? iFlySpeechSynthesizer.isSpeaking : NO;
}


@end
