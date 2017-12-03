//
//  JFLocaltion.m
//  JFKit
//
//  Created by hudan on 16/10/13.
//  Copyright © 2016年 hudan. All rights reserved.
//

#import "JFLocaltion.h"

#import <CoreLocation/CoreLocation.h>
#import "JFHUB.h"
#import "JFCommHeader.h"

@interface JFLocaltion () <CLLocationManagerDelegate>

@property (nonatomic, copy) NSString *province;           // 省份
@property (nonatomic, copy) NSString *city;               // 城市
@property (nonatomic, copy) NSString *distance;           // 街道
@property (nonatomic, copy) NSString *locationName;       // 具体位置
@property (nonatomic, assign) BOOL singleLocation;        // 单次定位

@property (nonatomic, strong) CLLocation *firstLocation;  // 第一次记录, 用于 POI 搜索

@property(nonatomic, strong) CLLocationManager *locManager; // 位置管理者
@property(nonatomic, strong) CLGeocoder *geoCoder;   // 用作地理编码、反地理编码的工具类

@end

@implementation JFLocaltion

SingletonM(JFLocaltion)

- (void)starToGetLocation
{
    self.singleLocation = YES;
    
    // 判断定位服务是否开启
    if ([CLLocationManager locationServicesEnabled]) {
        //        [JFProcessHUB showMessage:@"已经开启定位服务，即将开始定位..."];
        
#pragma mark - 开始定位
        // 方法1：标准定位服务（使用位置管理器进行定位）
        // 开始更新位置信息（一旦调用了这个方法, 就会不断的刷新用户位置,然后告诉外界）
        // 以下代码默认只能在前台获取用户的位置信息,如果想要在后台获取用户的位置信息, 那么需要勾选后台模式 location updates
        // 小经验: 如果以后使用位置管理者这个对象, 实现某个服务,可以用startXX开始某个服务，stopXX停止某个服务
        // [self.locationM startUpdatingLocation];
        
        // 方法2：监听重大位置变化的服务(基于基站进行定位)（显著位置变化定位服务）
        //  [self.locationM startMonitoringSignificantLocationChanges];
        
        // 单次定位请求
        // 必须实现代理的定位失败方法
        // 不能与startUpdatingLocation方法同时使用
        [self.locManager requestLocation];
    } else {
        [JFProcessHUB showMessage:@"没有开启定位服务"];
    }
}

// 反地理编码
- (void)reverseLocationWithLocation:(CLLocation *)location
{
    __weak typeof(self) weakself = self;
    
    self.currLocation = location;
    
    // 根据CLLocation对象进行反地理编码
    [self.geoCoder reverseGeocodeLocation:location
                        completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
                            
                            // 防错处理
                            if (error || placemarks.count == 0) {
                                DLog(@"反地理编码错误:%@", error);
                                return;
                            }
                            
                            // 罗列出所有搜索到的地址名称
                            for (CLPlacemark *placemark in placemarks) {
                                DLog(@"所有搜索到的地址名称:%@",placemark.name);
                            }
                            
                            //   一个placemark对应一个地理坐标,包含一个地方的信息(因为可能有多种结果,所有是一个数组,因此要给用户一个列表去选择)
                            CLPlacemark *placemark = [placemarks firstObject]; // 包含区，街道等信息的地标对象
                            
                            weakself.city = placemark.locality;
                            if (!weakself.city) {
                                // 四大直辖市不能通过locality获取
                                weakself.city = placemark.administrativeArea;
                            }
                            weakself.province = placemark.administrativeArea;
                            weakself.distance = placemark.thoroughfare;
                            weakself.locationName = placemark.name;
                            
                            if ([weakself.delegate respondsToSelector:@selector(locationDidReverseInfo:)]) {
                                [weakself.delegate locationDidReverseInfo:weakself];
                            }
                        }];
}

- (void)locationPOIWithKey:(NSString *)key
{
    if (key.length == 0) {
#ifdef DEBUG
        NSAssert(NO, @"key 不能为空");
#endif
        return;
    }
    
    kWeakSelf(self)
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    
    // 2.1 设置请求检索的关键字
    request.naturalLanguageQuery = key;
    
    // 2.2 设置请求检索的区域范围
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.firstLocation.coordinate, 2000, 2000);
    
    request.region = region;
    
    // 3. 根据请求创建检索对象
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    
    // 4. 使用检索对象, 检索对象
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil) {
            // 响应对象MKLocalSearchResponse,里面存储着检索出来的"地图项",每个地图项中有包含位置信息, 商家信息等
            //            [response.mapItems enumerateObjectsUsingBlock:^(MKMapItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //                // 遍历所有的关键字搜到的结果的名称
            //                NSLog(@"%@",obj.name);  // 最多只能打印10条数据
            //            }];
            
            if ([weakself.delegate respondsToSelector:@selector(locationDidFinishPOI:)]) {
                [self.delegate locationDidFinishPOI:response.mapItems];
            }
        }
    }];
}

#pragma mark - 代理方法：当位置管理器获取到用户位置后，就会调用此方法
// 参数: (manager:位置管理者) (locations: 位置对象数组)
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    if (self.singleLocation) {
        self.singleLocation = NO;
    }
    
    CLLocation *location = [locations objectAtIndex:0];
    [self reverseLocationWithLocation:location];
    
    self.firstLocation = location;
    
    // 停止定位(代理方法一直调用,会非常耗电，除非特殊需求，如导航）
    // 只想获取一次用户位置信息,那么在获取到位置信息之后,停止更新用户的位置信息
    // 应用场景: 获取用户所在城市
    [manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    DLog(@"定位失败");
}

#pragma mark - 代理方法：当用户授权状态发生变化时调用
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    switch (status) {
            
        case kCLAuthorizationStatusNotDetermined:{
            DLog(@"1.用户还未决定");
            break;
        }
        case kCLAuthorizationStatusRestricted:{
            DLog(@"2.访问受限(苹果预留选项,暂时没用)");
            break;
        }
            // 定位关闭时 and 对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:{
            // 定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled]){
                DLog(@"3.定位服务是开启状态，需要手动授权，即将跳转设置界面");
                // 在此处, 应该提醒用户给此应用授权, 并跳转到"设置"界面让用户进行授权在iOS8.0之后跳转到"设置"界面代码
                NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                
                if([[UIApplication sharedApplication] canOpenURL:settingURL]){
                    
                    //  [[UIApplication sharedApplication] openURL:settingURL]; // 方法过期
                    
                    [[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:^(BOOL success) {
                        DLog(@"已经成功跳转到设置界面");
                    }];
                }
                else{
                    DLog(@"定位关闭，不可用");
                }
                break;
            }
        case kCLAuthorizationStatusAuthorizedAlways:{
            DLog(@"4.获取前后台定位授权");
            break;
        }
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            DLog(@"5.获得前台定位授权");
            break;
        }
        default:
            break;
        }
    }
}

+ (CGFloat)caculateDistanceWithLocation1:(CLLocation *)location1 location2:(CLLocation *)location2
{
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    return distance;
}

#pragma mark -Getter
- (CLLocationManager *)locManager {
    if (!_locManager) {
        // 1. 创建位置管理者（需要强引用，否则一出现就会消失）强引用后，UI控件创建时会添加到subviews数组里,作用域结束时也不会释放
        _locManager = [[CLLocationManager alloc] init];
        
        // 2. 设置代理, 接收位置数据（其他方式：block、通知）
        _locManager.delegate = self;
        
        // 3. 请求用户授权 --- ios8之后才有(配置info.plist文件)
        
        if ([_locManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            
            [_locManager requestAlwaysAuthorization];//持续授权
            [_locManager requestWhenInUseAuthorization];//使用期间授权
        }
        
        
        // 4. 设置定位的过滤距离(单位:米), 表示用户位置移动了x米时调用对应的代理方法
        // 本次定位 与 上次定位 位置之间的物理距离 > 下面设置的数值时,就会通过代理,将当前位置告诉外界
        _locManager.distanceFilter = 500; //在用户位置改变500米时调用一次代理方法
        
        // 5. 设置定位的精确度 (单位:米),（定位精确度越高, 越耗电, 定位的速度越慢）
        // _locationM.desiredAccuracy = 100; // 当用户在100米范围内，系统会默认将100米范围内都当作一个位置
        _locManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    }
    return _locManager;
}

- (CLGeocoder *)geoCoder {
    if (!_geoCoder) {
        _geoCoder = [[CLGeocoder alloc] init];
    }
    return _geoCoder;
}

//- (CLLocation *)currLocation
//{
//    if (!_currLocation) {
//        CGFloat latitude = [[JFUserManager getUserInfoForKey:kDMUserLocLatitude] floatValue];
//        CGFloat longitude = [[JFUserManager getUserInfoForKey:kDMUserLocLongitude] floatValue];
//        _currLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
//    }
//    return _currLocation;
//}

@end
