//
//  JFAudioPlayer.m
//  JFKit
//
//  Created by hudan on 2017/6/7.
//  Copyright © 2017年 i.Jozo. All rights reserved.
//

#import "JFLocalAudioPlayer.h"
#import "JFCommHeader.h"

@interface JFLocalAudioPlayer () <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation JFLocalAudioPlayer

#pragma mark - Public
- (void)playFileWithFieldName:(NSString *)fieldName repeatTimes:(NSUInteger)times
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fieldName ofType:nil];
    if (filePath.length > 0) {
        NSURL *fileURL = [NSURL URLWithString:filePath];
        
        NSError *error;
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&error];
        self.player = player;
        
        if (error) {
#ifdef DEBUG
            NSAssert(NO, error.localizedDescription);
#endif
            return;
        }
        
        player.numberOfLoops = times;
        player.delegate = self;
        
        [player prepareToPlay];
        [player play];
    }
    else {
        DLog(@"招不到播放的文件");
        return;
    }
}

- (void)pause
{
    [self.player pause];
}

- (void)stop
{
    [self.player stop];
}

- (void)play
{
    [self.player play];
}

#pragma mark - AudioPlayer Delegate
// 播放结束
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    if ([self.delegate respondsToSelector:@selector(playerDidFinishPlaying:success:)]) {
        [self.delegate playerDidFinishPlaying:player success:flag];
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    if ([self.delegate respondsToSelector:@selector(playerDecodeErrorDidOccur:error:)]) {
        [self.delegate playerDecodeErrorDidOccur:player error:error];
    }
}

#pragma mark - Setter
- (void)setVolume:(CGFloat)volume
{
    _volume = volume;
    
    self.player.volume = volume;
}

#pragma mark - Getter
- (NSInteger)currentLoopTimes
{
    return self.player.numberOfChannels;
}

- (NSInteger)playDuration
{
    return self.player.duration;
}

@end
