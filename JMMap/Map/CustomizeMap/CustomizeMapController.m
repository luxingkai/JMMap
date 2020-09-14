//
//  CustomizeMapController.m
//  JMMap
//
//  Created by tigerfly on 2020/9/9.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "CustomizeMapController.h"
#import <MapKit/MapKit.h>
#import "AnnotationView.h"
#import "JMLocationManager.h"

@interface CustomizeMapController ()<MKMapViewDelegate,JMLocationManagerDelegate,MKAnnotation>

@end

@implementation CustomizeMapController {
    
    MKMapView *_mapView;
    JMLocationManager *_locationManager;
    
}
@synthesize coordinate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _locationManager = [JMLocationManager manager];
    _locationManager.delegate = self;
    
    //------------
    CGFloat status_h = [UIApplication sharedApplication].statusBarFrame.size.height;
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 44.0 + status_h, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 44.0 - status_h)];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    
    /* Accessing Map Properties */
    _mapView.mapType = MKMapTypeStandard;
    _mapView.zoomEnabled = true;
    _mapView.scrollEnabled = true;
    _mapView.pitchEnabled = true;
    _mapView.rotateEnabled = true;
    
    
    /* Manipulating the Visible Portion of the Map */
    //    _mapView.region
    //    _mapView.centerCoordinate
    //    _mapView showAnnotations:<#(nonnull NSArray<id<MKAnnotation>> *)#> animated:<#(BOOL)#>
    //    [_mapView visibleMapRect];
    //    _mapView setVisibleMapRect:<#(MKMapRect)#> animated:<#(BOOL)#>
    //    _mapView setVisibleMapRect:<#(MKMapRect)#> edgePadding:(UIEdgeInsets) animated:<#(BOOL)#>
    
    
    /* Constraining the Map View */
    //    [_mapView setCameraBoundary:];
    //    _mapView setCameraBoundary:<#(nullable MKMapCameraBoundary *)#> animated:<#(BOOL)#>
    //    _mapView setCameraZoomRange:<#(nullable MKMapCameraZoomRange *)#> animated:<#(BOOL)#>
    //    _mapView setCameraZoomRange:<#(MKMapCameraZoomRange * _Nullable)#>
    
    
    /* Configuring the Map's Appearance */
    //    _mapView.camera
    //    _mapView.pointOfInterestFilter = [[MKPointOfInterestFilter alloc] initExcludingCategories:@[MKPointOfInterestCategoryAirport,MKPointOfInterestCategoryAmusementPark,MKPointOfInterestCategoryAquarium,MKPointOfInterestCategoryATM,MKPointOfInterestCategoryBakery,MKPointOfInterestCategoryBank,MKPointOfInterestCategoryBeach]];
//    _mapView.showsBuildings = YES;
//    _mapView.showsCompass = YES;
//    _mapView.showsScale = YES;
//    _mapView.showsTraffic = YES;
    
    
    /* Displaying the User's Location */
    _mapView.showsUserLocation = YES;
    //    _mapView.isUserLocationVisible
    //    _mapView.userLocation
    //    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    [_mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:true];
    
    
    /* Annotating the Map */
    //    [_mapView addAnnotation:self];
    //    _mapView addAnnotations:<#(nonnull NSArray<id<MKAnnotation>> *)#>
    //    _mapView removeAnnotations:<#(nonnull NSArray<id<MKAnnotation>> *)#>
    //    _mapView removeAnnotation:<#(nonnull id<MKAnnotation>)#>
    
    
    /* Managing Annotation Selections */
    //    NSLog(@"%@",NSStringFromCGRect(_mapView.annotationVisibleRect));
    //    NSLog(@"%@",_mapView.selectedAnnotations);
    //    _mapView selectAnnotation:<#(nonnull id<MKAnnotation>)#> animated:<#(BOOL)#>
    //    _mapView deselectAnnotation:<#(nullable id<MKAnnotation>)#> animated:<#(BOOL)#>
    
    
    /* Creating Annotation Views */
    [_mapView registerClass:[AnnotationView class] forAnnotationViewWithReuseIdentifier:@"annotation"];
    
    
#pragma mark -- Map Customization
    
    MKMapCamera *mapCamera = [MKMapCamera camera];
//    MKMapCamera cameraLookingAtCenterCoordinate:<#(CLLocationCoordinate2D)#> fromDistance:<#(CLLocationDistance)#> pitch:<#(CGFloat)#> heading:<#(CLLocationDirection)#>
//    MKMapCamera cameraLookingAtCenterCoordinate:<#(CLLocationCoordinate2D)#> fromEyeCoordinate:<#(CLLocationCoordinate2D)#> eyeAltitude:<#(CLLocationDistance)#>
    _mapView.camera = mapCamera;
    
    //罗盘按钮
    MKCompassButton *compassButton = [MKCompassButton compassButtonWithMapView:_mapView];
    compassButton.compassVisibility = MKFeatureVisibilityVisible;
    compassButton.frame = CGRectMake(20, 20, 20, 20);
    [_mapView addSubview:compassButton];
    
    //缩放视图
    MKScaleView *scaleView = [MKScaleView scaleViewWithMapView:_mapView];
    scaleView.scaleVisibility = MKFeatureVisibilityVisible;
    [_mapView addSubview:scaleView];
    
    //追踪按钮
//    MKUserTrackingButton *trackingButton = [MKUserTrackingButton userTrackingButtonWithMapView:_mapView];
//    [_mapView addSubview:trackingButton];
    
    MKUserTrackingBarButtonItem *barItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:_mapView];
    self.navigationItem.rightBarButtonItem = barItem;
    
    
}

#pragma mark --  JMLocationManagerDelegate

- (void)locationManager:(JMLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = locations.firstObject;
    
    _mapView.centerCoordinate = location.coordinate;
    [_mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:true];
    
}


#pragma mark -- MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
}
- (void)mapViewDidChangeVisibleRegion:(MKMapView *)mapView {
    
}

//-------------
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView {
    
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    
}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error {
    
}

//-------------
- (void)mapViewWillStartRenderingMap:(MKMapView *)mapView {
    
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView {
    
}

//-------------
- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView
                     viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView *annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
    return annotationView;
}
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
}
- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    
}

//------------
- (void)mapViewWillStartLocatingUser:(MKMapView *)mapView {
    
}
- (void)mapViewDidStopLocatingUser:(MKMapView *)mapView {
    
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    
}
- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    
}
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view    didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState {
    
}
- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated {
    
}
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id <MKOverlay>)overlay {
    return nil;
}

- (void)mapView:(MKMapView *)mapView didAddOverlayRenderers:(NSArray<MKOverlayRenderer *> *)renderers {
    
}
- (MKClusterAnnotation *)mapView:(MKMapView *)mapView clusterAnnotationForMemberAnnotations:(NSArray<id<MKAnnotation>>*)memberAnnotations {
    return nil;
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
