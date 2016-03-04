//
//  LWNoticeRowTableViewCell.h
//  weatherReport
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeModel.h"
@interface LWNoticeRowTableViewCell : UITableViewCell
@property (nonatomic, strong) TreeModel *node;
@property (weak, nonatomic) IBOutlet UILabel *intervalLable;
@property (weak, nonatomic) IBOutlet UILabel *setUpTimeLable;

@end
