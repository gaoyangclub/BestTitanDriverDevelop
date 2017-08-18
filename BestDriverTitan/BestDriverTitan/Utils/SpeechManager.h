//
//  SpeechManager.h
//  BestDriverTitan
//
//  Created by admin on 2017/8/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpeechManager : NSObject

+(void)playSoundString:(NSString *)soundString;
+(void)playSoundString:(NSString *)soundString speedRate:(CGFloat)speedRate;

+(void)stopSound;

+(BOOL)isSpeaking;//检查正在播放

@end
