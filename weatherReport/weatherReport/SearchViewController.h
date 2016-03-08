//
//  SearchViewController.h
//  weatherReport
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchView.h"

@protocol delegateDate <NSObject>

- (void)addDateCityName:(NSString *)cityName;

@end


@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchResultsUpdating>

@property(nonatomic,strong)SearchView *sv;
@property(nonatomic,strong)NSMutableArray *arrayChoose;
//城市总数据
@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) NSMutableArray *arrayresult;

@property (strong, nonatomic) UISearchController *searchCT;

@property (nonatomic,strong)id<delegateDate> delegate;


////搜索框的字符
//@property(nonatomic,strong)NSString *result;

@end
