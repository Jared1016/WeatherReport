//
//  Jared_EditView.m
//  weatherReport
//
//  Created by Jared on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "Jared_EditView.h"

@implementation Jared_EditView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
        
    }
    return self;
}

- (void)setupView{
    
    
    self.editTable = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:(UITableViewStylePlain)];
//    self.editTable.backgroundColor = [UIColor purpleColor];
    
    [self addSubview:self.editTable];
    
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
