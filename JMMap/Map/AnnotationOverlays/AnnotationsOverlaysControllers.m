//
//  AnnotationsOverlaysControllers.m
//  JMMap
//
//  Created by tigerfly on 2020/9/10.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AnnotationsOverlaysControllers.h"
#import <MapKit/MapKit.h>
#import "JMLocationManager.h"
#import "AnnotationView.h"
#import "JMAnnotation.h"
#import "JMOverlayRenderer.h"
#import "JMOverlay.h"

@interface AnnotationsOverlaysControllers ()<MKMapViewDelegate,JMLocationManagerDelegate,MKAnnotation>

@property (nonatomic, strong) MKMapView *mapView;
@end

@implementation AnnotationsOverlaysControllers {
    
    JMLocationManager *_locationManager;
}
@synthesize coordinate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _locationManager = [JMLocationManager manager];
    _locationManager.delegate = self;
    
    self.view.backgroundColor = UIColor.whiteColor;
    CGFloat status_h = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 44.0 + status_h, SCREEN_W, SCREEN_H)];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
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
    
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.rotateEnabled = YES;
    self.mapView.pitchEnabled = YES;
    
    
#pragma mark -- Annotations and Overlays
    
    /* MKPlacemark */
    CLLocationCoordinate2D coordinate2D = CLLocationCoordinate2DMake(31.77558768, 117.31268525);
    if (@available(iOS 10.0, *)) {
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate2D];
        
    } else {
        // Fallback on earlier versions
    }
    
    /* MKAnnotationView */
    [self.mapView registerClass:[AnnotationView class] forAnnotationViewWithReuseIdentifier:@"annotation"];

    //设置地图中心展示区域
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(31.77558768, 117.31268525), MKCoordinateSpanMake(0.00978871051851371, 0.00816739331921212));
    [self.mapView setRegion:coordinateRegion];
    
    //添加标注模型并绑定标注坐标，在地图上添加当前标注点
    JMAnnotation *annotation = [JMAnnotation new];
    annotation.coordinate = CLLocationCoordinate2DMake(31.77558768, 117.31268525);
    [self.mapView addAnnotation:annotation];
    
    /* MKOverlayRenderer */
    JMOverlay *overlay = [JMOverlay new];
    [self.mapView addOverlay:overlay];
    
    
}

#pragma mark --  JMLocationManagerDelegate

- (void)locationManager:(JMLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
//    CLLocation *location = locations.firstObject;
//    _mapView.centerCoordinate = location.coordinate;
//
//    [_mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:true];

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
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView
                     viewForAnnotation:(id <MKAnnotation>)annotation {
    AnnotationView *annotationView = (AnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
    return annotationView;
}

// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
// The delegate can implement this method to animate the adding of the annotations views.
// Use the current positions of the annotation views as the destinations of the animation.
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    
}

// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view  {
    
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
