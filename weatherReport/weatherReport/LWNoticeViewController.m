//
//  LWNoticeViewController.m
//  weatherReport
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "LWNoticeViewController.h"
#import "LWNoticeTableViewCell.h"
#import "TreeModel.h"
#import "RowCell.h"
#import "LWNoticeRowTableViewCell.h"
#import "LWTimeAndAddressViewController.h"
@interface LWNoticeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *LWNoticeTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSIndexPath* IndexPathAll;
@end

@implementation LWNoticeViewController

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"每日通知";
    self.view.backgroundColor = [UIColor whiteColor];
    // 初始化TableView
    _LWNoticeTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    // 设置代理
    _LWNoticeTableView.dataSource = self;
    _LWNoticeTableView.delegate = self;
    // 设置背景颜色为透明
    _LWNoticeTableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:_LWNoticeTableView];
    
    // 添加数据
    [self addTestData];
    _IndexPathAll = [NSIndexPath new];
    
    // Do any additional setup after loading the view.
}

#pragma mark - 添加数据
-(void)addTestData{
    // 第一层
    
    TreeModel *node = [TreeModel new];
    node.type = NodeTypeSectionHead;
    node.sonNodes = nil;
    node.isExpanded = YES; // 关闭状态
    
    
    // 第二层
    TreeModel *node2 = [TreeModel new];
    node2.type = NodeTypeRow;
    node2.sonNodes = nil;
    node2.isExpanded = FALSE;
    RowCell *tmp1 = [RowCell new];
    tmp1.interval = @"时间和地点";
    tmp1.setUpTime = @"12:45 上午, 2 位置";
    node2.nodeData = tmp1;



    node.sonNodes = [NSMutableArray arrayWithObjects:node2, nil];
    _dataArray = [NSMutableArray arrayWithObjects:node, nil];
    
}

#pragma mark - UITableViewDataSource,UITableViewDelegate 代理方法

#pragma mark 返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    TreeModel *node = _dataArray[section];
    if (node.isExpanded) {
        return node.sonNodes.count + 1;
    }
    
    return 1;
}

#pragma mark 分组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

#pragma mark 返回内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _IndexPathAll = indexPath;
    
    static NSString *indentifiderHead = @"HeadCell";
    static NSString *indentifiderRow = @"RowwCell";
    
    TreeModel *node;
    if (indexPath.row == NodeTypeSectionHead) {
        node = _dataArray[indexPath.row];
    }else{
        TreeModel *nodeSction = _dataArray[indexPath.section];
        node = nodeSction.sonNodes[indexPath.row - 1];
    }
    
    if (node.type == NodeTypeSectionHead) {
        LWNoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifiderHead];
        if (cell == nil) {
            cell = [[LWNoticeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indentifiderHead];
        }

        [cell.LWNoticeSwitch addTarget:self action:@selector(LWNoticeSwitchAction) forControlEvents:UIControlEventAllTouchEvents];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }else{
        LWNoticeRowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifiderRow];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"LWNoticeRowTableViewCell" owner:self options:nil] lastObject];
        }
        cell.node = node;
        RowCell *nodeData = node.nodeData;
        cell.intervalLable.text = nodeData.interval;
        cell.setUpTimeLable.text = nodeData.setUpTime;
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }
    
//    return cell;
}


#pragma mark cell 点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LWTimeAndAddressViewController *LWTDVC = [LWTimeAndAddressViewController new];
    if (indexPath.row > 0) {
        [self.navigationController pushViewController:LWTDVC animated:YES];
    }
}


#pragma mark - cell 上开关的响应事件
-(void)LWNoticeSwitchAction{
        TreeModel *node = _dataArray[_IndexPathAll.section];
        BOOL isExpand = node.isExpanded;
        
        
        for (int i = 0; i<_dataArray.count; i++) {
            TreeModel *nodeI = _dataArray[i];
            nodeI.isExpanded = NO;
        }
        node.isExpanded = !isExpand;
        LWNoticeTableViewCell *cell = (LWNoticeTableViewCell*)[self.LWNoticeTableView cellForRowAtIndexPath:_IndexPathAll];
        if(cell.node.isExpanded){
            
            cell.LWNoticeLable.transform = CGAffineTransformMakeRotation(M_PI_2);
            
        }
        [self.LWNoticeTableView reloadData];
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
