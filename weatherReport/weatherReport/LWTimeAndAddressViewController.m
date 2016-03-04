//
//  LWTimeAndAddressViewController.m
//  weatherReport
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "LWTimeAndAddressViewController.h"
#import "TreeModel.h"
#import "LWTimeChooseTableViewCell.h"
@interface LWTimeAndAddressViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *LWTDVCTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSMutableString *TimeString;
@property (nonatomic, strong) NSMutableArray *addressArray;
@end

@implementation LWTimeAndAddressViewController


-(NSMutableArray *)addressArray{
    if (_addressArray == nil) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"时间和日期";
    // 初始化TableView
    _LWTDVCTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    // TableView 代理方法
    self.LWTDVCTableView.dataSource = self;
    self.LWTDVCTableView.delegate = self;
    
    [self.view addSubview:_LWTDVCTableView];
    
    [self addTestData];
    
    [self.LWTDVCTableView reloadData];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 添加数据
-(void)addTestData{
    // 第一层
    
    TreeModel *node = [TreeModel new];
    node.type = NodeTypeSectionHead;
    node.sonNodes = nil;
    node.isExpanded = NO; // 关闭状态
    
    TreeModel *node4 = [TreeModel new];
    node.type = NodeTypeSectionHead;
    node.sonNodes = nil;
    node.isExpanded = NO; // 关闭状态
    
    // 第二层
    TreeModel *node2 = [TreeModel new];
    node2.type = NodeTypeRow;
    node2.sonNodes = nil;
    node2.isExpanded = FALSE;
    
    TreeModel *node3 = [TreeModel new];
    node3.type = NodeTypeRow;
    node3.sonNodes = nil;
    node3.isExpanded = FALSE;
    
    
    node.sonNodes = [NSMutableArray arrayWithObjects:node2,node3, nil];
    _dataArray = [NSMutableArray arrayWithObjects:node,node4, nil];
    
}


#pragma mark - UITableViewDataSource,UITableViewDelegate 代理方法

#pragma mark 返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
    TreeModel *node = _dataArray[section];
    if (node.isExpanded) {
        return node.sonNodes.count;
    }
    return 1;
    }else{
        return 2;
    }
}

#pragma mark 返回内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifiderRow = @"RowwCell";
    
    TreeModel *node;
    if (indexPath.row == NodeTypeSectionHead) {
        node = _dataArray[indexPath.row];
    }else{
        TreeModel *nodeSction = _dataArray[indexPath.section];
        node = nodeSction.sonNodes[indexPath.row - 1];
    }
    
    if (node.type == NodeTypeSectionHead) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cells"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cells"];
        }
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.textLabel.text = @"时间";
            cell.detailTextLabel.text = @"zzzz";
            cell.detailTextLabel.textColor = [UIColor colorWithRed:0.1827 green:0.4011 blue:1.0 alpha:1.0];
        }
        else {
            
            NSArray *array = @[@"目前位置",@"巴黎"];
            cell.textLabel.text = array[indexPath.row];
 
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }else{
        LWTimeChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifiderRow];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LWTimeChooseTableViewCell" owner:self options:nil] lastObject];
        }
        NSLog(@"time is %@",cell.String);
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }
    
    
    
}

#pragma mark 设置高度
-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }
        return 150;
    }else{
        return 40;
    }
    
}


#pragma mark 返回分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

#pragma mark cell 点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    TreeModel *node = _dataArray[indexPath.section];
    BOOL isExpand = node.isExpanded;
    
    
    for (int i = 0; i<_dataArray.count; i++) {
        TreeModel *nodeI = _dataArray[i];
        nodeI.isExpanded = NO;
    }
    node.isExpanded = !isExpand;
   
    [tableView reloadData];
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
