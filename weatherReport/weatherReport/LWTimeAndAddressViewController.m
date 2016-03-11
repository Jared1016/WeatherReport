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
#import "JPUSHService.h"
#import "WeatherManager.h"
@interface LWTimeAndAddressViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, copy) NSMutableString *TimeString;
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, assign)int notificationtag;
@end

@implementation LWTimeAndAddressViewController{
    UILocalNotification *_notification;
}


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
    
    [self.LWTDVCTableView registerNib:[UINib nibWithNibName:@"LWTimeChooseTableViewCell" bundle:nil] forCellReuseIdentifier:indentifiderRow];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"i11"] style:UIBarButtonItemStyleDone target:self action:@selector(returnButtonDid)];
    [self.navigationItem setLeftBarButtonItem:barItem];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.1436 green:0.1393 blue:0.1276 alpha:1.0];
    
    // Do any additional setup after loading the view.
}


-(void)returnButtonDid{
    [self.navigationController popViewControllerAnimated:YES];
    self.block(_date);
    
    NSArray *array = [WeatherManager shareInstance].arrayDay[1];
    //温度
    
    NSLog(@" array  %@",array[1]);
    
    NSString *String = [NSString stringWithFormat:@"明天 %@ ,最低气温 %@ ℃ ， 最高气温 %@ ℃",array[1],array[0],array[2]];
    
    [self addLocalNotificationAlertBody:String  dateString:_date];
}

- (void)addLocalNotificationAlertBody:(NSString *)alertBody dateString:(NSString *)dateStr {
    //    判断系统
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //        创建settings
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        //        应用程序注册通知，并且设定通知的形式
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        //        创建本地通知
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        //        弹框内容
        localNotification.alertBody = alertBody;
        //        弹框标题
        localNotification.alertTitle = @"天气！";
        localNotification.alertAction = @"知道了";
        
        
        localNotification.repeatInterval = kCFCalendarUnitDay;
        
        
        //        弹框声音
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        //        设置通知时间
        NSString *dateString = dateStr;
        NSDateFormatter *strDateFor = [[NSDateFormatter alloc] init];
        [strDateFor setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        NSDate *date = [strDateFor dateFromString:dateString];
        NSLog(@"------%@-----",dateString);
        localNotification.fireDate = date;
        //        设置时区
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        
        NSDictionary *dict =[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:self.notificationtag],@"nfkey",nil];
        [localNotification setUserInfo:dict];
        
        //        设置
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        
        NSString *result;
        if (localNotification) {
            result = @"设置本地通知成功";
        } else {
            result = @"设置本地通知失败";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"设置"
                                                        message:result
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        
    } else {
        NSLog(@"版本低于8.0");
    }
    
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
        return 1;
    }
}
-(NSString *)date{
    if (!_date) {
        _date = [[NSString alloc]init];
    }
    return _date;
}
 static NSString *indentifiderRow = @"RowwCell";
#pragma mark 返回内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   

    
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
            cell.textLabel.textColor = [UIColor whiteColor];
            if (_date == nil) {
                
                cell.detailTextLabel.text = @"";
                cell.detailTextLabel.textColor = [UIColor whiteColor];
            }else{
                cell.detailTextLabel.text = _date;
                cell.detailTextLabel.textColor = [UIColor whiteColor];
            }
            
            cell.detailTextLabel.textColor = [UIColor colorWithRed:0.1827 green:0.4011 blue:1.0 alpha:1.0];
        }
        else {
            
            NSArray *array = @[@"目前位置"];
            cell.textLabel.text = array[indexPath.row];
            cell.textLabel.textColor = [UIColor whiteColor];
            
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        return cell;
    }else{
        LWTimeChooseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifiderRow forIndexPath:indexPath];
        cell.block = ^(NSString *date){
            self.date = date;
            [self.LWTDVCTableView reloadData];
        };
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
    // Dispose of any resources that0 can be recreated.
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
