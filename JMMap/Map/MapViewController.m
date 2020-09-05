//
//  MapViewController.m
//  JMMap
//
//  Created by tigerfly on 2020/9/2.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JMLocationManager.h"
#import "AnnotationView.h"

@interface MapViewController ()<MKMapViewDelegate,JMLocationManagerDelegate,MKAnnotation>

@end

@implementation MapViewController {
    
    MKMapView *_mapView;
    JMLocationManager *_locationManager;
}
@synthesize coordinate;
@synthesize title;
@synthesize subtitle;


- (void)dealloc {
    [_mapView removeAnnotation:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _locationManager = [JMLocationManager manager];
    _locationManager.delegate = self;
    
    
    /*
     MapKit
     Display map or satellite imagery within your app, call out points of
     interest, and determine placemark information for map coordinates.
     
     Use MapKit to give your app a sence of place with maps and location
     information. You can use the MapKit framework to:
     •  Embed maps directly into your app's windows and views.
     •  Add annotations and overlays to a map for calling out points of interest.
     •  Provide text completion to make it easy for users to search for
        a destination or point of interest.
     
     if your app offers transit directions, you can make your directions available
     to Maps. You can also use Maps to supplement the directions that you provide
     in your app. For example, if your app only provides directions for subway
     travel, you can use Maps to provide walking directions to and from subway
     stations.
     */
    
    
#pragma mark -- Essentials
    
    /*
     MKMapView
     An embeddable map interface, similar to the one provided by the Maps application.
     
     You use this class as-is to display map information and to manipulate the map
     contents from your application. You can center the map on a given coordinate,
     specify the size of the area you want to display, and annotate the map with
     custom information. When you initialize a map view, you specify the initial
     region for that map to display by setting the region property of the map.
     A region is defined by a center point and a horizontal and vertical distance,
     referred to as the span. The span defines how much of the map should be visible
     and is also how you set the zoom level. For example, specifying a large span
     results in the user seeing in a wide geographical area at a low zoom level,
     whereas specifying a small span results in a more narrow geographical area
     and a higher zoom level.
     
     In addition to setting the span programmatically, the MKMapView class supports
     many standard interactions for changing the position and zoom level of the map.
     In particular, map views support flick and pinch gestures for scrolling around
     the map and zooming in and out. Support for these gestures is enabled by default
     but can also be disabled using the isScrollEnabled and isZoomEnabled properties.

     You can also use projected map coordinates instead of regions to specify some
     values. When you project the curved surface of the globe onto a flat surface,
     you get a two-dimensional version of a map where longitude lines appear to be
     parallel. To specify locations and distances, you use the MKMapPoint, MKMapSize,
     and MKMapRect data types.

     Although you should not subclass the MKMapView class itself, you can get
     information about the map view’s behavior by providing a delegate object.
     The map view calls the methods of your custom delegate to let it know
     about changes in the map status and to coordinate the display of custom
     annotations, which are described in more detail in Annotating the Map.
     The delegate object can be any object in your application as long as it
     conforms to the MKMapViewDelegate protocol. For more information about
     implementing the delegate object, see MKMapViewDelegate.

     In macOS 10.14 and later, you can apply a light or dark appearance to
     your maps by modifying the appearance property of your map view (or one
     of its ancestor views). Even if you specify a custom appearance, users
     can use the Maps app to force all maps to adopt a light appearance.
     Use the map view's effectiveAppearance property to determine the actual
     appearance of your map. For information about how to set view appearances,
     see Choosing a Specific Appearance for Your macOS App.
     */
    
    /*
     Annotating the Map
     
     The MKMapView class supports the ability to annotate the map with
     custom information. Because a map may have large numbers of annotations,
     map views differentiate between the annotation objects used to manage
     the annotation data and the view objects for presenting that data on the map.

     An annotation object is any object that conforms to the MKAnnotation
     protocol. Annotation objects are typically implemented using existing
     classes in your application’s data model. This allows you to manipulate
     the annotation data directly but still make it available to the map view.
     Each annotation object contains information about the annotation’s
     location on the map along with descriptive information that can be
     displayed in a callout.

     The presentation of annotation objects on the screen is handled by an
     annotation view, which is an instance of the MKAnnotationView class.
     An annotation view is responsible for presenting the annotation data
     in a way that makes sense. For example, the Maps application uses a
     marker icon to denote specific points of interest on a map. (The Map
     Kit framework offers the MKMarkerAnnotationView and MKPinAnnotationView
     classes for similar annotations in your own applications.) You could also
     create annotation views that cover larger portions of the map.

     Because annotation views are needed only when they are onscreen, the
     MKMapView class provides a mechanism for queueing annotation views
     that are not in use. Annotation views with a reuse identifier can be
     detached and queued internally by the map view when they move offscreen.
     This feature improves memory use by keeping only a small number of
     annotation views in memory at once and by recycling the views you do have.
     It also improves scrolling performance by alleviating the need to create
     new views while the map is scrolling.

     When configuring your map interface, you should add all of your annotation
     objects right away. The map view uses the coordinate data in each
     annotation object to determine when the corresponding annotation view
     needs to appear onscreen. When an annotation moves onscreen, the map
     view asks its delegate to create a corresponding annotation view. If
     your application has different types of annotations, it can define
     different annotation view classes to represent each type.
     */
    
    /*
     Adding Overlays to the Map
     You can use overlays to layer content over a wide portion of the map.
     An overlay object is any object that conforms to the MKOverlay protocol.
     An overlay object is a data object that contains the points needed to
     specify the shape and size of the overlay and its location on the map.
     Overlays can represent shapes such as circles, rectangles, multi-segment
     lines, and simple or complex polygons. You can also define your own
     custom overlays to represent other shapes.

     In iOS 7 and macOS 10.9 and later, the presentation of an overlay is
     handled by an overlay renderer object, which is an instance of the
     MKOverlayRenderer class. The job of the renderer is to draw the overlay’s
     content onto the screen when asked to do so by the map view. For example,
     if you have a simple overlay that represents a bus route, you could use
     a polyline renderer to draw the line segments that trace the route of the
     bus. You could also define a custom renderer that draws both the bus route
     and icons at the location of each bus stop. When specifying overlays,
     you can add them to specific levels of the map, which allows them to be
     rendered above or below other types of map content. Prior to iOS 7,
     overlays are drawn on onscreen using overlay views, which are instances
     of the MKOverlayView class.

     When configuring your map interface, you can add overlay objects at
     any time. The map view uses the data in each overlay object to determine
     when the corresponding overlay view needs to appear onscreen. When an
     overlay moves onscreen, the map view asks its delegate to create a
     corresponding overlay renderer.
     */
    
    _mapView = [[MKMapView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    /* Customizing the Map View Behavior */
    _mapView.delegate = self;
    
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
    _mapView.showsBuildings = YES;
    _mapView.showsCompass = YES;
    _mapView.showsScale = YES;
    _mapView.showsTraffic = YES;
    
    
    /* Displaying the User's Location */
    _mapView.showsUserLocation = YES;
//    _mapView.isUserLocationVisible
//    _mapView.userLocation
//    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    [_mapView setUserTrackingMode:MKUserTrackingModeFollow animated:true];
    
    
    /* Annotating the Map */
    [_mapView addAnnotation:self];
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
    MKAnnotationView *annotationView = [_mapView dequeueReusableAnnotationViewWithIdentifier:@"annotation"];
//    _mapView dequeueReusableAnnotationViewWithIdentifier:<#(nonnull NSString *)#> forAnnotation:<#(nonnull id<MKAnnotation>)#>
//    [_mapView showAnnotations:@[(id)annotationView] animated:true];
    
    
    /* Accessing Overlays */
//    _mapView.overlays
//    _mapView overlaysInLevel:<#(MKOverlayLevel)#>
//    _mapView rendererForOverlay:<#(nonnull id<MKOverlay>)#>
    
    
    /* Adding and Inserting Overlays */
//    _mapView addOverlay:(nonnull id<MKOverlay>)
//    _mapView addOverlay:<#(nonnull id<MKOverlay>)#> level:<#(MKOverlayLevel)#>
//    _mapView addOverlays:<#(nonnull NSArray<id<MKOverlay>> *)#> level:<#(MKOverlayLevel)#>
//    _mapView addOverlays:<#(nonnull NSArray<id<MKOverlay>> *)#>
//    _mapView insertOverlay:<#(nonnull id<MKOverlay>)#> atIndex:<#(NSUInteger)#>
//    _mapView insertOverlay:<#(nonnull id<MKOverlay>)#> aboveOverlay:(nonnull id<MKOverlay>)
//    _mapView insertOverlay:<#(nonnull id<MKOverlay>)#> atIndex:<#(NSUInteger)#> level:<#(MKOverlayLevel)#>
//    _mapView insertOverlay:<#(nonnull id<MKOverlay>)#> belowOverlay:<#(nonnull id<MKOverlay>)#>
//    _mapView exchangeOverlay:<#(nonnull id<MKOverlay>)#> withOverlay:<#(nonnull id<MKOverlay>)#>
//    _mapView exchangeOverlayAtIndex:<#(NSUInteger)#> withOverlayAtIndex:<#(NSUInteger)#>
    
    
    /* Removing Overlays */
//    _mapView removeOverlay:<#(nonnull id<MKOverlay>)#>
//    _mapView removeOverlays:<#(nonnull NSArray<id<MKOverlay>> *)#>
    
    
    /* Converting Map Coordinates */
//    _mapView convertCoordinate:<#(CLLocationCoordinate2D)#> toPointToView:<#(nullable UIView *)#>
//    _mapView convertPoint:<#(CGPoint)#> toCoordinateFromView:<#(nullable UIView *)#>
//    _mapView convertRegion:<#(MKCoordinateRegion)#> toRectToView:<#(nullable UIView *)#>
//    _mapView convertRect:<#(CGRect)#> toRegionFromView:<#(nullable UIView *)#>
    
    
    /* Adjusting Map Regions and Rectangles */
//    _mapView regionThatFits:<#(MKCoordinateRegion)#>
//    _mapView mapRectThatFits:<#(MKMapRect)#>
//    _mapView mapRectThatFits:<#(MKMapRect)#> edgePadding:<#(UIEdgeInsets)#>
    
    
    [self.view addSubview:_mapView];

    
#pragma mark -- Map Coordinates
    
//    MKCoordinateRegion
//    MKCoordinateSpan
//    MKMapRect
//    MKMapPoint
//    MKMapSize
//    MKDistanceFormatter
        
    
#pragma mark -- Map Customization
    
    /*
     MKMapCamera
     A virtual camera for defining the appearance of the map.
     A camera object defines a virtual viewpoint above the map surface and affects
     how the map i presented to the user. You use a camera object to specify the
     location of the camera on the map, teh compass heading indicating the camera's
     viewing direction, the pitch of the camera relative to the map prependicular,
     and the camera's altitude above the map. These factors create a map View with
     a three-dimensional prespective.
     
     After creating an instance of this class, configure it with the desired attributes
     and assign it to your map view. When you assign a camera to your map view, MapKit
     centers the map using the value in your camera object's centerCoordinate property,
     updating the map's own region information in the process. The map also takes the
     camera's pitch and altitude into account when calculating the visible region,
     ensuring that the region always encompasses the visible content on the map.
     */
    
    /*
     MKCompassButton
     A specialized view that displays the current compass heading for its associated map.
     
     Use this class when you want to incorporate as standard compass button into your own
     view hierarchy. A compass button reflects the current orientation of its associated
     map view. Tapping the compass button reorients the map so that due north is at the
     top of the map view.
     */
    
    /*
     MKScaleView
     A specialized view that displays the current scale information for its associated
     map.
     Use this class when you wnat to incorporate a standard scale View into your own
     view hierarchy. A scale view displays a legend with distance information for
     its associated map view. As the map region changes, the scale view updates
     automatically to reflect any changes in scale.
     */
    
    /*
     MKZoomControl
     A specialized view that displays and controls the zoom level of the map View.
     Use this class when you want to incorporate a standard, fixed-size zoom control
     into your own view hierachy. A zoom control enables the user to change the zoom
     level of its associated map view.
     */
    
    /*
     MKUserTrackingButton
     A specialized button that allows the user to toggle if the map tracks to the heading
     the user is facing.
     Use this class when you need a standard button that you can incorporate into your
     view hierarchy. Tapping the button lets the user toggles between modes for displaying
     the map with and without the current heading applied. The button also reflects the
     current user tracking mode if set elsewhere.
     */
    
    /*
     MKUserTrackingBarButtonItem
     A specialized bar button item that allows the user to toggle if the map tracks
     to the heading the user if facing.
     Tapping the button lets the user toggles between modes for displaying the map
     with and without the current heading applied. The button also reflects the
     current user tracking mode if set elsewhere. This bar button item is associated
     to a single map view.
     */
    
    
#pragma mark -- Annotations and Overlays

    /*
     MKPlacemark
     A user-friendly description of a location on the map.
     Placemark data includes information such as the country, state, city and
     street address associated with the specified coordinate. A placemark is
     concrete annotation object and conforms to the MKAnnotation protocol.
     Because it is an annotation, you can add a placemark directly to the
     map view's list of annotations.
     */
    
    /*
     MKAnnotation
     An interface for associating your content with a specific map location.
     An object that adopts this protocol manages the data that you want to
     display on the map surface. It does not provide the visual representation
     displayed by the map. Instead, your map view's delegate provides the
     MKAnnotationView Objects needed to display the content of your annotations.
     When you want to display content at a specific point on the map, add an
     annotation object to the map view. When the annotation's coordinate is
     visiable on the map, the map view asks its delegate to provide an appropriate
     view to display any content associated with annotation. You implement the
     mapView(_:viewFor:)method of the delegate to provide that view.
     
     An object that adopts this protocol must implement the coordinate property.
     The other methods of this protocol are optional.
     */
    
    /*
     MKAnnotationView
     The visual representation of one of your annotation objects.
     
     Annotation views are loosely coupled to a corresponding annotation object,
     which is an object that conforms to the MKAnnotation protocol. When an annotation's
     coordinate point is in the map visible region, the map view asks its delegate
     to provide a corresponding annotation view. Annotation views may be recycled later
     and put into a reuse queue that is maintained by the map view.
     
     the most efficient way to provide the content for an annotation view is to set
     its image property. The annotation view sizes itself automatically to the image
     you specify and draws that image for its contents. Because it is a view, you can also
     override the draw(_:) method and draw your view's content manually. If you
     choose to override draw(_:) directly and you do not specify a custom image in the
     image property, the width and height of the annotation view's frame are set to
     0 by default. Before your custom content can be drawn, you must set the width and
     height to nonzero values by modifying the view's frame property. In general, if your
     content consists entirely of static images, it is more efficient to set the image
     property and change it as needed than to draw the images yourself.
     
     Annotation views remain anchored to the map at the point specified by
     their associated annotation object. Although they scroll with the map contents,
     annotation views reside in a seperate display layer and are not scaled when
     the size of the visible map region changes.
     
     Additionally, annotation views support the concept of a selection state, which
     determines whether the view is unselected, selected, or selected and displaying
     a standard callout view. The user toggles between the selection states through
     interactions with the annotation view. In the unselected state, the annotation
     view is displayed but not highlighted. In te selected state, the annotation
     is highlighted but the callout is not displayed. And finally, teh annotation
     can be displayed both with a highlight and a callout. The callout view displays
     additional information such as a title string and controls for viewing more
     information. The title information is provided by the annotation object but
     your annotation view is responsible for providing any custom controls.
     */
    
    /*
     Reuse Annotation Views
     Annotation views are designed to be reused as the user(or your application)
     changes the visible map region. The reuse of annotation views provides
     significant performance improvements during scrolling by avoiding the creation
     of new view objects during this time-critical operation. For this reason,
     annotation views should not be tightly coupled to the contents of their
     associated annotation. Instead, it should be possible to use the properties
     of an annotation view (or setter methods) to configure the view for a new
     annotation object.
     
     Whenever you initialize a new annotation view, you should always specify
     a reuse identifier for that view. As annotation views are no longer needed,
     the map view may put them into a reuse queue. As new annotations are added
     to the map view, the delegate object can then dequeue and reconfigure an
     existing view (rather than create a new one) using the
     dequeueReusableAnnotationView(withIdentifier:)method of MKMapView.
     */
    
    /*
     MKOverlay
     An interface for associating content with a specific map region.
     Overlay objects are data objects that define the geographic data
     to cover. MapKit defines several concrete classes that adopt this
     protocol and define standard shapes such as rectangles, circles,
     and polygons. You might use overlays to define the geographic
     boundaries of a national park to trace a bus route along city
     streets. You add an overlay to your map view by calling its
     addOverlay(_:)method or any other map view method for adding
     overlays to the map. When the overlay's region intersects the
     visible portion of the map, the map view calls the responsible
     for drawing the overlay.
     
     If you add an overlay to a map view as an annotation, instead
     of adding it as an overlay, the map view treats your overlay
     as an annotation. Specifically, it displays your overlay only
     when its coordinate is in the visible map region， rather than
     displaying the overlay when any portion of its covered are is
     visible.
     */
    
    /*
     MKOverlayRenderer
     The shared infrastructure used to draw overlays on the map surface.
     An overlay renderer draws the visual representation of an overlay
     object—that is, an object that conforms to the MKOverlay protocol.
     This class defines the drawing infrastructure used by the map view.
     Subclasses are expected to override the draw(_:zoomScale:in:) method
     to draw the contents of the overlay.

     The MapKit framework provides several concrete instances of overlay
     renderers. Specifically, it provides renderers for each of the concrete
     overlay objects. You can use one of these existing renderers or define
     your own subclasses if you want to draw the overlay contents differently.
     
     You can subclass MKOverlayRenderer to create overlays based on custom shapes,
     content, or drawing techniques. The only method subclasses are expected to
     override is the draw(_:zoomScale:in:) method. However, if your class
     contains content that may not be ready for drawing right away, you should
     also override the canDraw(_:zoomScale:) method and use it to report when
     your class is ready and able to draw.

     The map view may tile large overlays and distribute the rendering of each
     tile to separate threads. Therefore, the implementation of your draw(_:zoomScale:in:)
     method must be safe to run from background threads and from multiple threads simultaneously.
     */
    
//    MKOverlayRenderer
    
    
#pragma mark -- Geographical Features
    
    
    
    
#pragma mark -- Directions
    
    
#pragma mark -- Local Search

    
#pragma mark -- Points of Interest
    
    
#pragma mark -- Static Map Snapshots

    
#pragma mark -- Errors
    
    
    
}


#pragma mark --  JMLocationManagerDelegate

- (void)locationManager:(JMLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *location = locations.firstObject;
//    MKMapRect mapRect = MKMapRectMake(location.coordinate.latitude, location.coordinate.longitude, 10000.0, 10000.0);
//    MKMapCameraBoundary *cameraBoundary = [[MKMapCameraBoundary alloc] initWithMapRect:mapRect];
//    [_mapView setCameraBoundary:cameraBoundary];
    
    _mapView.centerCoordinate = location.coordinate;
    
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
