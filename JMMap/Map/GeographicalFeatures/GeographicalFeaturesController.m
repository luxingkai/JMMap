//
//  GeographicalFeaturesController.m
//  JMMap
//
//  Created by tigerfly on 2020/9/10.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "GeographicalFeaturesController.h"
#import <MapKit/MapKit.h>

@interface GeographicalFeaturesController ()<MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation GeographicalFeaturesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //
    CGFloat status_h = [UIApplication sharedApplication].statusBarFrame.size.height;
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, status_h + 44.0, SCREEN_W, SCREEN_H)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.rotateEnabled = YES;
    self.mapView.pitchEnabled = YES;
    
    self.mapView.showsScale = YES;
    self.mapView.showsTraffic = YES;
    self.mapView.showsCompass = YES;
    self.mapView.showsBuildings = YES;
    self.mapView.showsUserLocation = YES;
    self.mapView.showsPointsOfInterest = YES;
    self.mapView.showsLargeContentViewer = YES;
    
    //MKGeoJsonDecoder
    
//    MKGeoJSONDecoder *decoder = [[MKGeoJSONDecoder alloc] geoJSONObjectsWithData:<#(nonnull NSData *)#> error:<#(NSError *__autoreleasing  _Nullable * _Nullable)#>];
    
    //MKGeoJSONFeature
    MKGeoJSONFeature *jsonFeature = [[MKGeoJSONFeature alloc] init];
//    jsonFeature.geometry
//    jsonFeature.identifier
//    jsonFeature.properties
    
    
    
}
 

#pragma mark -- MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
}

- (void)mapViewDidChangeVisibleRegion:(MKMapView *)mapView {
    
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
    
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    
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
