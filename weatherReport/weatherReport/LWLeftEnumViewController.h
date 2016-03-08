//
//  LWLeftEnumViewController.h
//  weatherReport
//
//  Created by lanou3g on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWLeftEnumViewController : UIViewController
+ (instancetype) controller;

@property(nonatomic,strong)NSMutableArray *arrayDate;
// 分组一 列表数组
@property (nonatomic, strong) NSMutableArray *Section1EnumLableArray;

@end
