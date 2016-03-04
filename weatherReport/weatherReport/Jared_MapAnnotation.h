//
//  Jared_MapAnnotation.h
//  weatherReport
//
//  Created by Jared on 16/3/4.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Jared_MapAnnotation : NSObject
@property(nonatomic, copy, readonly)NSString *title;

@property(nonatomic, copy, readonly)NSString *subtitle;

@property(nonatomic)CLLocationCoordinate2D coordinate;

- (instancetype)initWithTitle:(NSString *)title subTitle:(NSString *)subTitle coordinate:(CLLocationCoordinate2D)coordinate;
@end
