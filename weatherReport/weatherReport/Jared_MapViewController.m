//
//  Jared_MapViewController.m
//  weatherReport
//
//  Created by Jared on 16/3/4.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "Jared_MapViewController.h"
#import <MapKit/MapKit.h>
#import "Jared_MapAnnotation.h"
@interface Jared_MapViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

@property(nonatomic, strong)MKMapView *mapView;

@property(nonatomic, strong)CLLocationManager *manager;

@end

@implementation Jared_MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 创建地图,并加载当前试图
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    // 设置可以显示用户的单位
    self.mapView.showsUserLocation = YES;
    // 设置用户跟谁模式
    [self.mapView setUserTrackingMode:(MKUserTrackingModeFollow) animated:YES];
    
    [self.view addSubview:self.mapView];
    
    self.mapView.delegate = self;
    self.manager.delegate = self;
    
    //创建定位类
    self.manager = [[CLLocationManager alloc] init];
    
    self.manager.distanceFilter = 100.f;
    
    // 判断系统是否大于iOS8.0
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        [self.manager requestAlwaysAuthorization];
    }
    [self.manager startUpdatingLocation];
    
    // Do any additional setup after loading the view.
}


#pragma mark - MKMapDelegate
- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView{
    NSLog(@"开始加载地图");
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    NSLog(@"已经加载完成");
}
- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error{
    NSLog(@"加载失败");
    
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
