//
//  LWNoticeTableViewCell.m
//  weatherReport
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "LWNoticeTableViewCell.h"
#import "WeatherManager.h"
@implementation LWNoticeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self SetUpView];
    }
    return self;
}

-(void)SetUpView{
    
    // Lable
    _LWNoticeLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 30)];
    _LWNoticeLable.text = @"每日通知";
    [self.contentView addSubview:_LWNoticeLable];
    _LWNoticeLable.textColor = [UIColor whiteColor];
    
    
    // Switch
    _LWNoticeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 70, 10, 150, 40)];
    
//    // 获得 UIApplication
//    
//    UIApplication *app = [UIApplication sharedApplication];
//    
//    //获取本地推送数组
//    
//    _localArray = [app scheduledLocalNotifications];
//    
//    NSLog(@" localArray =  %@",_localArray);
    
    if ([WeatherManager shareInstance].active  == NO) {
//        [WeatherManager shareInstance].active  = NO;
        _LWNoticeSwitch.on = NO;
    }else{
//        [WeatherManager shareInstance].active  = YES;
        _LWNoticeSwitch.on = YES;
    }
    
    
//    _LWNoticeSwitch.on = YES;
    [self.contentView addSubview:_LWNoticeSwitch];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
