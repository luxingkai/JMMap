//
//  JMLocationManager.h
//  JMMap
//
//  Created by tiger fly on 2020/3/17.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@class JMLocationManager;
@protocol JMLocationManagerDelegate <NSObject>

@optional
- (void)locationManager:(JMLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations;
@end

/// 定位管理器
@interface JMLocationManager : NSObject

+ (JMLocationManager *)manager;

@property (nonatomic, weak) id<JMLocationManagerDelegate>delegate;

/// 当前设备是否支持定位服务
- (BOOL)currentDeviceSupportLocation;




@end

NS_ASSUME_NONNULL_END
