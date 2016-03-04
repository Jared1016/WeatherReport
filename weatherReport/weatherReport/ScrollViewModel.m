//
//  SecrollerView.m
//  weatherReport
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "ScrollViewModel.h"

@implementation ScrollViewModel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


- (void)setupView{
    self.labelName= [[UILabel alloc]init];
    [self addSubview:self.labelName];
    self.labelData = [[UILabel alloc]init];
    [self addSubview:self.labelData];
}

@end
