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

#import "Masonry.h"
#import "SearchViewController.h"
#import <Accelerate/Accelerate.h>
#import "ScrollViewModel.h"
#import "FutureModel.h"
#import <CoreLocation/CoreLocation.h>
@interface MainViewController ()<UIScrollViewDelegate,CLLocationManagerDelegate>

@property(nonatomic,strong)CLLocationManager *locationManager;
//@property(nonatomic,strong)Model *model1;
@end

@implementation MainViewController

+ (instancetype) controller{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([MainViewController class])];
    
}

- (void)loadView{
    [super loadView];
    //定位
    [self locationAction];
    
    self.mv = [[MainView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.mv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[WeatherManager shareInstance] isConnectionAvailable]) {
        NSLog(@"数据请求");
        //单例 数据请求  解析
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(dataRequest) name:@"网络请求" object:@"通知"];
        //本地写入
        [[WeatherManager shareInstance] writeToLocal];
    }else{
        [self breakNetWork];
        [WeatherManager shareInstance].modelAll = [[WeatherManager shareInstance] readFromLocal];
        NSLog(@"没有联网的时候 %@",[[WeatherManager shareInstance] readFromLocal]);
        [self setView1];

    }

//    [self performSelector:@selector(normalAction) withObject:nil afterDelay:5];

    //导航栏为透明
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0];

    self.mv.scrollViewFirst.delegate = self;
    [self viewDidAppear:YES];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificationAction) name:@"改变城市" object:@"yanwu"];
    
}
- (void)viewDidAppear:(BOOL)animated{
    [self performSelector:@selector(setView1) withObject:nil afterDelay:1];
}

- (void)breakNetWork{
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请检查网络设置" message:@"联网失败" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

//定位
- (void)locationAction{
    if (![CLLocationManager locationServicesEnabled]) {
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请检查定位设置" message:@"定位失败" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // 初始化定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    // 设置代理
    _locationManager.delegate = self;
    // 设置定位精确度到米
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 设置过滤器为无
    _locationManager.distanceFilter = 10;
    // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
    [_locationManager requestAlwaysAuthorization];//这句话ios8以上版本使用。
    [_locationManager requestWhenInUseAuthorization];
    // 开始定位
    [_locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error){
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            //将获得的所有信息显示到label上
//            NSLog(@"所有信息 == %@", placemark.name);
            //获取城市
            [WeatherManager shareInstance].cityName = placemark.locality;
            if (![WeatherManager shareInstance].cityName) {
                //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                [WeatherManager shareInstance].cityName = placemark.administrativeArea;
            }
            NSLog(@"[WeatherManager shareInstance].cityName = %@", [WeatherManager shareInstance].cityName);
            [[NSNotificationCenter defaultCenter]postNotificationName:@"网络请求" object:@"通知"];
        }
        else if (error == nil && [array count] == 0)
        {
            NSLog(@"No results were returned.");
        }
        else if (error != nil)
        {
            NSLog(@"An error occurred = %@", error);
        }
    }];
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    [manager stopUpdatingLocation];
}



//开始取消菊花
- (void)normalAction{
    //取消view
    UIActivityIndicatorView *act = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [act stopAnimating];
    UIView *view = (UIView*)[self.view viewWithTag:108];
    [view removeFromSuperview];
    NSLog(@"加载完成");
}



//数据请求  和解析
- (void)dataRequest{
    NSLog(@"网络解析这的cityName = %@",[WeatherManager shareInstance].cityName);
    if (![WeatherManager shareInstance].cityName) {
        
        UIAlertAction *action = [UIAlertAction  actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"定位失败" message:@"请检查一下定位是否打开" preferredStyle:UIAlertControllerStyleAlert];
        [ac addAction:action];
        Model *model = [WeatherManager shareInstance].readFromLocal;
        if (!model) {
            return;
        }
        [[WeatherManager shareInstance] analysisByWeatherChangeData:[[WeatherManager shareInstance] GetSyncActionUrl1:get1Url url2:get2Url cityName:model.nowCity]];
        return;
    }
    [[WeatherManager shareInstance] analysisByWeatherChangeData:[[WeatherManager shareInstance] GetSyncActionUrl1:get1Url url2:get2Url cityName:[WeatherManager shareInstance].cityName]];
//    self.model1 = [WeatherManager shareInstance].modelAll;
    NSLog(@"modelAll = %@",[WeatherManager shareInstance].modelAll);
    //桌面标题为定位城市
        self.chooseName = [WeatherManager shareInstance].cityName;
    
    [self setView1];
    //取消菊花
    [self normalAction];
}

//view1的数据
- (void)setView1{
#pragma mark    FirstView
    if (![WeatherManager shareInstance].modelAll) {
        //动画不停止
//        self.mv.imageViewAnimation.animationRepeatCount = 0;
//        [self.mv.imageViewAnimation startAnimating];
        NSLog(@"在这边停的");
        return;
    }
    //拿到today温度数据
    NSLog(@"走的这边");
    Model *model = [WeatherManager shareInstance].modelAll;
    self.mv.labelTemp.text = [model.temperature stringByAppendingString:@"°"];
    self.mv.labelTemp.font = [UIFont systemFontOfSize:90];
    self.mv.labelTemp.textAlignment = NSTextAlignmentLeft;
    self.mv.labelTemp.textColor = [UIColor whiteColor];
    //温度和湿度
    NSString *temperature = @"";
    temperature = [temperature stringByAppendingFormat:@"%@ %@  湿度:%@",model.direct , model.power ,model.humidity];
    self.mv.labelTemperature.text = temperature;
    self.mv.labelTemperature.font = [UIFont systemFontOfSize:14];
    self.mv.labelTemperature.textColor = [UIColor whiteColor];
    //晚上的图片还没搞呢
    self.mv.imageToday.image = [UIImage imageNamed:model.img];
    self.mv.labelWeather.text = model.info;
    self.mv.labelWeather.textColor = [UIColor whiteColor];
    //今天的日期
    NSLog(@"%@",model.date);
    model.date = [model.date stringByReplacingOccurrencesOfString:@"-" withString:@"."];
    self.mv.labelToday.text = model.date;
    self.mv.labelToday.font = [UIFont systemFontOfSize:14];
    self.mv.labelToday.textColor = [UIColor whiteColor];
    self.mv.labelToday.textAlignment = NSTextAlignmentRight;
    //桌面背景
    
    self.mv.imageView.image = [UIImage imageNamed:model.info];
    NSLog(@"model.info = %@",model.info);
    
    //桌面标题
    NSLog(@" biaoti%@",[WeatherManager shareInstance].cityName);
    
    self.navigationItem.title = self.chooseName;
    
    
     //放剩下的数据
    if ([WeatherManager shareInstance].modelAll) {
        [self setView2];
//        [self performSelector:@selector(setView2) withObject:nil afterDelay:2];
    }
}


- (void)setView2{
    int i = 0;
    for (ScrollViewModel *view in self.mv.modelArray) {
        //model1里面的各种label的数据
        view.labelData.text = [WeatherManager shareInstance].arrayLife[i];
        view.labelData.textAlignment = NSTextAlignmentCenter;
        view.labelData.textColor = [UIColor whiteColor];
        view.labelName.text = [WeatherManager shareInstance].arrayLifeName[i];
        view.labelName.textAlignment = NSTextAlignmentCenter;
        view.labelName.textColor = [UIColor whiteColor];
        view.labelData.font = [UIFont systemFontOfSize:16];
        i = i + 1;
    }
    int j = 0;
    for (FutureModel *view in self.mv.futureModelArray) {
        //星期几
        Model *model = [WeatherManager shareInstance].arrayDayData[j+1];
        NSString *stringDay = @" 星期";
        view.labelWeak.text = [stringDay stringByAppendingFormat:@"%@",model.week];
        view.labelWeak.textColor = [UIColor whiteColor];
        NSArray *array = [WeatherManager shareInstance].arrayDay[j+1];
        //温度和风力
        NSString *string = @"    ";
        string = [string stringByAppendingFormat:@"%@",array[2]];
        string = [string stringByAppendingFormat:@"°       %@",array[4]];
        view.labelTemperature.text = string;
        view.labelTemperature.textColor = [UIColor whiteColor];
        view.labelTemperature.textAlignment = NSTextAlignmentCenter;
        //图片
        view.imageWeather.image = [UIImage imageNamed:array[0]];
        j = j + 1;
    }
    
    int k = 0;
    NSArray *dataArray = @[@"农历", @"天气", @"最高温度", @"风向"];

    Model *model = [WeatherManager shareInstance].arrayDayData[0];
    NSArray *array = [WeatherManager shareInstance].arrayNight[0];
    NSArray *dataArray2 = @[model.nongli, array[1], [array[2] stringByAppendingString:@"°"], array[3]];
    //夜里天气图片
    self.mv.imageBig.image = [UIImage imageNamed:[array[0] stringByAppendingString:@"GN.png"]];
    NSLog(@"%@",[array[0] stringByAppendingString:@"GN"]);
    for (FutureModel *view in self.mv.nightArray) {
        [self.mv.thirdView addSubview:view];
        
        view.labelWeak.text = dataArray[k];
        view.labelWeak.textColor = [UIColor whiteColor];
        view.labelWeak.textAlignment = NSTextAlignmentCenter;
        view.labelTemperature.text = dataArray2[k];
        view.labelTemperature.textColor = [UIColor whiteColor];
        view.labelTemperature.textAlignment = NSTextAlignmentRight;
        
        k = k + 1;
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    Model *model = [WeatherManager shareInstance].modelAll;
    if (self.mv.scrollViewFirst.contentOffset.y / getHeight > 0.3 && model.info) {
        CGFloat blur = self.mv.scrollViewFirst.contentOffset.y / getHeight - 0.2;
        self.mv.imageView.image = [self blurryImage:[UIImage imageNamed:model.info]withBlurLevel:blur];
    }else{
        self.mv.imageView.image = [UIImage imageNamed:model.info];
    }
}


- (IBAction)setAction:(UIBarButtonItem *)sender {
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    [itrSideMenu presentLeftMenuViewController];
}


- (IBAction)addCityAction:(UIBarButtonItem *)sender {
    SearchViewController *svc = [[SearchViewController alloc]init];
    UINavigationController *nsvc = [[UINavigationController alloc]initWithRootViewController:svc];
//    svc.delegate = self;
//    svc.arrayChoose = [WeatherManager shareInstance].arrayDate;
    [self presentViewController:nsvc animated:YES completion:nil];
}
//通知方法
- (void)notificationAction{
    [[WeatherManager shareInstance] analysisByWeatherChangeData:[[WeatherManager shareInstance] GetSyncActionUrl1:get1Url url2:get2Url cityName:[WeatherManager shareInstance].chooseCityName]];
    self.chooseName = [WeatherManager shareInstance].chooseCityName;
    NSLog(@"通知方法主界面");
}




- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    //模糊度,
    if ((blur < 0.1f) || (blur > 2.0f)) {
        blur = 0.5f;
    }
    
    //boxSize必须大于0
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    NSLog(@"boxSize:%i",boxSize);
    //图像处理
    CGImageRef img = image.CGImage;
    //需要引入#import <Accelerate/Accelerate.h>
    /*
     This document describes the Accelerate Framework, which contains C APIs for vector and matrix math, digital signal processing, large number handling, and image processing.
     本文档介绍了Accelerate Framework，其中包含C语言应用程序接口（API）的向量和矩阵数学，数字信号处理，大量处理和图像处理。
     */
    
    //图像缓存,输入缓存，输出缓存
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    //像素缓存
    void *pixelBuffer;
    
    //数据源提供者，Defines an opaque type that supplies Quartz with data.
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    // provider’s data.
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    //宽，高，字节/行，data
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //像数缓存，字节行*图片高
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    
    // 第三个中间的缓存区,抗锯齿的效果
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //Convolves a region of interest within an ARGB8888 source image by an implicit M x N kernel that has the effect of a box filter.
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //    NSLog(@"字节组成部分：%zu",CGImageGetBitsPerComponent(img));
    //颜色空间DeviceRGB
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //用图片创建上下文,CGImageGetBitsPerComponent(img),7,8
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    //根据上下文，处理过的图片，重新组件
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
//    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
//    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
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
