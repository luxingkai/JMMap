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

@synthesize coordinate;

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation
                   reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.image = [UIImage imageNamed:@"location"];
        
    }
    return self;
}





@end
