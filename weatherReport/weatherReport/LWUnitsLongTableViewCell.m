//
//  LWUnitsLongTableViewCell.m
//  weatherReport
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "LWUnitsLongTableViewCell.h"

@implementation LWUnitsLongTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self SetUpView];
    }
    return self;
}

-(void)SetUpView{
    
        NSArray *SecondArray = @[@"英里/小时",@"公里/小时",@"米/秒",@"节"];
        _LWUnitSegmentLong = [[UISegmentedControl alloc] initWithItems:SecondArray];
        _LWUnitSegmentLong.frame = CGRectMake(20, 10, 300, 30);
        
        [self.contentView addSubview:_LWUnitSegmentLong];
    
    _LWUnitSegmentLong.selectedSegmentIndex = 2;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
