//
//  JMLocationManager.m
//  JMMap
//
//  Created by tiger fly on 2020/3/17.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "JMLocationManager.h"

@interface JMLocationManager ()<CLLocationManagerDelegate>

@end

@implementation JMLocationManager {
    
    CLLocationManager *_locationManager;
    CLLocationCoordinate2D _coordinate2D;
}

+ (JMLocationManager *)manager {
    
    static JMLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JMLocationManager alloc] init];
    });
    return manager;
}

- (id)init {
    
    if (self = [super init]) {
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
        
        // Set a movement threshold for new events.
        _locationManager.distanceFilter = 500;
        
        //请求定位授权
        [_locationManager requestWhenInUseAuthorization];
    }
    return self;
}

/// 是否支持定位
- (BOOL)currentDeviceSupportLocation {
    
    return [CLLocationManager locationServicesEnabled];
}

- (void)startLocation {
    
    [_locationManager startUpdatingLocation];
}

- (void)stopLocation {
    
    [_locationManager stopUpdatingLocation];
}

#pragma mark -- Receiving Location Data from a Service

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (fabs(howRecent) < 15.0) {
       // If the event is recent, do something with it.
        _coordinate2D = location.coordinate;
        if (_delegate && [_delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
            [_delegate locationManager:self didUpdateLocations:locations];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading {
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    
}

- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    
}

- (void)locationManager:(CLLocationManager *)manager
didStartMonitoringForRegion:(CLRegion *)region {
    
}

///// 当前定位坐标
//- (CLLocationCoordinate2D)coordinate {
//
//    CLLocationCoordinate2D _currentCoordinate;
//    while (_coordinate2D.latitude == 0.0) {
//        _currentCoordinate = _coordinate2D;
//    }
//    return _coordinate2D;
//}





@end
