//
//  WeatherManager.h
//  weatherReport
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Model;

@interface WeatherManager : NSObject



@property (nonatomic,strong)NSArray *arrayLife;
@property (nonatomic,strong)NSArray *arrayLifeName;
//@property (nonatomic,strong)NSMutableArray *arrayAll;
@property (nonatomic,strong)Model *modelAll;
//未来7天天气数组
@property (nonatomic,strong)NSMutableArray *arrayDay;
@property (nonatomic,strong)NSMutableArray *arrayDayData;
@property (nonatomic,strong)NSMutableArray *arrayNight;
//通知开关
@property (nonatomic,assign)BOOL active;

+ (instancetype)shareInstance;



//网络请求
- (NSData *)GetSyncActionUrl1:(NSString *)url1 url2:(NSString *)url2 cityName:(NSString *)cityName;
//解析今天和未来7天的天气
- (void)analysisByCityNameData:(NSData *)data;

//解析每天的不同时间段的天气状况
- (void)analysisByWeatherChangeData:(NSData *)data;

//解析城市列表
- (void)analysisWithCityName;
//度数切换
@property (nonatomic,assign)BOOL activeCentigrade;




@end
