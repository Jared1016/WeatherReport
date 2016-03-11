//
//  MainViewController.h
//  weatherReport
//
//  Created by lanou3g on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainView.h"
@interface MainViewController : UIViewController
@property(nonatomic,strong)MainView *mv;
+ (instancetype) controller;

@property (nonatomic,strong)NSString *chooseName;

@end
