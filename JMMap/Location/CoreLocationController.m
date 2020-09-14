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
     Create the Location Manager and Delegate
     
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
     
     Implement the failure-related methods in the delegate to fail gracefully when
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
    
    /*
     Core Location offers three different services for fetching the uesr's location.
     Each service offers different benefits and comes with different power and authorization
     requirements. You can use a single service or you can use multiple services at different
     times, depending on your needs.
     
     Service            Discription
                        The most power-efficient way to gather location data. This service delivers
                        location updates when the user has spent time in one location and then
     Visit              moves on. Each update includes both the location and the amount of time spent
     location           at that location.
     service
                        This service is not intended for navigation or other real-time activities.
                        Instead, use it to identify patterns in the user's behavior and apply that
                        knowledge to other parts of your app. For example, a music app might prepare
                        a workout playlist when the user leaves the house and heads to gym.
                    
                        
                        A power-friendly alternative for apps that need to track the user's location
                        but do not need frequent updates or the precision offered  by GPS. This service
     Significant        relies on lower-power alternatives to determine the user's location and delivers
     change             updates only When significant changes to that location occur.
     location
     service            You might use this service to deliver suggestions for nearby points of
                        interest when the user is walking.
        
     
                        A configurable, general-purpose solution for getting the user's location
     Standard           in real time. This service uses significantly more power than the other
     location           location services, but it delivers the most accurate and immediate
     service            location information.
                        
                        Use this service only when you really need it, such as when offering
                        navigation instructions or when recording a user's path on the hike.
     
     Always choose the most power-effcient service that serves the needs of your app.
     To help save power, disable location services (or switch to a lower-power alternative)
     when you do not need the location data offered by the service. For example, you might
     disable location services when your app is in the background and would not use that
     data otherwise.
     */
    
//    CLLocation
//    CLLocationCoordinate2D
//    CLFloor
//    CLVisit
    
    
#pragma mark -- Region Monitoring
    
    /*
     Use region monitoring to determine when the user enters or leaves a geographic
     region.
     
     Region monitoring(also known as geofencing) is a way for your app to be alerted
     when the uesr enters or exits a geographical region. You might use region monitoring
     to preform location-related tasks. For example, the Reminders app uses them to
     trigger reminders when the user arrives at or leaves a specified location.
     
     In iOS, regions are monitored by the system, which wakes up your app as needed
     when the user corsses a defined region boundary. In macOS, region monitoring
     works only while the app is running(either in the foreground or background) and
     the user's system is awake. The system does not launch Mac apps to deliver
     region-related notifications.
     */
    
    /*
     Define and Monitor a Geographic Region
     A region is a circular area centered on a geographic coordinate, and you define one using
     a CLCircularRegion object. The radius of the region object defines its boundary.
     You define the regions you want to monitor and register them with the system by
     calling the startMonitoring(for:) method of your CLLocationManager object.
     The system monitors your regions until you explicitly ask it to stop or until the
     device reboots.

     Listing 1 shows how to configure and register a region centered around a point
     provided by the caller of the method. The method uses the largest allowed radius
     to define the boundaries of the region and asks that the system deliver
     notifications only when the user enters the region.
     
     Tip
     Regions are shared resources that rely on specific hardware capabilities.
     To ensure that all apps can participate in region monitoring, Core Location
     prevents any single app from monitoring more than 20 regions simultaneously.
     To work around this limitation, monitor only regions that are close to the
     user’s current location. As the user moves, update the list based on the user’s new location.
     */
    
    /*
     Handle a Region-Related Notification
     Whenever the user crosses the boundary of one of your app's registered regions,
     the system notifies your app. If an iOS app is not running when the boundary
     crossing occurs, the system tries to launch it. An iOS app that supports region
     monitoring must enable the Location updates background mode so that it can be
     launched in the background.

     Boundary crossing notifications are delivered to your location manager's
     delegate object. Specifically, the location manager calls the locationManager(_:didEnterRegion:)
     or locationManager(_:didExitRegion:) methods of its delegate. If your app was launched,
     you must configure a CLLocationManager object and delegate object right away so
     that you can receive these notifications. To determine whether your app was
     launched for a location event, look for the UIApplication.LaunchOptionsKey in
     the launch options dictionary.

     When determining whether a boundary crossing happened, the system waits to be
     sure before sending the notification. Specifically, the user must travel a
     minimum distance over the boundary and remain on the same side of the boundary
     for at least 20 seconds. These conditions help eliminate spurious calls to
     your delegate object’s methods.

     Listing 2 shows a delegate method that is called when the user enters a
     registered region. Regions have an associated identifier, which this method
     uses to look up information related to the region and perform the associated action.
     */
    
    
    
#pragma mark -- iBeacon
    
    /*
     
     */
    
    
    
#pragma mark -- Compass Headings
    
    /*
     Getting Heading and Course Information
     
     Heading and course information are commonly used by navigation apps to help
     guide the user to a destination. The heading of a user’s device is its current
     orientation relative to magnetic or true north. Devices with GPS can report
     course information, which represents the direction in which the device is moving.
     The Compass app in iOS uses heading information to implement a magnetic compass
     interface, as shown in Figure 1. Augmented reality apps might use this information
     to determine which direction the user is facing.
     
     Get the Current Heading
     
     You use heading information to determine the current orientation of the
     user’s device. For example, an augmented reality app might use the current
     heading to help determine what information to show on the user’s screen.
     Headings are usually reported relative to the top of the device, but you can
     configure how values are reported using the headingOrientation property of
     your CLLocationManager object.

     After determining whether heading information is available, call the
     startUpdatingHeading() method of your CLLocationManager object to begin
     the delivery of heading updates. The location manager delivers updates
     to the locationManager(_:didUpdateHeading:) method of its delegate whenever
     the heading information changes.
     
     Note

     Heading information is available only on devices with a built-in
     magnetometer;it’s not available in iOS Simulator. The magnetometer determines
     a device’s orientation relative to magnetic north. When location data is
     available, Core Location also reports the device’s orientation relative to true north.
     
     
     Get Course Information
     Course information reflects the speed and direction in which a device is
     moving and is available only on devices with GPS hardware. Don’t confuse
     course information with heading information. Course direction reflects
     the direction in which the device is moving and is independent of the
     device’s physical orientation. The most common use of course information
     is in navigation apps.

     
     Course information is included automatically in CLLocation objects delivered
     to your app as part of its location updates. When enough location data has
     been gathered to compute a course, the location manager fills in the speed
     and course properties of the location object with the appropriate values.
     */
    
    
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
    
    /*
     CLPlacemark
     
     A user-friendly description of a geographic coordinate, often containing the name of
     the place, its address, and other relevant information.
     
     A CLPlacemark object stores placemark data for a given latitude and longitude. Placemark
     data includes information such as the country, state, city, and street address associated
     with the specified coordinate. It can also include points of interest and geographically
     related data.
     
     When you reverse geocode a geographic coordinate using a CLGeocoder object, you receive
     a CLPlacemark object containing the descriptive information for that location. You can also
     create CLPlacemark object and fill it with address information yourself, which you might do
     when you want to determine the geographic coordinate associated with the location.
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
