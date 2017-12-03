//
//  JFAreaModel.h
//  JFKit
//
//  Created by hudan on 17/1/9.
//  Copyright © 2017年 hudan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFAreaModel : NSObject<NSCopying>

@property (nonatomic, copy) NSString *areaCode;     // id
@property (nonatomic, copy) NSString *areaName;     // 显示名称

- (void)setValueWithArray:(NSArray *)array;

@end
