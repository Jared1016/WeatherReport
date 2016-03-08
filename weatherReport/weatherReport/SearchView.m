//
//  SearchView.m
//  weatherReport
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}



- (void)setupView{
    self.backgroundColor = [UIColor colorWithRed:0.000 green:1.000 blue:0.868 alpha:1.000];
    
    self.tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self addSubview:self.tableView];
    
}

@end
