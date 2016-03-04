//
//  Jared_EditTableViewCell.h
//  weatherReport
//
//  Created by Jared on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jared_EditModel.h"
@interface Jared_EditTableViewCell : UITableViewCell
@property(nonatomic, strong)UIImageView *placeImgView;
@property(nonatomic, strong)UILabel *placeLable;

@property(nonatomic, strong)Jared_EditModel *JEditModel;
@end
