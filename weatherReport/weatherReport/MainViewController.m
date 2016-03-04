//
//  MainViewController.m
//  weatherReport
//
//  Created by lanou3g on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "MainViewController.h"
#import "WeatherManager.h"
#import "ITRAirSideMenu.h"
#import "Model.h"
#import "AppDelegate.h"
#import "WeatherIDModel.h"
#import "CityModel.h"
#import "Masonry.h"
@interface MainViewController ()

@end

@implementation MainViewController

+ (instancetype) controller{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MainViewController class])];
    
}

- (void)loadView{
    [super loadView];
    
    //单例 数据请求
    //    解析
    [self dataRequest];
    

    
    self.mv = [[MainView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.mv;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    

    //单例 数据请求
//    [[WeatherManager shareInstance] GetSyncAction];
    
    //拿到数据 （实验）
//    Model *model = [[WeatherManager shareInstance].arrayToday firstObject];
//    self.mv.labelTemperature.text = model.temperature;
//    NSLog(@"model.temperature = %@",model.temperature);

    //    放View1的数据
    [self setView1];
    // Do any additional setup after loading the view from its nib.
}

//数据请求  和解析
- (void)dataRequest{
    [[WeatherManager shareInstance] analysisByWeatherChangeData:[[WeatherManager shareInstance] GetSyncActionUrl1:get1Url url2:get2Url cityName:nil]];
    
//    [[WeatherManager shareInstance] analysisByWeatherChangeData:[[WeatherManager shareInstance] GetSyncActionUrl1:GETurl1WeatherChange url2:GETurl2WeatherChange cityName:nil]];
    
//    [[WeatherManager shareInstance] analysisWithCityName];
}


//view1的数据
- (void)setView1{
#pragma mark    FirstView
    //拿到today温度数据
    Model *model = [WeatherManager shareInstance].modelAll;
    self.mv.labelTemp.text = [model.temperature stringByAppendingString:@"°"];
    self.mv.labelTemp.font = [UIFont systemFontOfSize:90];
    //温度和湿度
    NSString *temperature = @"";
    temperature = [temperature stringByAppendingFormat:@"%@ %@  湿度:%@",model.direct , model.power ,model.humidity];
    self.mv.labelTemperature.text = temperature;
    self.mv.labelTemperature.font = [UIFont systemFontOfSize:14];

    //晚上的图片还没搞呢
    self.mv.imageToday.image = [UIImage imageNamed:model.img];

    self.mv.labelWeather.text = model.info;
}



- (IBAction)setAction:(UIBarButtonItem *)sender {
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    [itrSideMenu presentLeftMenuViewController];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
