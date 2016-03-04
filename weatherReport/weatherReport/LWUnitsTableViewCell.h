//
//  LWUnitsTableViewCell.h
//  weatherReport
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWUnitsTableViewCell : UITableViewCell
//@property (nonatomic, strong) UILabel *LWUnitsLable;
@property (nonatomic, strong) UISegmentedControl *LWUnitSegment;
// 根据给定的不同标示符显示的不同
@property (nonatomic, assign) NSInteger identifider;
@end
