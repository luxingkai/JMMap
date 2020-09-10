//
//  JMOverlay.m
//  JMMap
//
//  Created by tigerfly on 2020/9/10.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "JMOverlay.h"

@implementation JMOverlay

@synthesize boundingMapRect;
@synthesize coordinate;

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(31.77558768, 117.31268525);
}

- (MKMapRect)boundingMapRect {
    return MKMapRectMake(0, 0, 10, 10);
}


@end
