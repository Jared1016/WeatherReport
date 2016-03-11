//
//  LWTimeChooseTableViewCell.m
//  weatherReport
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "LWTimeChooseTableViewCell.h"
#import "LWTimeAndAddressViewController.h"


@interface LWTimeChooseTableViewCell ()



@end

@implementation LWTimeChooseTableViewCell
//
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self SetUpView];
//    }
//    return self;
//}
//
//-(void)SetUpView{
//    
//}


- (IBAction)DatePicker:(id)sender {
    //获取用户通过UIDatePicker设置的日期和时间
    NSDate *selected = [self.DatePicker date];
    
    //创建一个日期格式器
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //为日期格式器设置格式字符串
    [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    //使用日期格式器格式化日期、时间
    NSString *destDateString = [dateFormatter stringFromDate:selected];
    
    NSString *message =  [NSString stringWithFormat:@"%@",destDateString];
    
    NSLog(@"%@",message);
    
    self.block(message);
//    LWTimeAndAddressViewController *LWVC = [LWTimeAndAddressViewController new];
//    LWVC.date = message;
//    NSLog(@"LWVC.date======%@",LWVC.date);
//    [LWVC.LWTDVCTableView reloadData];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
