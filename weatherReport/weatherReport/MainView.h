//
//  MainView.h
//  weatherReport
//
//  Created by lanou3g on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScrollViewModel;
@class FutureModel;
@interface MainView : UIView

//firstView
@property(nonatomic,strong)UIScrollView *scrollViewFirst;
@property(nonatomic,strong)UIView *firstView;
@property(nonatomic,strong)UILabel *labelTemp;
@property(nonatomic,strong)UILabel *labelWeather;
@property(nonatomic,strong)UIImageView *imageToday;
@property(nonatomic,strong)UILabel *labelTemperature;

//secondView
@property(nonatomic,strong)UIView *secondView;
@property(nonatomic,strong)UILabel *labelForecast;
@property(nonatomic,strong)UIScrollView *scrollViewSecond;

//一天里的不同时间不同温度
@property(nonatomic,strong)ScrollViewModel *model1;
@property(nonatomic,strong)ScrollViewModel *model2;
@property(nonatomic,strong)ScrollViewModel *model3;
@property(nonatomic,strong)ScrollViewModel *model4;
@property(nonatomic,strong)ScrollViewModel *model5;
@property(nonatomic,strong)ScrollViewModel *model6;
@property(nonatomic,strong)ScrollViewModel *model7;
@property(nonatomic,strong)ScrollViewModel *model8;


@property(nonatomic,strong)FutureModel *futureModel1;
@property(nonatomic,strong)FutureModel *futureModel2;
@property(nonatomic,strong)FutureModel *futureModel3;
@property(nonatomic,strong)FutureModel *futureModel4;
@property(nonatomic,strong)FutureModel *futureModel5;
@property(nonatomic,strong)FutureModel *futureModel6;
@property(nonatomic,strong)FutureModel *futureModel7;
@property(nonatomic,strong)FutureModel *futureModel8;


@end
