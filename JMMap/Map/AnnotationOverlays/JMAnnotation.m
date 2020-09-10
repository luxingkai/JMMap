//
//  JMAnnotation.m
//  JMMap
//
//  Created by tigerfly on 2020/9/10.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "JMAnnotation.h"

@implementation JMAnnotation {
    
    CLLocationDegrees _latitude;
    CLLocationDegrees _longitude;
}

@synthesize coordinate;

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _latitude = newCoordinate.latitude;
    _longitude = newCoordinate.longitude;
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(_latitude, _longitude);
}


@end
