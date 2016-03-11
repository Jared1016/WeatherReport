//
//  SearchViewController.m
//  weatherReport
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "SearchViewController.h"
#import "MainViewController.h"
#import "WeatherManager.h"
@interface SearchViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) UISearchDisplayController *searchDC;
@property (nonatomic, strong) UITableView *myTableView;

/**
 *  是否是search状态
 */
@property(nonatomic, assign) BOOL isSearch;
//记录即将进入的编辑状态
@property (nonatomic, assign)UITableViewCellEditingStyle editstyle;
@property (nonatomic,strong)UISearchBar *searchbar;
@end

@implementation SearchViewController

- (void)loadView{
    [super loadView];
    self.sv = [[SearchView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.sv;
}

- (void)viewDidLoad {
    _arrayData = [NSArray new];
    

    //左上角的返回
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = left;
    //右上角的编辑
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = right;
    
    self.sv.tableView.delegate = self;
    self.sv.tableView.dataSource = self;

    //背景颜色是黑色
//    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
//    self.sv.tableView.
    
    self.isSearch = NO;
    
    //tableview不滑动
    //    self.sv.tableView.scrollEnabled =NO;
    //navigation不消失
    self.searchCT.hidesNavigationBarDuringPresentation = NO;
    //加载数据
    [self loadData];
    //搜索设置
    [self searchAction];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificcationAction) name:@"改变城市" object:@"yanwu"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(notificcationAction2) name:@"添加删除城市" object:@"yanwu"];
    // Do any additional setup after loading the view.
}

- (void)loadData{
    //绑定一个本地的name.txt文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"cityName" ofType:@"txt"];
    //将文件中的内容读取出来
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@", str);
    _arrayData = [str componentsSeparatedByString:@"\n"];
}

//返回方法
- (void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//编辑
- (void)rightAction{
    self.editstyle = UITableViewCellEditingStyleDelete;
    [self.sv.tableView setEditing:!self.sv.tableView.editing animated:YES];
}

//指定哪些可以编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row <= 0) {
        return NO;
    }
    return YES;
}

//指定编辑的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.editstyle;
}

//提交编辑请求
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.editstyle == UITableViewCellEditingStyleDelete) {
        //更新数据源
//        [self.arrayChoose removeObjectAtIndex:indexPath.row];

        [[WeatherManager shareInstance].arrayDate removeObjectAtIndex:indexPath.row];
        [self.sv.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"添加删除城市" object:@"yanwu"];
    }
}


- (void)searchAction{
    //创建一个UISearchBar
    _searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)];
    _searchbar.translucent  = YES;
//    searchbar.delegate     = self;
    
    _searchbar.placeholder  = @"城市名称或首字母";
    _searchbar.keyboardType = UIKeyboardTypeDefault;
    [_searchbar setBarTintColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
    [_searchbar.layer setBorderWidth:0.5f];
    [_searchbar.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    _searchbar.delegate = self;
    //添加到self.view上
    [self.view addSubview:_searchbar];
    //然后再赋给tableview.tableHeaderView(若没有添加在view上则不能进行操作)
    self.sv.tableView.tableHeaderView = _searchbar;

    //定义一个UISearchDisplayController,并让他对searchbar和展示搜索结果的Controller进行关联
    _searchDC = [[UISearchDisplayController alloc] initWithSearchBar:_searchbar contentsController:self];

    //给UISearchDisplayController自带的tableview进行遵循代理
    _searchDC.searchResultsDelegate = self;
    _searchDC.searchResultsDataSource = self;

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    //对调用此代理的tableView进行判断并分别返回他们的count
    if (tableView == self.self.sv.tableView) {
//        NSLog(@"choose.count = %lu",(unsigned long)self.arrayChoose.count);
//        return self.arrayChoose.count;
        return [WeatherManager shareInstance].arrayDate.count;
    }
    //由于这个方法在每次输入信息的时候都会执行,所以在这里初始化一个"谓词"(就是搜索的目标,我自己是这样理解的,可能不准确)
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self contains [cd] %@",_searchDC.searchBar.text];
    //通过上面写的predicate指定搜索的目标放在一个数组里
    self.arrayresult = (NSMutableArray *)[self.arrayData filteredArrayUsingPredicate:predicate];
    //返回搜索目标数组的count
    return _arrayresult.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cell_id = @"cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:3 reuseIdentifier:cell_id];
    }
    
    //同上对调用此代理的tableView进行判断并分别进行赋值
    if (tableView == self.self.sv.tableView) {
//        cell.textLabel.text = self.arrayChoose[indexPath.row];
        cell.textLabel.text = [WeatherManager shareInstance].arrayDate[indexPath.row];
    }else{
        cell.textLabel.text = self.arrayresult[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length == 0) {
        self.isSearch = NO;
    }else{
        self.isSearch = YES;
        }
}

- (void)notificcationAction{
    
}

- (void)notificcationAction2{
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.isSearch) {
        NSLog(@"选的是=========%@",_arrayresult[indexPath.row]);
        [[WeatherManager shareInstance].arrayDate addObject:_arrayresult[indexPath.row]];
        [self.myTableView reloadData];
        if ([WeatherManager shareInstance].arrayDate.count >= 8) {
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:nil];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加城市到达上限" message:@"添加失败" preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
        [WeatherManager shareInstance].chooseCityName = _arrayresult[indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"改变城市" object:@"yanwu"];
//        [_searchbar resignFirstResponder];
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    if (indexPath.row != 0) {
        NSLog(@"选的是=========%@",_arrayresult[indexPath.row]);
        [WeatherManager shareInstance].chooseCityName = [WeatherManager shareInstance].arrayDate[indexPath.row];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"改变城市" object:@"yanwu"];
        [self dismissViewControllerAnimated:YES completion:nil];
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
