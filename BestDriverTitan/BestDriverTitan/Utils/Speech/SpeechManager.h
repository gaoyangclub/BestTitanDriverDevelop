//
//  SpeechManager.h
//  BestDriverTitan
//
//  Created by admin on 2017/8/18.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol SpeechDataSource <NSObject>

-(void)playSoundString:(NSString *)soundString;//播放声音
-(void)stopSound;//停止播放
-(BOOL)isSpeaking;//是否正在播放

@end

@interface SpeechManager : NSObject

//@property (nonatomic, weak) id<SpeechDataSource> dataSource;

+(void)setDataSource:(id<SpeechDataSource>)dataSource;

+(void)playSoundString:(NSString *)soundString;
//+(void)playSoundString:(NSString *)soundString speedRate:(CGFloat)speedRate;

+(void)stopSound;

+(BOOL)isSpeaking;//检查正在播放

@end
