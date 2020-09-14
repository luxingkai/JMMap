//
//  POIViewController.m
//  JMMap
//
//  Created by tigerfly on 2020/9/12.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "POIViewController.h"
#import <MapKit/MapKit.h>

@interface POIViewController ()

@end

@implementation POIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
#pragma mark -- MKPointOfInterestFilter
    /*
     A filter that includes or excludes point of interest categories from
     a map view, local search, or local search completer.
     */

    MKPointOfInterestFilter *filter = [[MKPointOfInterestFilter alloc] initExcludingCategories:@[MKPointOfInterestCategoryAirport,      MKPointOfInterestCategoryAmusementPark,MKPointOfInterestCategoryAquarium,MKPointOfInterestCategoryATM,MKPointOfInterestCategoryBakery,MKPointOfInterestCategoryBank
    ]];
    
    //Creating Filters
//    filter includesCategory:<#(nonnull MKPointOfInterestCategory)#>
//    filter excludesCategory:<#(nonnull MKPointOfInterestCategory)#>
    
    //Querying Filter Behavior
//    filter excludesCategory:<#(nonnull MKPointOfInterestCategory)#>
//    filter includesCategory:<#(nonnull MKPointOfInterestCategory)#>
    
    
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
