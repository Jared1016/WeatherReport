//
//  LWTimeAndAddressViewController.h
//  weatherReport
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^clickAction)(NSString *date);
@interface LWTimeAndAddressViewController : UIViewController
@property (nonatomic, strong) UITableView *LWTDVCTableView;
@property (nonatomic,strong)NSString *date;
@property (strong,nonatomic) clickAction block;
@end
