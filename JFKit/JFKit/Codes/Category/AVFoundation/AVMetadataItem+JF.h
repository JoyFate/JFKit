//
//  AVMetadataItem+JF.h
//  JFKit
//
//  Created by 胡丹 on 2017/3/6.
//  Copyright © 2017年 胡丹. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface AVMetadataItem (JF)

/**
 将数字的key转化成字符串

 @return 字符串
 */
- (NSString *)keyString;

@end
