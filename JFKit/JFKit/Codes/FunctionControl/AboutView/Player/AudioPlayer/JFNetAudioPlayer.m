//
//  JFNetAudioPlayer.m
//  JFKit
//
//  Created by hudan on 2017/6/7.
//  Copyright © 2017年 i.Jozo. All rights reserved.
//

#import "JFNetAudioPlayer.h"

@interface JFNetAudioPlayer ()

@property (nonatomic, strong) AVPlayer *player;

@end

@implementation JFNetAudioPlayer

- (void)playWithURL:(NSURL *)url repeatTimes:(NSUInteger)times
{
    AVPlayerItem *songItem = [[AVPlayerItem alloc] initWithURL:url];
    AVPlayer *player = [[AVPlayer alloc] initWithPlayerItem:songItem];
    
    [player play];
}

@end
