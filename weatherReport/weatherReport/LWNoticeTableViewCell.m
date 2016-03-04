//
//  LWNoticeTableViewCell.m
//  weatherReport
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "LWNoticeTableViewCell.h"

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
    
    // Switch
    _LWNoticeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 70, 10, 150, 40)];
    _LWNoticeSwitch.on = YES;
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
