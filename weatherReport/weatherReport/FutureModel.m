//
//  FutureModel.m
//  weatherReport
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "FutureModel.h"

@implementation FutureModel


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}



- (void)setupView{
    self.labelTemperature = [[UILabel alloc]init];
    [self addSubview:self.labelTemperature];
    self.labelWeak = [[UILabel alloc]init];
    [self addSubview:self.labelWeak];
    self.imageWeather = [[UIImageView alloc]init];
    [self addSubview:self.imageWeather];

    
}


@end
