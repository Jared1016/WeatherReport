//
//  LWLeftEnumViewController.m
//  weatherReport
//
//  Created by lanou3g on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "LWLeftEnumViewController.h"
#import "ITRAirSideMenu.h"
#import "LWLeftEnumTableViewCell.h"
#import "LWSetUpViewController.h"

#import "SearchViewController.h"

@interface LWLeftEnumViewController ()<UITableViewDataSource,UITableViewDelegate,delegateDate>

// tableView
@property (weak, nonatomic) IBOutlet UITableView *LWTableView;

@end

@implementation LWLeftEnumViewController

+ (instancetype)controller {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    return [storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([LWLeftEnumViewController class])];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _Section1EnumLableArray = [NSMutableArray arrayWithObjects:@"分享",@"编辑地点",@"目前位置", nil ];
    
    
    
    //不滑动
//    self.LWTableView.scrollEnabled = NO;
    
}

- (void)addDateCityName:(NSString *)cityName{
    
//    [_Section1EnumLableArray addObject:cityName];
    [_arrayDate addObject:cityName];
    NSLog(@"一共有多少城市%@", _arrayDate);
    [self.LWTableView reloadData];
}



//懒加载
- (NSMutableArray *)arrayDate{
    if (!_arrayDate) {
        _arrayDate = [NSMutableArray arrayWithObjects:@"已添加地点" ,nil];
    }
    return _arrayDate;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate 代理方法

#pragma mark 返回行数 （根据分组的不同返回行数）
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _Section1EnumLableArray.count + _arrayDate.count ;
    }else{
        return 2;
    }
}

#pragma mark 返回内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LWLeftEnumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LWCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if (indexPath.section == 0) {
        if (indexPath.row <= 2) {
            cell.LwLeftEnumCellLable.text = _Section1EnumLableArray[indexPath.row];
        }else {
            cell.LwLeftEnumCellLable.text = _arrayDate[indexPath.row - 3];
        }
        NSArray *Section1EnumImageArray = @[@"enum1.png",@"enum3.png"];
        if (indexPath.row < 2) {
            cell.LwLeftEnumCellImageView.image = [UIImage imageNamed:Section1EnumImageArray[indexPath.row]];
        }else{
            cell.LwLeftEnumCellImageView.image = [UIImage imageNamed:@"enum2"];
        }
    }else{
        NSArray *Section2EnumLableArray = @[@"设置",@"意见与建议"];
        NSArray *Section2EnumImageArray = @[@"enum4",@"enum5"];
        cell.LwLeftEnumCellLable.text= Section2EnumLableArray[indexPath.row];
        cell.LwLeftEnumCellImageView.image = [UIImage imageNamed:Section2EnumImageArray[indexPath.row]];
    }
    return cell;
}

#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark 分组内容
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSArray *EnumTitleArray = @[@"",@"工具"];
    return [EnumTitleArray objectAtIndex:section];
}


#pragma mark cell 点击事件 (根据点击的indexPath.row 跳转不同的控制器)
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 地点界面跳转
    if (indexPath.section == 0 && indexPath.row == 1) {

        SearchViewController *svc = [SearchViewController new];
        svc.delegate = self;
        svc.arrayChoose = self.arrayDate;

        UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:svc];
        [self presentViewController:navigation animated:YES completion:nil];
    }
    // 设置界面跳转
    if (indexPath.section == 1 && indexPath.row == 0) {
        LWSetUpViewController *LWSetUpVC = [LWSetUpViewController new];
        UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:LWSetUpVC];
        [self presentViewController:navigation animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
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
