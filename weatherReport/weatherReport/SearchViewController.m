//
//  SearchViewController.m
//  weatherReport
//
//  Created by lanou3g on 16/3/7.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "SearchViewController.h"
#import "MainViewController.h"

@interface SearchViewController ()<UISearchBarDelegate>

@property (nonatomic,strong) UISearchDisplayController *searchDC;
@property (nonatomic, strong) UITableView *myTableView;

/**
 *  是否是search状态
 */
@property(nonatomic, assign) BOOL isSearch;
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
    

    self.sv.tableView.delegate = self;
    self.sv.tableView.dataSource = self;
    
    self.isSearch = NO;
    
    //tableview不滑动
    //    self.sv.tableView.scrollEnabled =NO;
    //navigation不消失
    self.searchCT.hidesNavigationBarDuringPresentation = NO;
    //加载数据
    [self loadData];
    //搜索设置
    [self searchAction];
    
    // Do any additional setup after loading the view.
}

- (void)loadData{
    //绑定一个本地的name.txt文件路径
    NSString *path = [[NSBundle mainBundle]pathForResource:@"cityName" ofType:@"txt"];
    //将文件中的内容读取出来
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //    NSLog(@"%@", str);
    _arrayData = [str componentsSeparatedByString:@"\n"];
    
}
//返回方法
- (void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)searchAction{
    //创建一个UISearchBar
    UISearchBar *searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)];
    searchbar.translucent  = YES;
//    searchbar.delegate     = self;
    searchbar.placeholder  = @"城市名称或首字母";
    searchbar.keyboardType = UIKeyboardTypeDefault;
    [searchbar setBarTintColor:[UIColor colorWithWhite:0.95 alpha:1.0]];
    [searchbar.layer setBorderWidth:0.5f];
    [searchbar.layer setBorderColor:[UIColor colorWithWhite:0.7 alpha:1.0].CGColor];
    searchbar.delegate = self;
    //添加到self.view上
    [self.view addSubview:searchbar];
    //然后再赋给tableview.tableHeaderView(若没有添加在view上则不能进行操作)
    self.sv.tableView.tableHeaderView = searchbar;

    //定义一个UISearchDisplayController,并让他对searchbar和展示搜索结果的Controller进行关联
    _searchDC = [[UISearchDisplayController alloc] initWithSearchBar:searchbar contentsController:self];

    //给UISearchDisplayController自带的tableview进行遵循代理
    _searchDC.searchResultsDelegate = self;
    _searchDC.searchResultsDataSource = self;

}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    //对调用此代理的tableView进行判断并分别返回他们的count
    if (tableView == self.self.sv.tableView) {
        NSLog(@"choose.count = %lu",(unsigned long)self.arrayChoose.count);
        return self.arrayChoose.count;
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
        cell.textLabel.text = self.arrayChoose[indexPath.row];
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (self.isSearch) {
        NSLog(@"选的是=========%@",_arrayresult[indexPath.row]);
        [self dismissViewControllerAnimated:YES completion:nil];
        [_delegate addDateCityName:_arrayresult[indexPath.row]];
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
