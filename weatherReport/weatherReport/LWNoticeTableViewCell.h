//
//  LWNoticeTableViewCell.h
//  weatherReport
//
//  Created by lanou3g on 16/3/2.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeModel.h"
@interface LWNoticeTableViewCell : UITableViewCell
@property (retain,strong,nonatomic) TreeModel *node;
@property (nonatomic, strong) UILabel *LWNoticeLable;
@property (nonatomic, strong) UISwitch *LWNoticeSwitch;
@property (nonatomic, strong) NSArray *localArray;
@end
