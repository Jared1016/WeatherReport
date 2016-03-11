//
//  LWUnitsTableViewCell.m
//  weatherReport
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "LWUnitsTableViewCell.h"
#import "WeatherManager.h"
@implementation LWUnitsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self SetUpView];
    }
    return self;
}

-(void)SetUpView{
        NSArray *Array = @[@"℃",@"℉"];
        _LWUnitSegment = [[UISegmentedControl alloc] initWithItems:Array];
        _LWUnitSegment.frame = CGRectMake(20, 10, 150, 30);
        [self.contentView addSubview:_LWUnitSegment];
        
    if ([WeatherManager shareInstance].activeCentigrade == YES) {
        _LWUnitSegment.selectedSegmentIndex = 1;
    }
    if ([WeatherManager shareInstance].activeCentigrade == NO) {
        _LWUnitSegment.selectedSegmentIndex = 0;
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
