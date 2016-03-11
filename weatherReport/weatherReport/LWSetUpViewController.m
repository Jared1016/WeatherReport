//
//  LWSetUpViewController.m
//  weatherReport
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "LWSetUpViewController.h"
#import "LWSetUpTableViewCell.h"
#import "MainViewController.h"
#import "LWUnitsViewController.h"
#import "LWNoticeViewController.h"
#import "ITRAirSideMenu.h"
#import "AppDelegate.h"
@interface LWSetUpViewController ()<UITableViewDataSource,UITableViewDelegate,ITRAirSideMenuDelegate>
@property (nonatomic, strong) UITableView *SetUpEnumTableView;
@end

@implementation LWSetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    // 初始化tableView
    self.SetUpEnumTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    // tableView代理
    self.SetUpEnumTableView.dataSource = self;
    self.SetUpEnumTableView.delegate = self;
    // 注册cell
//    [self.SetUpEnumTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setup"];
    
    self.SetUpEnumTableView.backgroundColor = [UIColor clearColor];
    
    // view 背景颜色
    self.view.backgroundColor = [UIColor colorWithRed:0.1436 green:0.1393 blue:0.1276 alpha:1.0];
    
    
    // 导航栏右侧完成按钮
    UIBarButtonItem *RightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(RightButtonAction)];
    
    self.navigationItem.rightBarButtonItem = RightButton;
    
    // 添加视图
    [self.view addSubview:self.SetUpEnumTableView];
    // Do any additional setup after loading the view.
    // 导航栏颜色
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    UIColor * cc = [UIColor whiteColor];
    NSDictionary * dict = [NSDictionary dictionaryWithObject:cc forKey: NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

#pragma mark - 导航栏右侧完成按钮点击事件；
-(void)RightButtonAction{
//    MainViewController *mainVC = [MainViewController new];
    /**
     *  暂时这么跳转
     */
    [self dismissViewControllerAnimated:YES completion:nil];
    ITRAirSideMenu *itrSideMenu = ((AppDelegate *)[UIApplication sharedApplication].delegate).itrAirSideMenu;
    //update content view controller with setContentViewController
    [itrSideMenu hideMenuViewController];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate代理

#pragma mark 返回行数
-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

#pragma mark cell内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.backgroundColor = [UIColor clearColor];
    UITableViewCell *EnumCell = nil;
    
    // 根据indexPath.row 使用不同的cell
    if (indexPath.row < 2) {
        EnumCell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (EnumCell == nil) {
            EnumCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cells"];
        }
        NSArray *FirstArray = @[@"单位",@"每日通知"];
        EnumCell.textLabel.text = FirstArray[indexPath.row];
        EnumCell.textLabel.textColor = [UIColor whiteColor];
        EnumCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell = EnumCell;
    }else if (indexPath.row == 2){
        EnumCell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (EnumCell == nil) {
            EnumCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cells"];
        }
        EnumCell.textLabel.text = @"版本";
        EnumCell.textLabel.textColor = [UIColor whiteColor];
        EnumCell.detailTextLabel.text = @"1.0(00001)";
        EnumCell.detailTextLabel.textColor = [UIColor whiteColor];
        
    }
    EnumCell.backgroundColor = [UIColor clearColor];
    EnumCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return EnumCell;
}

#pragma mark - cell 点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        LWUnitsViewController *LWUnitsVC  = [LWUnitsViewController new];
        [self.navigationController pushViewController:LWUnitsVC animated:YES];
    }else if (indexPath.row == 1){
        LWNoticeViewController *LWNoticeVC = [LWNoticeViewController new];
        [self.navigationController pushViewController:LWNoticeVC animated:YES];
    }
    
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
