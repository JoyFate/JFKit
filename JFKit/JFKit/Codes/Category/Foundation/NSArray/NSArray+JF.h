//
//  NSArray+JF.h
//  JFKit
//
//  Created by hudan on 16/9/6.
//  Copyright © 2016年 胡丹. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JF)

/**
 获取数组中对应索引的对象,防止索引越界导致程序崩溃

 @param index 索引值

 @return 数组中索引值对应的对象
 */
- (id)objectAtIndexSafe:(NSUInteger)index;


/**
 追加数组元素

 @param appendArray 追加的内容
 @return 追加后新的数组
 */
- (NSArray *)appendArray:(NSArray *)appendArray;


@end
