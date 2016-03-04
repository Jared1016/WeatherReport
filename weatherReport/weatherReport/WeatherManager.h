//
//  WeatherManager.h
//  weatherReport
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class WeatherIDModel;
@class Model;

@interface WeatherManager : NSObject

//@property(nonatomic,strong)Model *modelLift;


@property (nonatomic,strong)NSArray *arrayLife;
@property (nonatomic,strong)NSArray *arrayLifeName;
//@property (nonatomic,strong)NSMutableArray *arrayAll;
@property (nonatomic,strong)Model *modelAll;
//未来7天天气数组
@property (nonatomic,strong)NSMutableArray *arrayDay;
@property (nonatomic,strong)NSMutableArray *arrayDayData;
////未来7天


//@property (nonatomic,strong)NSMutableArray *arrayToday;
//
////mark
//@property (nonatomic,strong)NSDictionary *arrayMark;
//
//////weatherIDModel
////@property (nonatomic,strong)WeatherIDModel *modelID;
//
////一天中的不同时间温度
//@property (nonatomic,strong)NSMutableArray *arrayWeatherChange;
////城市列表名称
//@property (nonatomic,strong)NSMutableArray *arrayCityName;
////weatherID
//@property (nonatomic,strong)NSMutableArray *arrayWeatherID;
+ (instancetype)shareInstance;



//网络请求
- (NSData *)GetSyncActionUrl1:(NSString *)url1 url2:(NSString *)url2 cityName:(NSString *)cityName;
//解析今天和未来7天的天气
- (void)analysisByCityNameData:(NSData *)data;

//解析每天的不同时间段的天气状况
- (void)analysisByWeatherChangeData:(NSData *)data;

//解析城市列表
- (void)analysisWithCityName;





@end
