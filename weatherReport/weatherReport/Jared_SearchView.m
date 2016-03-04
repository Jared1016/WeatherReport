//
//  Jared_SearchView.m
//  weatherReport
//
//  Created by Jared on 16/3/1.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "Jared_SearchView.h"

@implementation Jared_SearchView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
    }
    return self;
}

- (void)setupView{
    
    self.backgroundColor = [UIColor purpleColor];
    
    self.searchTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
    
    [self addSubview:self.searchTable];
    
//    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 40)];
//    
//    [self addSubview:self.searchBar];
}

@end
