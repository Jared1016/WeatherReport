//
//  Jared_MapAnnotation.m
//  weatherReport
//
//  Created by Jared on 16/3/4.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "Jared_MapAnnotation.h"

@implementation Jared_MapAnnotation

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle coordinate:(CLLocationCoordinate2D)coordinate{
    self = [super init];
    if (self) {
        _title = title;
        _subtitle = subTitle;
        _coordinate = coordinate;
    }
    return self;
}

@end
