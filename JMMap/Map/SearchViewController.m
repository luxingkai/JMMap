//
//  SearchViewController.m
//  JMMap
//
//  Created by tigerfly on 2020/9/7.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import "SearchViewController.h"
#import <MapKit/MapKit.h>

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,MKLocalSearchCompleterDelegate>

@end

@implementation SearchViewController {
    UITableView *_tableView;
    NSArray *_searchResultArray;
    
    MKLocalSearchRequest *_searchRequest;
    MKLocalSearch *_localSearch;
    MKLocalSearchCompleter *_searchCompleter;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.searchBar.delegate = self;
    
    //本地搜索
    _searchRequest = [[MKLocalSearchRequest alloc] init];
    _localSearch = [[MKLocalSearch alloc] initWithRequest:_searchRequest];
    _searchCompleter = [MKLocalSearchCompleter new];
    _searchCompleter.resultTypes = MKLocalSearchCompleterResultTypeAddress;
    _searchCompleter.delegate = self;
    
    //---------
    CGFloat search_bar_h = self.searchBar.frame.size.height;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, search_bar_h + 44.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - search_bar_h - 44.0) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Identifier"];
    
}


#pragma mark -- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchResultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Identifier"];
    MKLocalSearchCompletion *searchCompletion = _searchResultArray[indexPath.row];
    cell.textLabel.text = searchCompletion.title;
    cell.detailTextLabel.text = searchCompletion.subtitle;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MKLocalSearchCompletion *searchCompletion = _searchResultArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(searchViewSelectSearchResult:)]) {
        [self.delegate searchViewSelectSearchResult:searchCompletion.title];
    }
    [self dismissViewControllerAnimated:true completion:nil];
}


#pragma mark -- UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    _searchCompleter.queryFragment = searchText;
}

#pragma mark -- MKLocalSearchCompleterDelegate

- (void)completerDidUpdateResults:(MKLocalSearchCompleter *)completer {
    
    _searchResultArray = completer.results;
    [_tableView reloadData];
}

- (void)completer:(MKLocalSearchCompleter *)completer didFailWithError:(NSError *)error {
    
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
