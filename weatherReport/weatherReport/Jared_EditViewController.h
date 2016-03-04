//
//  Jared_EditViewController.h
//  weatherReport
//
//  Created by Jared on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jared_EditView.h"
@interface Jared_EditViewController : UIViewController
@property (nonatomic, strong)Jared_EditView *ev;

// 可变数组,用来存放数据
@property(nonatomic, strong)NSMutableArray *placeDataArray;
@end
