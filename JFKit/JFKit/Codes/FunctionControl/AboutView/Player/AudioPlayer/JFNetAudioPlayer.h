//
//  JFNetAudioPlayer.h
//  JFKit
//
//  Created by hudan on 2017/6/7.
//  Copyright © 2017年 i.Jozo. All rights reserved.
//

/**
    网络音频播放器
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JFNetAudioPlayer : NSObject


- (void)playWithURL:(NSURL *)url repeatTimes:(NSUInteger)times;

@end
