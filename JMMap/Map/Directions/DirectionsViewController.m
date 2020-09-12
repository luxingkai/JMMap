//
//  DirectionsViewController.m
//  JMMap
//
//  Created by tigerfly on 2020/9/11.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "DirectionsViewController.h"
#import <MapKit/MapKit.h>

@interface DirectionsViewController ()<MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation DirectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*
     A utility object that computes directions and travel-time
     information based on the route information you provide.
     */
    
    // ---------
    CGFloat status_h = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 44.0 + status_h, SCREEN_W, SCREEN_H)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.scrollEnabled = YES;
    self.mapView.pitchEnabled = YES;
    self.mapView.rotateEnabled = YES;
    self.mapView.zoomEnabled = YES;
    
    self.mapView.showsScale = YES;
    self.mapView.showsCompass = YES;
    self.mapView.showsTraffic = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = YES;
    if (@available(iOS 13.0, *)) {
        self.mapView.showsLargeContentViewer = YES;
    } else {
        // Fallback on earlier versions
    }
    

#pragma mark -- MKDirections
    
    /*
     A utility object that computes directions and travel-time
     information based on the route information you provide.
     */
    
    //Creating a Directions Object
    MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] initWithContentsOfURL:[NSURL URLWithString:@""]];
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionRequest];
    
    //Getting the Directions
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
    }];
    
    //Getting the ETA
    [directions calculateETAWithCompletionHandler:^(MKETAResponse * _Nullable response, NSError * _Nullable error) {
    }];
    
    //Managing the Request
    if ([directions isCalculating]) {
        [directions cancel];
    }
    
    
#pragma mark -- MKDirectionsRequest
    
    //Creating a Directions Request Object
    //    [MKDirectionsRequest isDirectionsRequestURL:<#(nonnull NSURL *)#>];
//    MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] initWithContentsOfURL:[NSURL URLWithString:@""]];
    
    
    //Accessing the Start and End Points
//    directionRequest.source
//    directionRequest.destination
    
    
    //Specifying Transportation Options
//    directionRequest.transportType
//    directionRequest.requestsAlternateRoutes
//    directionRequest.departureDate
//    directionRequest.arrivalDate
    
    
#pragma mark -- MKDirectionsResponse
    /*
     The route information returned by Apple servers in response to one
     of your requests for directions.
     */
    
    //Getting the End Points
//    source
//    destination
    
    //Getting the Route information
//    routes
    
    
#pragma mark -- MKETAResponse
    /*
     The travel-time information returned by Apple servers.
     */
    
    // Getting the End Points
//    source
//    destination
    
    
    // Getting the Travel information
//    expectedTravelTime
//    expectedDepartureDate
//    expectedArrivalDate
//    distance
//    transportType
    
    
#pragma mark -- MKRoute
    /*
     A single route between a requested start and end point.
     */
    
    //Getting the Route Geometry
//    polyline
//    steps
    
    //Getting Additional Route Details
//    name
//    advisoryNotices
//    distance
//    expectedTravelTime
//    transportType
    

#pragma mark -- MKRouteStep
    
    /*
     One portion of an overall route
     */
        
    // Getting the Step Geometry
//    polyline
    
    // Getting Additional Step Details
//    instructions
//    notices
//    distance
//    transportType
    
    
    
}


#pragma mark -- MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
}

- (void)mapViewDidChangeVisibleRegion:(MKMapView *)mapView {
    
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    
}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
    
}

- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView {
    
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered {
    
}

// mapView:viewForAnnotation: provides the view for each annotation.
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    return nil;
}

// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
// The delegate can implement this method to animate the adding of the annotations views.
// Use the current positions of the annotation views as the destinations of the animation.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    
}

// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
}

- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView {
    
}
- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView {
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
}
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
    
}

- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated {
    
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    return nil;
}
- (void)mapView:(MKMapView *)mapView didAddOverlayRenderers:(NSArray<MKOverlayRenderer *> *)renderers {
    
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
