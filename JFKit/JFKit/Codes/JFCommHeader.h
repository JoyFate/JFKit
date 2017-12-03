//
//  CommHeader.h
//  JFKit
//
//  Created by joyFate on 16/7/26.
//  Copyright © 2016年 hudan. All rights reserved.
//

#ifndef CommHeader_h
#define CommHeader_h

// release版本去除控制台输出
#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"<%p %@:(%d)> %@", self, [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define DLog( s, ... )
#endif

// 强弱引用
#define kWeakSelf(type)__weak typeof(type)weak##type = type;

#define kStrongSelf(type)__strong typeof(type)type = weak##type;

// 字体
// 粗体
#define kJFFontBoldSystem(FONTSIZE) [UIFont boldSystemFontOfSize:FONTSIZE]

// 系统字体
#define kJFFontSyetem(FONTSIZE) [UIFont systemFontOfSize:FONTSIZE]

// 自定义字体
#define kJFFont(NAME,FONTSIZE) [UIFont fontWithName:(NAME)size:(FONTSIZE)]

#endif /* CommHeader_h */


/**
 ****************** pod file ******************
 
 pod 'AFNetworking', '~> 3.1.0'
 pod 'Masonry', '~> 1.0.1'
 pod 'SDWebImage', '~> 3.7.6'
 pod 'MBProgressHUD', '~> 0.9.2'
 pod 'IQKeyboardManager'
 pod 'MJRefresh', '~> 3.1.12'
 pod 'MJExtension'
 
 */
