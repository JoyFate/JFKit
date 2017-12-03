//
//  JFCache.h
//  JFKit
//
//  Created by hudan on 2017/6/27.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JFCache : NSObject

/**
 获取缓存大小

 @return 缓存的大小,单位M
 */
+ (CGFloat)getCacheSize;


/**
 清空缓存(SDWebImage,cache文件夹)
 */
+ (void)clearCaches;


@end
