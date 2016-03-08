//
//  LWTimeChooseTableViewCell.h
//  weatherReport
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickAction)(NSString *date);
@interface LWTimeChooseTableViewCell : UITableViewCell



@property (nonatomic, copy) NSMutableString *String;

@property (weak, nonatomic) IBOutlet UIDatePicker *DatePicker;

@property (strong,nonatomic) clickAction block;

@end
