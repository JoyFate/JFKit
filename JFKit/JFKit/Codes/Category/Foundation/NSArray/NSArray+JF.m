//
//  NSArray+JF.m
//  JFKit
//
//  Created by hudan on 16/9/6.
//  Copyright © 2016年 胡丹. All rights reserved.
//

#import "NSArray+JF.h"
#import "NSMutableArray+JF.h"

@implementation NSArray (JF)

- (id)objectAtIndexSafe:(NSUInteger)index
{
    if (index > [self count] - 1) {
#ifdef DEBUG
        NSAssert(NO, @"索引值越界了!");
#endif
        return nil;
    }
    else {
        return [self objectAtIndex:index];
    }
}


- (NSArray *)appendArray:(NSArray *)appendArray
{
    if (!appendArray) {
#ifdef DEBUG
        NSAssert(NO, @"追加的数组不能为空");
#endif
        return self;
    }
    
    if ([appendArray isKindOfClass:[NSArray class]]) {
        
        NSMutableArray *tmpArray = [NSMutableArray arrayWithArray:self];
        
        for (id element in appendArray) {
            [tmpArray addObjectSafe:element];
        }
        
        return [tmpArray copy];
    }
    else {
        return appendArray;
    }
}

@end
