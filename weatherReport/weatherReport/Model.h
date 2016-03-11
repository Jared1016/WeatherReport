//
//  Model.h
//  weatherReport
//
//  Created by lanou3g on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeatherIDModel;

@interface Model : NSObject
//left
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *chuanyi;
@property(nonatomic,strong)NSString *ganmao;
@property(nonatomic,strong)NSString *kongtiao;
@property(nonatomic,strong)NSString *wuran;
@property(nonatomic,strong)NSString *xiche;
@property(nonatomic,strong)NSString *yundong;
@property(nonatomic,strong)NSString *ziwaixian;
//pm2.5
@property(nonatomic,strong)NSString *cityName;
@property(nonatomic,strong)NSString *dateTime;
@property(nonatomic,strong)NSString *pm25;
@property(nonatomic,strong)NSString *quality;
@property(nonatomic,strong)NSString *des;
//realtime
@property(nonatomic,strong)NSString *time;
@property(nonatomic,strong)NSString *humidity;
@property(nonatomic,strong)NSString *img;
@property(nonatomic,strong)NSString *info;
@property(nonatomic,strong)NSString *direct;
@property(nonatomic,strong)NSString *power;
@property(nonatomic,strong)NSString *windspeed;
@property(nonatomic,strong)NSString *temperature;
//weather
@property(nonatomic,strong)NSString *week;
@property(nonatomic,strong)NSString *nongli;
//现在城市
@property(nonatomic,strong)NSString *nowCity;

@end
