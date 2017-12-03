//
//  NSUserDefaults+JF.m
//  ZhongYouShangLian
//
//  Created by joyFate on 2017/3/22.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import "NSUserDefaults+JF.h"

@implementation NSUserDefaults (JF)

- (id)jf_objectForKey:(NSString *)defaultName
{
    id result = [self objectForKey:defaultName];
    
    if (result == NULL || result == nil) {
        result = @"";
    }
    
    return result;
}

@end
