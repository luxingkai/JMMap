//
//  ViewController.m
//  JMMap
//
//  Created by tiger fly on 2020/3/17.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JMLocationManager.h"

@interface ViewController ()<JMLocationManagerDelegate,MKMapViewDelegate>

@end

@implementation ViewController {
    
    JMLocationManager *_locationManager;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
        
    _locationManager = [JMLocationManager manager];
    _locationManager.delegate = self;
    
    //Setting the Visible Portion of the Map
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(40, -160.0);
    MKCoordinateSpan span = MKCoordinateSpanMake(20, 20);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate2D, span);
    
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    mapView.delegate = self;
//    mapView.rotateEnabled = NO;
//    mapView.zoomEnabled = NO;
//    mapView.scrollEnabled = NO;
    mapView.pitchEnabled = YES;
    mapView.region = region;
    [self.view addSubview:mapView];

    //Displaying a 3D Map
    // Create a coordinate structure for the location.
    CLLocationCoordinate2D ground = CLLocationCoordinate2DMake(40, 110);
    // Create a coordinate structure for the point on the ground from which to view the location.
    CLLocationCoordinate2D eye = CLLocationCoordinate2DMake(50, 120);
    // Ask Map Kit for a camera that looks at the location from an altitude of 100 meters above the eye coordinates.
    MKMapCamera *myCamera = [MKMapCamera cameraLookingAtCenterCoordinate:ground fromEyeCoordinate:eye eyeAltitude:100];
    // Assign the camera to your map view.
    mapView.camera = myCamera;

    
    //Zooming and Panning the Map Content
    CLLocationCoordinate2D mapCenter = mapView.centerCoordinate;
    mapCenter = [mapView convertPoint:
                   CGPointMake(1, (mapView.frame.size.height/2.0))
                   toCoordinateFromView:mapView];
    [mapView setCenterCoordinate:mapCenter animated:YES];
    
    MKCoordinateRegion theRegion = mapView.region;
     
    // Zoom out
    theRegion.span.longitudeDelta *= 2.0;
    theRegion.span.latitudeDelta *= 2.0;
    [mapView setRegion:theRegion animated:YES];

    
}


#pragma mark -- JMLocationManagerDelegate

- (void)locationManager:(JMLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
}


#pragma mark -- Using the Delegate to Respond to User Interactions

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
}
- (void)mapViewDidChangeVisibleRegion:(MKMapView *)mapView {
    NSLog(@"%f %f %f",mapView.userLocation.location.coordinate.latitude,
          mapView.userLocation.location.coordinate.latitude,
          mapView.userLocation.location.altitude);
}
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
    
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    
    
}











@end
