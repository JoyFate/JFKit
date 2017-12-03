//
//  JFAudioPlayer.h
//  JFKit
//
//  Created by joyFate on 2017/6/7.
//  Copyright © 2017年 i.Jozo. All rights reserved.
//

/**
    本地音频播放器
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol JFLocalAudioPlayerDelegate <NSObject>

@optional

/**
 音频文件播放结束

 @param player 当前播放器
 @param isSuccess 是否成功
 */
- (void)playerDidFinishPlaying:(AVAudioPlayer *)player success:(BOOL)isSuccess;

/**
 音频文件解码错误

 @param player 当前播放器
 @param error 错误
 */
- (void)playerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error;

@end


@interface JFLocalAudioPlayer : NSObject

@property (nonatomic, assign, readonly) NSInteger currentLoopTimes;       // 当前循环次数
@property (nonatomic, assign, readonly) NSInteger playDuration;           // 播放持续时间
@property (nonatomic, assign) CGFloat volume;                             // 播放音量大小

@property (nonatomic, weak) id<JFLocalAudioPlayerDelegate> delegate;

/**
 播放本地音频文件, 可定义重复次数

 @param fieldName 音频文件名
 @param times 重复次数, 0 为无限重复
 */
- (void)playFileWithFieldName:(NSString *)fieldName repeatTimes:(NSUInteger)times;

/**
 暂停
 */
- (void)pause;

/**
 停止
 */
- (void)stop;

/**
 播放
 */
- (void)play;

@end
