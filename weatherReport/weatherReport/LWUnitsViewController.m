//
//  LWUnitsViewController.m
//  weatherReport
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 刘斌. All rights reserved.
//
#import "WeatherManager.h"
#import "Model.h"
#import "LWUnitsViewController.h"
#import "LWUnitsTableViewCell.h"
#import "LWUnitsLongTableViewCell.h"
@interface LWUnitsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *LWUnitsTableView;
@end

@implementation LWUnitsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"单位";
    
    self.view.backgroundColor = [UIColor colorWithRed:0.1436 green:0.1393 blue:0.1276 alpha:1.0];
    
    // 初始化TableView
    self.LWUnitsTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    // 设置代理
    self.LWUnitsTableView.dataSource = self;
    self.LWUnitsTableView.delegate = self;
    // 设置背景颜色为透明色
    _LWUnitsTableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_LWUnitsTableView];
    // Do any additional setup after loading the view.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate 代理方法

#pragma mark 返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
#pragma mark 返回内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *EnumCell = nil;
    // 根据indexPath.section 使用不同的cell
    if (indexPath.section == 0) {
        LWUnitsTableViewCell *Cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (Cell == nil) {
            Cell = [[LWUnitsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cells"];
        }
        [Cell.LWUnitSegment addTarget:self action:@selector(UnitsTableView) forControlEvents:UIControlEventValueChanged];
        EnumCell = Cell;
    }
    
    EnumCell.backgroundColor = [UIColor clearColor];

    return EnumCell;
}
#pragma mark - 温度单位点击事案件
-(void)UnitsTableView{
    //摄氏度切换
    //拿到today温度数据
    Model *model = [WeatherManager shareInstance].modelAll;
    if ([WeatherManager shareInstance].activeCentigrade == NO) {
        [WeatherManager shareInstance].activeCentigrade = YES;

        int temperature = [model.temperature intValue];

        temperature = 32 + temperature * 1.8;
        [WeatherManager shareInstance].modelAll.temperature = [NSString stringWithFormat:@"%d", temperature];
        NSLog(@"wen度%d",temperature);
    }else{
        [WeatherManager shareInstance].activeCentigrade = NO;

        int temperature = [model.temperature intValue];
        temperature =(temperature - 32) / 1.8;
        [WeatherManager shareInstance].modelAll.temperature = [NSString stringWithFormat:@"%d", temperature];
        NSLog(@"华氏度%d",temperature);
    }
}



#pragma mark 分组内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *UnitsTitleArray = @[@"温度"];
    return [UnitsTitleArray objectAtIndex:section];
}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
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
