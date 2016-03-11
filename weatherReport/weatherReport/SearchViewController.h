//
//  SearchViewController.h
//  weatherReport
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchView.h"




@interface SearchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate,UISearchResultsUpdating>

@property(nonatomic,strong)SearchView *sv;
//@property(nonatomic,strong)NSMutableArray *arrayChoose;
//城市总数据
@property (strong, nonatomic) NSArray *arrayData;
@property (strong, nonatomic) NSMutableArray *arrayresult;

@property (strong, nonatomic) UISearchController *searchCT;




@end
