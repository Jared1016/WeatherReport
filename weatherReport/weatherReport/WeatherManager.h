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
//定位的城市
@property (nonatomic,strong)NSString *cityName;
//网络状态
@property (nonatomic,assign)NSInteger a;


//选择的城市数组
@property(nonatomic,strong)NSMutableArray *arrayDate;
//选中的城市
@property(nonatomic,strong)NSString *chooseCityName;



+ (instancetype)shareInstance;



//网络请求
- (NSData *)GetSyncActionUrl1:(NSString *)url1 url2:(NSString *)url2 cityName:(NSString *)cityName;

//解析天气状况
- (void)analysisByWeatherChangeData:(NSData *)data;

//写入本地
- (void)writeToLocal;
//读取本地
- (Model *)readFromLocal;

//判断网络状态
-(BOOL) isConnectionAvailable;





@end
