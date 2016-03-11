//
//  MainView.m
//  weatherReport
//
//  Created by lanou3g on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "MainView.h"
#import "Masonry.h"
#import "ScrollViewModel.h"
#import "Model.h"
#import "FutureModel.h"
#import "WeatherManager.h"
#import "WeatherIDModel.h"
#import "WeatherChangesModel.h"

@interface MainView ()


@end

@implementation MainView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}


- (void)setupView{
    self.backgroundColor = [UIColor colorWithRed:0.892 green:0.992 blue:0.610 alpha:1];
    
    //imageView
    self.imageView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self addSubview:self.imageView];
    __weak UIView *sv = self;
//    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(sv.mas_top).offset(0);
//        make.left.equalTo(sv.mas_left).offset(0);
//        make.right.equalTo(sv.mas_right).offset(0);
//        make.bottom.equalTo(sv.mas_bottom).offset(0);
//    }];
    
    //scrollViewFirst
    self.scrollViewFirst = [[UIScrollView alloc]init];
    self.scrollViewFirst.showsHorizontalScrollIndicator = NO;
    self.scrollViewFirst.showsVerticalScrollIndicator = NO;
    self.scrollViewFirst.bounces = NO;
    [self addSubview:self.scrollViewFirst];
    
    
    [_scrollViewFirst mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(sv).width.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(sv.mas_top).offset(0);
        make.left.equalTo(sv.mas_left).offset(0);
        make.right.equalTo(sv.mas_right).offset(0);
        make.bottom.equalTo(sv.mas_bottom).offset(0);
    }];
    
    //scrollView上添加一个内容视图
    UIView *container = [UIView new];
    [_scrollViewFirst addSubview:container];
    
    
    //约束宽 和scrollview一样大小
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollViewFirst);
        make.width.equalTo(_scrollViewFirst);
    }];


    
    //firstView
    self.firstView = [[UIView alloc]init];
    [_scrollViewFirst addSubview:self.firstView];

    //约束宽和高
    int height = getHeight - 200;
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(height);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(@200);
    }];

    //今天的天气图片
    self.imageToday = [[UIImageView alloc]init];
    [self.firstView addSubview:self.imageToday];
    [self.imageToday mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_firstView.mas_top).offset(0);
        make.left.equalTo(_firstView.mas_left).offset(0);
//        make.bottom.equalTo(_firstView.mas_bottom).offset(0);
        make.right.equalTo(_firstView.mas_left).offset(40);
        make.height.equalTo(@40);
    }];
    //今天的天气状态
    self.labelWeather = [[UILabel alloc]init];
    [self.firstView addSubview:self.labelWeather];
    [self.labelWeather mas_makeConstraints:^(MASConstraintMaker *make) {

        make.top.equalTo(_firstView.mas_top).offset(0);
        make.left.equalTo(_imageToday.mas_right).offset(10);
        make.right.equalTo(_imageToday.mas_left).offset(130);
        make.height.equalTo(@40);
    }];

    //今天的风
    self.labelTemperature = [[UILabel alloc]init];
    [self.firstView addSubview:self.labelTemperature];
    [self.labelTemperature mas_makeConstraints:^(MASConstraintMaker *make) {
 
        make.top.equalTo(_imageToday.mas_bottom).with.offset(0);
        make.left.equalTo(_firstView.mas_left).with.offset(0);
//        make.bottom.equalTo(_labelTemp.mas_top).with.offset(0);
        make.right.equalTo(_firstView.mas_right).offset(0);
        make.height.equalTo(@40);
        
    }];
    
    //今天的温度

    self.labelTemp = [[UILabel alloc]init];
    [self.firstView addSubview:self.labelTemp];
    [self.labelTemp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labelTemperature.mas_bottom).offset(0);
        make.left.equalTo(_firstView.mas_left).offset(0);
        make.bottom.equalTo(_firstView.mas_bottom).offset(0);
        make.right.equalTo(_firstView.mas_left).offset(200);
    }];
    
    
    //Second  View
    self.secondView = [[UIView alloc]init];
    [_scrollViewFirst addSubview:self.secondView];
    self.secondView.backgroundColor = [UIColor colorWithWhite:0.002 alpha:0.2];
    
    // SecondView约束宽和高
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstView.mas_bottom).offset(0);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(@425);
    }];
    
    //预报
    self.labelForecast = [[UILabel alloc]init];
    [self.secondView addSubview:self.labelForecast];
    self.labelForecast.text = @" 预报";
    self.labelForecast.textColor = [UIColor whiteColor];
    [self.labelForecast mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.secondView.mas_top).with.offset(0);
        make.left.equalTo(self.secondView.mas_left).with.offset(0);
//        make.bottom.equalTo(self.secondView.mas_bottom).offset(-420);
        make.right.equalTo(self.secondView.mas_right).with.offset(-0);
        make.height.equalTo(@50);
    }];
    
    //第二个scrollView
    self.scrollViewSecond = [[UIScrollView alloc]init];
    self.scrollViewSecond.showsVerticalScrollIndicator = NO;
    self.scrollViewSecond.showsHorizontalScrollIndicator = NO;
    self.scrollViewSecond.bounces = NO;
    
    [self.secondView addSubview:self.scrollViewSecond];
    [self.scrollViewSecond mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.secondView).with.insets(UIEdgeInsetsMake(50, 0, 70, 0));
        make.top.equalTo(self.secondView.mas_top).offset(50);
        make.left.equalTo(self.secondView.mas_left).with.offset(0);
//        make.bottom.equalTo(self.secondView.mas_bottom).with.offset(-300);
        make.right.equalTo(self.secondView.mas_right).with.offset(-0);
        make.height.equalTo(@80);
    }];
    
    //scrollView上添加一个内容视图
    UIView *container2 = [UIView new];
    [_scrollViewSecond addSubview:container2];
    
    //约束宽 和scrollview一样大小
    [container2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollViewSecond);
        make.width.equalTo(@680);
        make.height.equalTo(_scrollViewSecond);
        make.bottom.equalTo(_scrollViewSecond);
    }];


//    scrollView 里的模板设置
    self.model1 = [[ScrollViewModel alloc]init];
    self.model2 = [[ScrollViewModel alloc]init];
    self.model3 = [[ScrollViewModel alloc]init];
    self.model4 = [[ScrollViewModel alloc]init];
    self.model5 = [[ScrollViewModel alloc]init];
    self.model6 = [[ScrollViewModel alloc]init];
    self.model7 = [[ScrollViewModel alloc]init];
    
    NSArray *modelArray = @[_model1, _model2, _model3, _model4, _model5, _model6, _model7];
    //第二个scrollView里的约束
    UIView *lastView;
    
    int i = 0;
    for (ScrollViewModel *view in modelArray) {
        [self.scrollViewSecond addSubview:view];
        //model1里面的各种label的数据
        view.labelData.text = [WeatherManager shareInstance].arrayLife[i];
        view.labelData.textAlignment = NSTextAlignmentCenter;
        view.labelData.textColor = [UIColor whiteColor];
        view.labelName.text = [WeatherManager shareInstance].arrayLifeName[i];
        view.labelName.textAlignment = NSTextAlignmentCenter;
        view.labelName.textColor = [UIColor whiteColor];
        view.labelData.font = [UIFont systemFontOfSize:16];
        i = i + 1;
        //约束
        [view.labelName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(0);
            make.left.equalTo(view.mas_left).offset(0);
            make.bottom.equalTo(view.labelData.mas_top).offset(0);
            make.right.equalTo(view.mas_right).offset(0);
            make.height.equalTo(view.labelData);
        }];

        [view.labelData mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.labelName.mas_bottom).offset(0);
            make.left.equalTo(view.mas_left).offset(0);
            make.bottom.equalTo(view.mas_bottom).offset(-0);
            make.right.equalTo(view.mas_right).offset(-0);
            make.height.equalTo(view.labelName);
        }];

        //model1的约束
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(_scrollViewSecond);
                make.left.equalTo(lastView.mas_right).offset(0);
                make.width.equalTo(lastView);
            }];
        }else{
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_scrollViewSecond).offset(0);
                make.top.bottom.equalTo(_scrollViewSecond);
            }];
        }
        lastView = view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_scrollViewSecond);
    }];
    
//    未来6天的天气
    self.futureModel1 = [[FutureModel alloc]init];
    self.futureModel2 = [[FutureModel alloc]init];
    self.futureModel3 = [[FutureModel alloc]init];
    self.futureModel4 = [[FutureModel alloc]init];
    self.futureModel5 = [[FutureModel alloc]init];
    self.futureModel6 = [[FutureModel alloc]init];

    
    NSArray *futureModelArray = @[_futureModel1, _futureModel2, _futureModel3, _futureModel4, _futureModel5, _futureModel6];
    //未来6天天气模板里的约束
    UIView *lastView2;

    int j = 0;
    for (FutureModel *view in futureModelArray) {
        [self.secondView addSubview:view];

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
//        model2里面的各种label的约束
        //星期几
        [view.labelWeak mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(0);
            make.left.equalTo(view.mas_left).offset(0);
            make.bottom.equalTo(view.mas_bottom).offset(0);
            make.right.equalTo(view.imageWeather.mas_left).offset(0);
        }];
        //里面的图片
        [view.imageWeather mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(5);
            make.left.equalTo(view.labelWeak.mas_right).offset(0);
            make.bottom.equalTo(view.mas_bottom).offset(-5);
//            make.right.equalTo(view.mas_right).offset(-114);
            make.right.equalTo(view.labelTemperature.mas_left).offset(0);
            make.width.equalTo(@40);
            make.centerX.equalTo(view.mas_centerX);
        }];
        //里面的温度
        [view.labelTemperature mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(0);
            make.left.equalTo(view.imageWeather.mas_right).offset(0);
            make.bottom.equalTo(view.mas_bottom).offset(-0);
            make.right.equalTo(view.mas_right).offset(-0);
//            make.width.equalTo(@120);
        }];
        //6天整个view的约束
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.and.right.equalTo(_secondView);
            make.left.equalTo(self.secondView.mas_left).with.offset(0);
            make.right.equalTo(_secondView.mas_right).offset(-0);
            make.height.mas_equalTo(50);

            if (lastView2) {
                make.top.mas_equalTo(lastView2.mas_bottom);
            }else{
                make.top.mas_equalTo(_scrollViewSecond.mas_bottom);
            }
        }];
        
        lastView2 = view;
    }

    //thirdView   夜里天气view
    _thirdView = [[UIView alloc]init];
    [_scrollViewFirst addSubview:self.thirdView];
    _thirdView.backgroundColor = [UIColor colorWithWhite:0.010 alpha:0.2];
    // 约束宽和高
    [self.thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.secondView.mas_bottom).offset(10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.mas_equalTo(@200);
    }];
    
    //夜里天气label
    _labelNight = [[UILabel alloc]init];
    [_thirdView addSubview:_labelNight];
    _labelNight.text = @"夜晚天气";
    _labelNight.textColor = [UIColor whiteColor];
    [self.labelNight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.thirdView.mas_top).offset(0);
        make.left.equalTo(self.thirdView.mas_left).offset(0);
        make.right.equalTo(self.thirdView.mas_right).offset(0);
        make.height.equalTo(@40);
    }];
    

    //thirdView里面的数据
    FutureModel *futureModel7 = [[FutureModel alloc]init];
    FutureModel *futureModel8 = [[FutureModel alloc]init];
    FutureModel *futureModel9 = [[FutureModel alloc]init];
    FutureModel *futureModel10 = [[FutureModel alloc]init];
    
    NSArray *nightArray = @[futureModel7, futureModel8, futureModel9, futureModel10];
    //夜里天气模板里的约束
    UIView *lastView3;
    NSArray *dataArray = @[@"农历", @"天气", @"最高温度", @"风向"];
    int k = 0;
    
    Model *model = [WeatherManager shareInstance].arrayDayData[0];
    
    NSArray *array = [WeatherManager shareInstance].arrayNight[0];
    NSArray *dataArray2 = @[model.nongli, array[1], [array[2] stringByAppendingString:@"°"], array[3]];
    //夜里天气图片
    self.imageBig = [[UIImageView alloc]init];
    [self.thirdView addSubview:self.imageBig];
    self.imageBig.image = [UIImage imageNamed:[array[0] stringByAppendingString:@"GN.png"]];
    NSLog(@"%@",[array[0] stringByAppendingString:@"GN"]);
    [self.imageBig mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.labelNight.mas_bottom).offset(20);
        make.bottom.equalTo(self.thirdView.mas_bottom).offset(-20);
        make.left.equalTo(self.thirdView.mas_left).offset(0);
//        make.right.equalTo(self.thirdView.mas_right).offset(0);
        make.width.equalTo(@120);
    }];
    
    
    
    
    
    for (FutureModel *view in nightArray) {
        [self.thirdView addSubview:view];

        view.labelWeak.text = dataArray[k];
        view.labelWeak.textColor = [UIColor whiteColor];
        view.labelWeak.textAlignment = NSTextAlignmentCenter;
        view.labelTemperature.text = dataArray2[k];
        view.labelTemperature.textColor = [UIColor whiteColor];
        view.labelTemperature.textAlignment = NSTextAlignmentRight;

        k = k + 1;
        //  model3里面的各种label的约束
        //夜里的各种数据名称
        [view.labelWeak mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(0);
            make.left.equalTo(view.mas_left).offset(0);
            make.bottom.equalTo(view.mas_bottom).offset(0);
            make.right.equalTo(view.imageWeather.mas_left).offset(0);
        }];
        //
        [view.imageWeather mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(0);
            make.left.equalTo(view.labelWeak.mas_right).offset(0);
            make.bottom.equalTo(view.mas_bottom).offset(-0);
            //            make.right.equalTo(view.mas_right).offset(-114);
            make.right.equalTo(view.labelTemperature.mas_left).offset(0);
            make.width.equalTo(@0);
        }];
        //夜里各种数据
        [view.labelTemperature mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_top).offset(0);
            make.left.equalTo(view.imageWeather.mas_right).offset(0);
            make.bottom.equalTo(view.mas_bottom).offset(-0);
            make.right.equalTo(view.mas_right).offset(-0);
            make.width.equalTo(@95);
        }];
        
        //夜间天气整个view的约束
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            //            make.left.and.right.equalTo(_secondView);
            make.left.equalTo(self.thirdView.mas_left).with.offset(120);
            make.right.equalTo(self.thirdView.mas_right).offset(-0);
            make.height.mas_equalTo(40);
            
            if (lastView3) {
                make.top.mas_equalTo(lastView3.mas_bottom);
            }else{
                make.top.mas_equalTo(self.labelNight.mas_bottom);
            }
        }];
        lastView3 = view;
    }
    
    //scrollview的底部和最后一个视图的底部重合  自动计算scrollview的高
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.thirdView.mas_bottom);
    }];
    

    
    
    
    
}

@end
