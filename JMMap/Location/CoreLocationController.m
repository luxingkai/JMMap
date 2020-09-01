//
//  CoreLocationController.m
//  JMMap
//
//  Created by tigerfly on 2020/9/1.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "CoreLocationController.h"

@interface CoreLocationController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) CLGeocoder *geocoder;

@end

@implementation CoreLocationController {
    
    UILabel *_addressLab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _addressLab = [UILabel new];
    _addressLab.frame = CGRectMake(10, 100, self.view.frame.size.width - 20, 100);
    _addressLab.textAlignment = NSTextAlignmentCenter;
    _addressLab.numberOfLines = 0;
    [self.view addSubview:_addressLab];
    
    
#pragma mark -- Essentials
    
    /* Adding Location Services to Your App
     
     To add location services to your app, you use CLLocationManager, implement
     its delegate, and decide the authorization mode your app requires. When your
     app runs, it should check if the device supports location services, configure
     and start the desired location services, and request authorization to receive
     the user's location. Once authorized, your app receives location events for
     the Core Location services it requests.
     */
    
    /*
     Determine if the User's Device Supports Location services
     
     Core Location services require hardware that may not be present on every device.
     Before relying on any specific location service, check if the device supports the
     service by calling the methods of the CLLocationManager object.
     
     Method                                             Description
     significantLocation                        Indicates whether the device supports
     ChangeMonitoring                           getting a user's location with the significant
     Avaiable()                                 change loaction service.
     
     isMonitoring                               indicates whether the device supports region monitoring
     Available(for:)                            to detect entry into or exit from geographic regions or
     beacon regions.
     
     headingAvailable()                         indicates whether the device is able to provide compass-
     related headings.
     
     isRangingAvailable()                       Indicates the device supports obtaining the relative
     distance to a nearby iBeacon device.
     */
    
    /*
     Create teh Location Manager and Delegate
     
     Create an instance of the CLLocationManager class and store a strong reference to
     it somewhere in your app. You must keep a strong reference to the Location Manager
     object until all tasks involving that object complete. Because most location manager
     tasks run asynchronously, storing your location manager in a local variable is insufficient.
     
     Assign a custom object to the delegate property, conforming to the CLLocationManager
     Delegate protocol. Assign the delegate before starting any location services. The system
     calls your delegate object's methods from the thread in which your started the corresponding
     location services. That thread must itself have an active run loop, like the one found in
     your app's main thread.
     */
    
    /*
     Handle Errors in the Delegate Methods
     
     Implement the failure-related methods in the delgate to fail gracefully when
     location services are not available on a device. If you try to start an
     unavailable services, the CLLocationManager object calls one of the failure-
     related methods of its delegate. For example, if region monitoring is unavailable,
     the object calls the locationManager(_:monitoringDidFailFor:withError:)method.
     You may want to update the UI in your app when specific location services are
     not available.
     */
    
    /*
     Ask for Authorization and Handle changes
     
     Determine the authorization status your app needs. Ask for authorization to use
     location services when your users access location related functionality in your
     app.
     
     Implement your delegate's locationManager(_:didChangeAuthorization:), which the
     system calls as soon as your app creates the location manager, and any time your
     app's authorization status changes. Use this method to respond to changes in your
     app's authorization status and perform the appropriate actions for each state.
     For example, you may want to turn on or off your app's location features as
     appropriate when authorization changes/
     */
    
    /*
     Start Location Services and Receive Events
     
     You must set the delegate object before you use other methods on your CLLocationManager
     instance. Next, you must:
     •  Call the appropriate method in CLLocaitonManager to start the delivery of events.
     •  Receive location and heading related updates in the associated delegate object.
     •  Call the appropriate method in CLLocationManager to stop the service when your
     app no longer needs to receive the location events.
     
     For the services you use, configure any properties associated with that service
     accurately. Core Location manages power aggressively by turning off hardware when
     it's not needed. For example, setting the desired accuracy for location events to
     one kilometer gives the location manager the flexibility to turn off GPS hardware
     and rely solely on the Wifi or cell radios, which can lead to significant power
     savings.
     */
    
    
    // 检测是否具备定位的相关能力
    if ([CLLocationManager significantLocationChangeMonitoringAvailable]) {
        NSLog(@"定位服务的重要改变是否可以在当前设备使用 %d",[CLLocationManager significantLocationChangeMonitoringAvailable]);
    };
    if ([CLLocationManager headingAvailable]) {
        NSLog(@"定位服务中的指定方向是否可以在当前设备使用 %d",[CLLocationManager headingAvailable]);
    }
    if ([CLLocationManager isMonitoringAvailableForClass:[UIViewController class]]) {
        NSLog(@"当前设备是否支持地区监控 %d",[CLLocationManager isMonitoringAvailableForClass:[UIViewController class]]);
    }
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"当前设备是否支持定位服务 %d",[CLLocationManager locationServicesEnabled]);
    }else {
        return;
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
    
    //地理编码
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
    
    
#pragma mark -- Authorization
    
#pragma mark -- Location Updates
    
#pragma mark -- Region Monitoring
    
#pragma mark -- iBeacon
    
#pragma mark -- Compass Headings
    
#pragma mark -- Geocoding (地理编码和反编码)
    
    /*
     Converting Between Coordinates and User-Friendly Place Names
     
     The CLLocationManager object reports locations as a latitude/longitude pair.
     While these values uniquely represent any location on the planet, they are not
     values that users immediately associate with the location. Users are more familiar
     with names that describle a location, such as street names or city names. The CLGeocoder
     class lets you convert between geographic coordinates and the user-friendly names
     associated with that location. You can convert from either a latitude/longitude
     pair to a user friendly place name, or the other way around.
     
     User place names are represented by a CLPlacemark object, which contains properties
     for specifying the street name, city name, country name, postal code, and many others.
     Placemarks also contain properties describing relevant geographics features or points
     of interest at the location, such as the names of mountainsm rivers, businesses, or
     landmarks.
     
     Geocoder objects are one-shot objects- that is, you use each object to make a single
     conversion. You can create multiple geocoder objects and perform multiple conversions,
     but Apple rate limits the number of conversions you can perform. Making too many requests
     in a short period of time may cause some of those requests to fail. For tips on how to
     manage any conversions.
     */
    
    /*
     CLGeocoder
     
     The CLGeocoder class provides services for converting between a coordinate (specified as
     a latitude and longitude) and the user-friendly representation of that coordinate. A
     user-friendly representation of the coordinate typically consists of the street, city,
     state, and country information corresponding to the given location, but it may also
     contain a relevant point of interest, landmarks, or other identifying information.
     A geocoder object is a single-shot object that works with a network-based service to look
     up placemark information for its specified coordinate value.
     
     To user a geocoder object, you create it and call one of its forward- or reverse-geocoding
     methods to begin the request. Reverse-geocoding requests take a latitude and longitude value
     and find a user-readable address. Forward-geocoding requests take a user-readable address
     and find the corresponding latitude and longitude value. Forward-geocoding requests may
     also return additional information about the specified location, such as a point of interest
     or building at the location. For both types of request, the results are returned using a
     CLPlacemark object. In the case of forward-geocoding requests,multiple placemark objects
     may be returned if the provided information yielded multiple possible locations.
     
     To make smart decisions about what types of information to return, the geocoder server
     uses all the information provided to it when processing the request. For example, if the
     user is moving quickly along a highway, it might return the name of the overall region,
     and not the name of a small park that the user is passing through.
     */
        
    /*
     Tips for Using a Geocoder Object
     
     Apps must be conscious of how they use geocoding. Geocoding requests are rate-limited for
     each app, so making too many requests in a short period of time may cause some of the
     requests to fail. (When the maximum rate i exceeded, the geocoder returns an error object
     with the CLError.Code.network error to the associated completion handler.) Here are some
     rules of thumb for using this class effectively:
     •  Send at most one geocoding request for any one uesr action.
     •  If the user performs multiple actions that involve geocoding the same location, reuse
        the results from the initial geocoding request instead of starting individual requests
        for each action.
     •  When you want to update the user's current location automatically(such as when the user
        is moving), issue new geocoding requests only when the user has moved a signification
        distance and after a reasonable amount of time has passed. For example, in a typical
        situation, you should not send more than one geocoding request per minute.
     •  Do not start a geocoding request at a time when the user will not see the results immediately.
        For example, do not start a request if your application is inactive or in the background.
     The computer or device must have access to the network in order for the geocoder object to
     return detailed placemark information. Although, the geocoder stores enough information locally
     to report the localized country name and ISO country code for many locations. If country
     information is not available for a specific location, the geocoder may still report an
     error to your completion block.
     */
    
    
#pragma mark -- Errors
    
    
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
    CLLocation *location = locations.firstObject;
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
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        CLPlacemark *placeMark = placemarks.firstObject;
        NSLog(@"name %@",placeMark.name);
        NSLog(@"thoroughfare %@",placeMark.thoroughfare);
        NSLog(@"subThoroughfare %@",placeMark.subThoroughfare);
        NSLog(@"locality %@",placeMark.locality);
        NSLog(@"subLocality %@",placeMark.subLocality);
        NSLog(@"administrativeArea %@",placeMark.administrativeArea);
        NSLog(@"subAdministrativeArea %@",placeMark.subAdministrativeArea);
        NSLog(@"postalCode %@",placeMark.postalCode);
        NSLog(@"ISOcountryCode %@",placeMark.ISOcountryCode);
        NSLog(@"country %@",placeMark.country);
        NSLog(@"inlandWater %@",placeMark.inlandWater);
        NSLog(@"ocean %@",placeMark.ocean);
        NSLog(@"areasOfInterest %@",placeMark.areasOfInterest);
        NSLog(@"postalAddress %@",placeMark.postalAddress);
        
        _addressLab.text = [NSString stringWithFormat:@"%@-%@-%@-%@-%@-%@",placeMark.country,placeMark.administrativeArea,placeMark.locality,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
    }];
    
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
















/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
