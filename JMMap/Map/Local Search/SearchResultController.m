//
//  SearchResultController.m
//  JMMap
//
//  Created by tigerfly on 2020/9/11.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "SearchResultController.h"
#import <MapKit/MapKit.h>
#import "MKPlacemark+Add.h"

@interface SearchResultController ()<MKLocalSearchCompleterDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation SearchResultController {
    
    MKLocalSearchRequest *_searchRequest;
    MKLocalSearch *_localSearch;
    MKLocalSearchCompleter *_searchCompleter;
    
    UITableView *_tableView;
    NSArray *_searchArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    
    
#pragma mark -- MKLocalSearch
    
    /*
     A utility object for initiating map-based searches and processing the results.
     */
    _searchRequest = [[MKLocalSearchRequest alloc] init];
    _searchRequest.resultTypes = MKLocalSearchResultTypePointOfInterest;
    
    //Creating a Search Request
    _localSearch = [[MKLocalSearch alloc] initWithRequest:_searchRequest];
    
    //Performing the Search
//    _localSearch startWithCompletionHandler:<#^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error)completionHandler#>
//    _localSearch.isSearching
//    _localSearch cancel
    
    
#pragma mark -- MKLocalSearchCompleter
    
    /*
     A utility object for generating a list of completion strings based
     on a partial search string that you provide.
     */
    _searchCompleter = [[MKLocalSearchCompleter alloc] init];

    // Receiving the search Results
    _searchCompleter.delegate = self;
    
    // Specifying the Query Attributes
//    searchCompleter.queryFragment
//    searchCompleter.region
    _searchCompleter.resultTypes = MKLocalSearchCompleterResultTypePointOfInterest;
//    searchCompleter.pointOfInterestFilter
//    searchCompleter.filterType
    
    // Cancelling the Query
//    searchCompleter cancel
//    searchCompleter isSearching
    
    // Getting the Current Query Results
//    searchCompleter results
    
    
#pragma mark -- MKLocalSearchCompletion
    
    /*
     A fully-formed string that completes a partial string.
     */
    MKLocalSearchCompletion *searchCompletion = [[MKLocalSearchCompletion alloc] init];
    
    // Getting the Search Completions
//    searchCompletion.title
//    searchCompletion.subtitle
//    searchCompletion.titleHighlightRanges
//    searchCompletion.subtitleHighlightRanges
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardPresent:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDismiss:) name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark -- UISearchResultsUpdating

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    _searchCompleter.queryFragment = searchController.searchBar.text;
}

#pragma mark -- UISearchControllerDelegate


- (void)completerDidUpdateResults:(MKLocalSearchCompleter *)completer {
    NSLog(@"%@",completer.results);
    _searchArray = completer.results;
    [_tableView reloadData];
}

- (void)completer:(MKLocalSearchCompleter *)completer didFailWithError:(NSError *)error {
    
}


#pragma mark --

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchArray ? _searchArray.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    MKLocalSearchCompletion *searchCompletion = _searchArray[indexPath.row];
    cell.textLabel.text = searchCompletion.title;
    cell.detailTextLabel.text = searchCompletion.subtitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark --

- (void)keyboardPresent:(NSNotification *)notification {
    
    NSDictionary *userInfo = notification.userInfo;
    CGFloat keyboardHeight = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    _tableView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H - keyboardHeight);
}

- (void)keyboardDismiss:(NSNotification *)notification {
    _tableView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
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
