//
//  NSDictionary+JF.m
//  ZXBuilding
//
//  Created by hudan on 2017/5/25.
//  Copyright © 2017年 zxwl. All rights reserved.
//

#import "NSDictionary+JF.h"

@implementation NSDictionary (JF)

- (id)objectForKeySafe:(id)aKey
{
    id value = [self objectForKey:aKey];
    
    if (value == [NSNull null] || value == nil) {
        return @"";
    }
    else {
        return value;
    }
}

@end
