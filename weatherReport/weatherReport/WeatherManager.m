//
//  WeatherManager.m
//  weatherReport
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "WeatherManager.h"
#import "Model.h"
#import "CityModel.h"
#import "LB_NetTools.h"
//#import "LocalModel.h"
#import "Reachability.h"

@interface WeatherManager ()
//判断网络状态
@property (nonatomic, strong) Reachability *conn;

@end


static WeatherManager *manager = nil;
@implementation WeatherManager




+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [WeatherManager new];
    });
    return manager;
}


//标示用的
//- (NSDictionary *)arrayMark{
//    if (!_arrayMark) {
//        _arrayMark = [NSDictionary dictionaryWithObjectsAndKeys:@"晴",@"00",@"多云",@"01",@"阴",@"02",@"阵雨",@"03",@"雷阵雨",@"04",@"雷阵雨伴有冰雹",@"05",@"雨夹雪",@"06",@"小雨",@"07",@"中雨",@"08",@"大雨",@"9",@"暴雨",@"10",@"大暴雨",@"11",@"特大暴雨",@"12",@"阵雪",@"13",@"小雪",@"14",@"中雪",@"15",@"大雪",@"16",@"暴雪",@"17",@"雾",@"18",@"冻雨",@"19",@"沙尘暴",@"20",@"小雨-中雨",@"21",@"中雨-大雨",@"22",@"大雨-暴雨",@"23",@"暴雨-大暴雨",@"24",@"大暴雨-特大暴雨",@"25",@"小雪-中雪",@"26",@"中雪-大雪",@"27",@"大雪-暴雪",@"28",@"浮尘",@"29",@"扬沙",@"30",@"强沙尘暴",@"31",@"霾",@"53", nil];
//    }
//    return _arrayMark;
//}

<<<<<<< HEAD

- (BOOL)activeCentigrade{
    if (!_activeCentigrade) {
        _activeCentigrade =  NO;
    }
    return _activeCentigrade;
=======
//懒加载
- (NSMutableArray *)arrayDate{
    if (!_arrayDate) {
        _arrayDate = [NSMutableArray arrayWithObjects:@"城市列表" ,nil];
    }
    return _arrayDate;
>>>>>>> cddd5bc1e2ff8f3643d845b54bd0b46bfd3a0676
}

- (NSArray *)arrayLife{
    if (!_arrayLife) {
        _arrayLife = [NSArray array];
    }
    return _arrayLife;
}

- (BOOL)active{
    if (!_active) {
        _active = NO;
    }
    return _active;
}

- (NSMutableArray *)arrayDayData{
    if (!_arrayDayData) {
        _arrayDayData = [NSMutableArray array];
    }
    return _arrayDayData;
}

- (NSMutableArray *)arrayDay{
    if (!_arrayDay) {
        _arrayDay = [NSMutableArray array];
    }
    return _arrayDay;
}

- (NSMutableArray *)arrayNight{
    if (!_arrayNight) {
        _arrayNight = [NSMutableArray array];
    }
    return _arrayNight;
}

//网络请求
- (NSData *)GetSyncActionUrl1:(NSString *)url1 url2:(NSString *)url2 cityName:(NSString *)cityName{
    //1.生成URL
//    NSLog(@"解析里面的cityNaME = %@", cityName);
    NSString *city = [cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [url1 stringByAppendingString:city];
    urlStr =  [urlStr stringByAppendingString:url2];
    NSLog(@"%@",urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    //2 网络请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //3.发送请求
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //    NSLog(@"%@", data);
    return data;
}

//解析
- (void)analysisByWeatherChangeData:(NSData *)data{
    //json解析
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSDictionary *resultDic = [dic objectForKey:@"result"];
    NSDictionary *dataDic = [resultDic objectForKey:@"data"];
    //生活
    NSDictionary *lifeDic = [dataDic objectForKey:@"life"];
    Model *modelLift = [[Model alloc]init];
    modelLift.date = [lifeDic objectForKey:@"date"];
    NSDictionary *info = [lifeDic objectForKey:@"info"];
    
    modelLift.chuanyi = [[info objectForKey:@"chuanyi"] firstObject];
    modelLift.ganmao = [[info objectForKey:@"ganmao"] firstObject];
    modelLift.kongtiao = [[info objectForKey:@"kongtiao"] firstObject];
    modelLift.wuran = [[info objectForKey:@"wuran"] firstObject];
    modelLift.xiche = [[info objectForKey:@"xiche"] firstObject];
    modelLift.yundong = [[info objectForKey:@"yundong"] firstObject];
    modelLift.ziwaixian = [[info objectForKey:@"ziwaixian"] firstObject];
    self.arrayLife = @[modelLift.chuanyi, modelLift.ganmao, modelLift.kongtiao, modelLift.wuran, modelLift.xiche, modelLift.yundong, modelLift.ziwaixian];
    self.arrayLifeName = [NSArray array];
    self.arrayLifeName =@[@"穿衣指数", @"感冒指数", @"空调指数", @"污染指数", @"洗车指数", @"运动指数", @"紫外线"];
    //pm2.5
    NSDictionary *pm25Dic = [dataDic objectForKey:@"pm25"];
    _modelAll = [[Model alloc]init];
    _modelAll.cityName = [pm25Dic objectForKey:@"cityName"];
    _modelAll.dateTime = [pm25Dic objectForKey:@"dateTime"];
    NSDictionary *pm25Dic2= [pm25Dic objectForKey:@"pm25"];
    [_modelAll setValuesForKeysWithDictionary:pm25Dic2];
    //realtime
    NSDictionary *realtimeDic = [dataDic objectForKey:@"realtime"];
    _modelAll.time = [realtimeDic objectForKey:@"time"];
    _modelAll.date = [realtimeDic objectForKey:@"date"];
    NSDictionary *weatherDic = [realtimeDic objectForKey:@"weather"];
    [_modelAll setValuesForKeysWithDictionary:weatherDic];
    NSDictionary *windDic = [realtimeDic objectForKey:@"wind"];
    [_modelAll setValuesForKeysWithDictionary:windDic];
    //weather
    for (NSDictionary *weatherDic in [dataDic objectForKey:@"weather"]) {
        Model *modelDay = [[Model alloc]init];
        modelDay.week = [weatherDic objectForKey:@"week"];
        modelDay.nongli = [weatherDic objectForKey:@"nongli"];
        NSDictionary *infoDic = [weatherDic objectForKey:@"info"];
        NSArray *dayArray = [NSArray arrayWithArray:[infoDic objectForKey:@"day"]];
        NSArray *nightArray = [NSArray arrayWithArray:[infoDic objectForKey:@"night"]];
        [self.arrayDay addObject:dayArray];
        [self.arrayDayData addObject:modelDay];
        [self.arrayNight addObject:nightArray];
    }
}

- (void)writeToLocal{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    _modelAll.nowCity = _chooseCityName;
    [archiver encodeObject:_modelAll forKey:@"modelAll"];
    [archiver finishEncoding];
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingString:@"model.dat"];
    NSLog(@"本地路径为： %@",path);
    [data writeToFile:path atomically:YES];
}

- (Model *)readFromLocal{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    path = [path stringByAppendingString:@"model.dat"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    Model *model = [unarchiver decodeObjectForKey:@"modelAll"];
    return model;
}


-(BOOL) isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            NSLog(@"3G");
            break;
    }
    return isExistenceNetwork;
}


//- (NSString *)nowTime:(int)count{
//    NSTimeInterval time = 8 * 60 *60 + (24 * 60 * 60 * count);
//    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:time];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyyMMdd"];
//    return [formatter stringFromDate:date];
//}





@end
