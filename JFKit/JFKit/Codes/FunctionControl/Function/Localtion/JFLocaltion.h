//
//  JFLocaltion.h
//  JFKit
//
//  Created by hudan on 16/10/13.
//  Copyright © 2016年 hudan. All rights reserved.
//

/**
    定位
 */

#import <Foundation/Foundation.h>

#import "Singleton.h"
#import <MapKit/MapKit.h>

@class JFLocaltion;

@protocol JFLocationDelegate <NSObject>

@optional
// 反地址编码完成后的代理方法
- (void)locationDidReverseInfo:(JFLocaltion *)locationTool;

// POI 搜索结果完成的代理方法
- (void)locationDidFinishPOI:(NSArray<MKMapItem *> *)resultArray;

@end

@interface JFLocaltion : NSObject

SingletonH(JFLocaltion)

@property (nonatomic, copy, readonly) NSString *province;           // 省份
@property (nonatomic, copy, readonly) NSString *city;               // 城市
@property (nonatomic, copy, readonly) NSString *distance;           // 街道
@property (nonatomic, copy, readonly) NSString *locationName;       // 具体位置
@property (nonatomic, strong) CLLocation *currLocation;             // 当前的位置信息

@property (nonatomic, assign) id<JFLocationDelegate> delegate;

/**
 单次定位
 */
- (void)starToGetLocation;

/**
 获取 POI
 
 @param key 关键字
 */
- (void)locationPOIWithKey:(NSString *)key;

/**
 计算两个位置间的距离
 
 @param location1 位置1
 @param location2 位置2
 @return 两个位置的距离(单位 : 米)
 */
+ (CGFloat)caculateDistanceWithLocation1:(CLLocation *)location1 location2:(CLLocation *)location2;

@end
