//
//  Jared_EditViewController.m
//  weatherReport
//
//  Created by Jared on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "Jared_EditViewController.h"
#import "Jared_EditTableViewCell.h"
#import "Jared_EditModel.h"
#import "JaredChooseCityController.h"
#import "JaredChooseCityController.h"

@interface Jared_EditViewController ()<UITableViewDataSource,UITableViewDelegate,JaredChooseCityDelegate>
@property(nonatomic,strong)UIBarButtonItem *right;
@property(nonatomic,strong)UIButton *chooseCityBtn;
@property(nonatomic,strong)UIBarButtonItem *left;

@property (nonatomic, assign)UITableViewCellEditingStyle editStyle;
@end

@implementation Jared_EditViewController

- (void)loadView{
    [super loadView];
    self.ev = [[Jared_EditView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.ev;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ev.editTable.delegate = self;
    self.ev.editTable.dataSource = self;
    
    
    self.editStyle = UITableViewCellEditingStyleDelete;
    
    self.navigationItem.title = @"地点";
    
    _right = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightAction)];
    
    _left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit-add.png"] style:(UIBarButtonItemStyleDone) target:self action:@selector(leftAction)];
    
    self.navigationItem.leftBarButtonItem = _left;
    
    self.navigationItem.rightBarButtonItem = _right;
    
    
    // 在搜索框返回的数据
    _chooseCityBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    _chooseCityBtn.center = self.view.center;
    [_chooseCityBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [_chooseCityBtn setTitle:@"选择城市" forState:UIControlStateNormal];
    [_chooseCityBtn addTarget:self action:@selector(onClickChooseCity:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_chooseCityBtn];
    // Do any additional setup after loading the view from its nib.
    // 提取数据
    [self loadData];
}

- (void)rightAction{
    
    
    
}

- (void)leftAction{
 
//    JaredChooseCityController *svc = [[JaredChooseCityController alloc] init];
//    [self.navigationController pushViewController:svc animated:YES];
    
    JaredChooseCityController *cityPickerVC = [[JaredChooseCityController alloc] init];
    
    [cityPickerVC setDelegate:self];
    //    cityPickerVC.delegate = self;
    
    //    cityPickerVC.locationCityID = @"1400010000";
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    //    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
    
    
}

- (NSMutableArray *)placeDataArray{
    
    if (_placeDataArray == nil) {
        _placeDataArray = [[NSMutableArray alloc] init];
    }
    
    return _placeDataArray;
}

//提取数据

- (void)loadData{
    self.placeDataArray = [NSMutableArray array];
    
    Jared_EditModel *placeImageModel = [[Jared_EditModel alloc] init];
    placeImageModel.placeImage = [UIImage imageNamed:@"current-place"];
    placeImageModel.placeName = @"目前位置";
    [self.placeDataArray addObject:placeImageModel];
    
}

- (void)onClickChooseCity:(id)sender {
    
    JaredChooseCityController *cityPickerVC = [[JaredChooseCityController alloc] init];
    
    [cityPickerVC setDelegate:self];
    //    cityPickerVC.delegate = self;
    
    //    cityPickerVC.locationCityID = @"1400010000";
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    //    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.placeDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Jared_EditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[Jared_EditTableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:@"cell"];
    }
    
    Jared_EditModel *model = self.placeDataArray[indexPath.row];
    cell.JEditModel = model;
    
    return cell;
}

// 删除按钮
- (void)deleteAction{
    self.editStyle = UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.ev.editTable setEditing:!self.ev.editTable animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return NO;
    }
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.editStyle;
}


//删除cell 标记可编辑的cell,并删除;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.editStyle == UITableViewCellEditingStyleDelete) {
        [self.placeDataArray removeObjectAtIndex:indexPath.row];
        [self.ev.editTable deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
}


#pragma mark 搜索框

#pragma mark - JaredCityPickerDelegate
- (void) cityPickerController:(JaredChooseCityController *)chooseCityController didSelectCity:(JaredCity *)city
{
    [_chooseCityBtn setTitle:city.cityName forState:UIControlStateNormal];
    
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(JaredChooseCityController *)chooseCityController
{
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

//
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 1) {
//        return NO;
//    }
//    return YES;
//}
//
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//    
//    if (sourceIndexPath == 0 && destinationIndexPath == 0) {
//        NSString *str = self.placeDataArray[sourceIndexPath.row];
//        [self.placeDataArray removeObjectAtIndex:sourceIndexPath.row];
//        
//        [self.placeDataArray insertObject:str atIndex:destinationIndexPath.row];
//    }
//}



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
