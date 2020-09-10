//
//  AnnotationView.m
//  JMMap
//
//  Created by tigerfly on 2020/9/3.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "AnnotationView.h"

@implementation AnnotationView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


// Creating and preparing an Annotation View
- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        
        //Setting the priority for display
        self.displayPriority = MKFeatureDisplayPriorityRequired;
        
        //Getting and Setting Attributes
        NSLog(@"%d",self.isEnabled);
        self.image = [UIImage imageNamed:@"Tricycle"];
        NSLog(@"%d",self.highlighted);
        NSLog(@"%@",self.annotation);
//        self.centerOffset
//        self.calloutOffset
//        self.reuseIdentifier
        
        // Managing the Selection State
//        self setSelected:<#(BOOL)#> animated:<#(BOOL)#>
//        self.selected
        
        // Managing Callout Views
//        self.canShowCallout
//        self.leftCalloutAccessoryView
//        self.rightCalloutAccessoryView
//        self.detailCalloutAccessoryView
        
        // Supporting Drag Operations
//        self.draggable
//        self setDragState:<#(MKAnnotationViewDragState)#>
//        self setDragState:<#(MKAnnotationViewDragState)#> animated:<#(BOOL)#>
        
        // Managing Collisions Between Annotation Views
        [self setCollisionMode:MKAnnotationViewCollisionModeRectangle];
        
        //Clustering Annotation Views
//        self.clusteringIdentifier
//        self.clusterAnnotationView
        
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
}

- (void)prepareForDisplay {
    [super prepareForDisplay];
    
}





@end
