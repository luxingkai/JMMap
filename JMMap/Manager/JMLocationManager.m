//
//  JMLocationManager.m
//  JMMap
//
//  Created by tiger fly on 2020/3/17.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "JMLocationManager.h"

@interface JMLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;

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
        
        // 检测是否具备定位的相关能力
        if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
            NSLog(@"定位服务的重要改变是否可以在当前设备使用 %d",[CLLocationManager significantLocationChangeMonitoringAvailable]);
        };
        if ([CLLocationManager headingAvailable]) {
            NSLog(@"定位服务中的指定方向是否可以在当前设备使用 %d",[CLLocationManager headingAvailable]);
        }
        //        if ([CLLocationManager isMonitoringAvailableForClass:[UIViewController class]]) {
        //            NSLog(@"当前设备是否支持地区监控 %d",[CLLocationManager isMonitoringAvailableForClass:[UIViewController class]]);
        //        }
        if ([CLLocationManager locationServicesEnabled]) {
            NSLog(@"当前设备是否支持定位服务 %d",[CLLocationManager locationServicesEnabled]);
        }else {
            return nil;
        }
        
        // 定位管理对象
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        // 初始化定位更新
        self.locationManager.pausesLocationUpdatesAutomatically = YES;
        self.locationManager.allowsBackgroundLocationUpdates = YES;
        self.locationManager.showsBackgroundLocationIndicator = YES;
        self.locationManager.distanceFilter = CLLocationDistanceMax;
        self.locationManager.desiredAccuracy = 10.0;
        self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        
        // 地理编码
        self.geocoder = [[CLGeocoder alloc] init];
        
        // 请求定位授权
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        }else {
            //请求授权
            [self.locationManager requestWhenInUseAuthorization];
        }
        
        // 初始化重要的定位更新
        //    [locationManager startMonitoringSignificantLocationChanges];
        //    [locationManager stopMonitoringSignificantLocationChanges];
        
        
        // 初始化方向更新
        //    [locationManager startUpdatingHeading];
        //    [locationManager stopUpdatingHeading];
        //    [locationManager dismissHeadingCalibrationDisplay];
        //    locationManager.headingFilter = kCLHeadingFilterNone;
        //    locationManager.headingOrientation = CLDeviceOrientationPortrait;
        
        
        // 初始化地区监控
        //    CLCircularRegion *circularRegion = [CLCircularRegion alloc] initWithCenter:<#(CLLocationCoordinate2D)#> radius:<#(CLLocationDistance)#> identifier:<#(nonnull NSString *)#>;
        //    locationManager startMonitoringForRegion:<#(nonnull CLRegion *)#>
        
        
        // 初始化信号范围请求
        //    locationManager requestStateForRegion:<#(nonnull CLRegion *)#>
        //    locationManager startRangingBeaconsSatisfyingConstraint:<#(nonnull CLBeaconIdentityConstraint *)#>
        //    [locationManager rangedBeaconConstraints];
        
        
        // 初始化访问事件更新
        //    [locationManager startMonitoringVisits];
        //    [locationManager stopUpdatingHeading];
        
        
        // 获取最近的提取数据
        //    CLLocation *location = locationManager.location;
        //    NSLog(@"latitude %f",location.coordinate.latitude);
        //    NSLog(@"longitude %f",location.coordinate.longitude);
        //    NSLog(@"altitude %f",location.altitude);
        //    NSLog(@"horizontalAccuracy %f",location.horizontalAccuracy);
        //    NSLog(@"verticalAccuracy %f",location.verticalAccuracy);
        //    NSLog(@"course %f",location.course);
        //    NSLog(@"courseAccuracy %f",location.courseAccuracy);
        //    NSLog(@"speed %f",location.speed);
        //    NSLog(@"speedAccuracy %f",location.speedAccuracy);
        //    NSLog(@"timestamp %f",location.timestamp);
        //    NSLog(@"floor.level %f",location.floor.level);
        //
        //    CLHeading *heading = locationManager.heading;
        //    NSLog(@"magneticHeading %f",heading.magneticHeading);
        //    NSLog(@"trueHeading %f",heading.trueHeading);
        //    NSLog(@"headingAccuracy %f",heading.headingAccuracy);
        //    NSLog(@"x %f",heading.x);
        //    NSLog(@"y %f",heading.y);
        //    NSLog(@"z %f",heading.z);
        //    NSLog(@"timestamp %@",heading.timestamp);
        
    }
    return self;
}

/// 是否支持定位
- (BOOL)currentDeviceSupportLocation {
    return [CLLocationManager locationServicesEnabled];
}


#pragma mark -- CLLocationManagerDelegate

/*
 Responding to Authorization Changes
 */
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    //Tells the delegate its authorization status when the app creates the location manager and when the authorization status changes.
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
        case kCLAuthorizationStatusRestricted:
        case kCLAuthorizationStatusDenied:{
            NSLog(@"定位授权失败！");
        }
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:{
            
            [self.locationManager startUpdatingLocation];
        }
            break;
            
        default:
            break;
    }
}

/*
 Handling Errors
 */
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //Tells the delegate that the location manager was unable to retrieve a location value.
    
    NSLog(@"定位出现错误");
}

/*
 Responding to Location Events
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    //Tells the delegate that new location data is available.
    
    if ([self.delegate respondsToSelector:@selector(locationManager:didUpdateLocations:)]) {
        [self.delegate locationManager:self didUpdateLocations:locations];
    }
    
//    CLLocation *location = locations.firstObject;
//    NSLog(@"latitude %f",location.coordinate.latitude);
//    NSLog(@"longitude %f",location.coordinate.longitude);
//    NSLog(@"altitude %f",location.altitude);
//    NSLog(@"horizontalAccuracy %f",location.horizontalAccuracy);
//    NSLog(@"verticalAccuracy %f",location.verticalAccuracy);
//    NSLog(@"course %f",location.course);
//    if (@available(iOS 13.4, *)) {
//        NSLog(@"courseAccuracy %f",location.courseAccuracy);
//    } else {
//        // Fallback on earlier versions
//    }
//    NSLog(@"speed %f",location.speed);
//    NSLog(@"speedAccuracy %f",location.speedAccuracy);
//    NSLog(@"timestamp %@",location.timestamp);
//    NSLog(@"floor.level %ld",(long)location.floor.level);
    
    //获取当前地理坐标通过反编码获取地址信息
//    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        
//        CLPlacemark *placeMark = placemarks.firstObject;
//        NSLog(@"name %@",placeMark.name);
//        NSLog(@"thoroughfare %@",placeMark.thoroughfare);
//        NSLog(@"subThoroughfare %@",placeMark.subThoroughfare);
//        NSLog(@"locality %@",placeMark.locality);
//        NSLog(@"subLocality %@",placeMark.subLocality);
//        NSLog(@"administrativeArea %@",placeMark.administrativeArea);
//        NSLog(@"subAdministrativeArea %@",placeMark.subAdministrativeArea);
//        NSLog(@"postalCode %@",placeMark.postalCode);
//        NSLog(@"ISOcountryCode %@",placeMark.ISOcountryCode);
//        NSLog(@"country %@",placeMark.country);
//        NSLog(@"inlandWater %@",placeMark.inlandWater);
//        NSLog(@"ocean %@",placeMark.ocean);
//        NSLog(@"areasOfInterest %@",placeMark.areasOfInterest);
//        NSLog(@"postalAddress %@",placeMark.postalAddress);
//        
//    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // Tells the delegate that a new location value is available.
    
}

- (void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error {
    //Tells the delegate that updates will no longer be deferred.

}


/*
 Pausing Location Updates
 */
- (void)locationManagerDidPauseLocationUpdates:(CLLocationManager *)manager {
    //Tells the delegate that location updates were paused.
    
}

- (void)locationManagerDidResumeLocationUpdates:(CLLocationManager *)manager {
    //Tells the delegate that the delivery of location updates has resumed.
    
}


/*
 Responding to Heading Events
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    //Tells the delegate that the location manager received updated heading information.
    
    
}
- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
    //    Asks the delegate whether the heading calibration alert should be displayed.
    
    return YES;
}


/*
 Responding to Region Events
 */
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    //Tells the delegate that the user entered the specified region.
    
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    //Tells the delegate that the user left the specified region.
    
}
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    //Tells the delegate about the state of the specified region.
    
}
- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    //Tells the delegate that a region monitoring error occurred.
    
}
- (void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region {
    //Tells the delegate that a new region is being monitored.
    
}

/*
 Responding to Ranging Events
 */
- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray<CLBeacon *> *)beacons satisfyingConstraint:(CLBeaconIdentityConstraint *)beaconConstraint {
    //Tells the delegate that a beacon satisfying the constraint was detected.
    
}
- (void)locationManager:(CLLocationManager *)manager didFailRangingBeaconsForConstraint:(CLBeaconIdentityConstraint *)beaconConstraint error:(NSError *)error {
    //Tells the delegate that no beacons were detected that satisfy the constraint.
    
}

/*
 Responding to Visit Events
 */
- (void)locationManager:(CLLocationManager *)manager didVisit:(CLVisit *)visit {
    //Tells the delegate that a new visit-related event was received.
    
}










@end
