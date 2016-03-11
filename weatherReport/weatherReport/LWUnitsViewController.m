//
//  LWUnitsViewController.m
//  weatherReport
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 刘斌. All rights reserved.
//

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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 初始化TableView
    self.LWUnitsTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
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
        EnumCell = Cell;
    }else if (indexPath.section == 1){
        LWUnitsLongTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_one"];
        if (cell == nil) {
            cell = [[LWUnitsLongTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell_one"];
        }
        EnumCell = cell;
    }
    
    return EnumCell;
}

#pragma mark 分组内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *UnitsTitleArray = @[@"温度",@"风速"];
    return [UnitsTitleArray objectAtIndex:section];
}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
