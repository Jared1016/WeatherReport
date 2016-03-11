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
#import "SearchViewController.h"
#import <Accelerate/Accelerate.h>
@interface MainViewController ()<UIScrollViewDelegate>

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
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.010];
    self.navigationItem.title = self.nowCitytName;
    //导航栏为透明
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0];
    
    self.mv.scrollViewFirst.delegate = self;
    //    放View1的数据
    [self setView1];
    
    [self viewDidAppear:YES];

}

-(void)viewDidAppear:(BOOL)animated{
    if ([WeatherManager shareInstance].activeCentigrade == YES) {
        self.mv.labelTemp.text = [[WeatherManager shareInstance].modelAll.temperature stringByAppendingString:@"℉"];
    }
    if ([WeatherManager shareInstance].activeCentigrade == NO) {
        self.mv.labelTemp.text = [[WeatherManager shareInstance].modelAll.temperature stringByAppendingString:@"℃"];
    }
}

//数据请求  和解析
- (void)dataRequest{
    [[WeatherManager shareInstance] analysisByWeatherChangeData:[[WeatherManager shareInstance] GetSyncActionUrl1:get1Url url2:get2Url cityName:nil]];
    
}


//view1的数据
- (void)setView1{
#pragma mark    FirstView
    //拿到today温度数据
    Model *model = [WeatherManager shareInstance].modelAll;
    self.mv.labelTemp.text = [model.temperature stringByAppendingString:@"°"];
    self.mv.labelTemp.font = [UIFont systemFontOfSize:90];
    self.mv.labelTemp.textAlignment = NSTextAlignmentCenter;
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
    //桌面背景
    
    self.mv.imageView.image = [UIImage imageNamed:model.info];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    Model *model = [WeatherManager shareInstance].modelAll;
    if (self.mv.scrollViewFirst.contentOffset.y / getHeight > 0.3) {
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
    [self presentViewController:nsvc animated:YES completion:nil];
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

- (NSString *)nowCitytName{
    if (!_nowCitytName) {
        _nowCitytName = @"北京";
    }
    return _nowCitytName;
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
