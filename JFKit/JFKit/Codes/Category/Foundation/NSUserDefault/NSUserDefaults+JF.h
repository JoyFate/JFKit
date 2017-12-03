//
//  NSUserDefaults+JF.h
//  ZhongYouShangLian
//
//  Created by joyFate on 2017/3/22.
//  Copyright © 2017年 JoyFate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (JF)

#define JFUserDefaults [NSUserDefaults standardUserDefaults]

- (id)jf_objectForKey:(NSString *)defaultName;

@end
