//
//  LWSetUpTableViewCell.m
//  weatherReport
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "LWSetUpTableViewCell.h"

@implementation LWSetUpTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self SetUpView];
    }
    return self;
}

-(void)SetUpView{
    // lable
    _LWEnumNameLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 150, 40)];
    [self.contentView addSubview:_LWEnumNameLable];
    _LWEnumNameLable.textColor = [UIColor whiteColor];
    // switch
    _LWEnumSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 70, 10, 150, 40)];
    [self .contentView addSubview:_LWEnumSwitch];
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
