//
//  LocalSearchController.m
//  JMMap
//
//  Created by tigerfly on 2020/9/11.
//  Copyright © 2020 tiger fly. All rights reserved.
//
#import "LocalSearchController.h"
#import <MapKit/MapKit.h>
#import "SearchResultController.h"
#import "MKPlacemark+Add.h"

@interface LocalSearchController ()<UISearchControllerDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) MKMapView *mapView;

@end

@implementation LocalSearchController {
    
    UISearchController *_searchController;
    SearchResultController *_searchResultController;
    UITableView *_tableView;
    NSArray *_resultArray;
    MKLocalSearch *_localSearch;
    MKLocalSearchRequest *_searchRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;

    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.title = @"Map Search";
    
    // TableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    
    
    //搜索结果
    _searchResultController = [SearchResultController new];
    
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_searchResultController];
    _searchController.delegate = _searchResultController;
    _searchController.searchResultsUpdater = _searchResultController;
    self.navigationItem.searchController = _searchController;
    
    _searchController.searchBar.delegate = self;
    
//    // search
//    _searchRequest = [[MKLocalSearchRequest alloc] init];
//    _searchRequest.resultTypes = MKLocalSearchResultTypePointOfInterest;
//    _searchRequest.region = MKCoordinateRegionForMapRect(MKMapRectWorld);
//    _localSearch = [[MKLocalSearch alloc] initWithRequest:_searchRequest];
}


#pragma mark --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _resultArray == nil ? 0 : _resultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    MKMapItem *mapItem = _resultArray[indexPath.row];
    cell.textLabel.text = mapItem.name;
    NSString *placeStr = [mapItem.placemark formatString];
    cell.detailTextLabel.text = placeStr;
    return cell;
}


#pragma mark -- UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [_searchController dismissViewControllerAnimated:true completion:nil];
    
    [self handleSearch:searchBar.text];
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
}
- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar {
    
}


#pragma mark -- 开始搜索

- (void)handleSearch:(NSString *)string {
    
    //MKLocalSearchRequest
    //MKLocalSearch
    MKLocalSearchRequest *searchRequest = [[MKLocalSearchRequest alloc] initWithNaturalLanguageQuery:string];
    searchRequest.resultTypes = MKLocalSearchResultTypePointOfInterest;
    searchRequest.region = MKCoordinateRegionForMapRect(MKMapRectWorld);
    MKLocalSearch *localSearch = [[MKLocalSearch alloc] initWithRequest:searchRequest];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@",response.mapItems);
        _resultArray = response.mapItems;
        [_tableView reloadData];
        _searchController.searchBar.text = nil;
    }];
    
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
