//
//  SearchViewController.h
//  JMMap
//
//  Created by tigerfly on 2020/9/7.
//  Copyright © 2020 tiger fly. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SearchViewControllerDelegate <NSObject>

@optional
- (void)searchViewSelectSearchResult:(NSString *)selectAddress;
@end
NS_ASSUME_NONNULL_BEGIN

@interface SearchViewController : UISearchController

@property (nonatomic, weak) id<SearchViewControllerDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
