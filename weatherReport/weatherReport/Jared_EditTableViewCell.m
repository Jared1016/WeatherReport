//
//  Jared_EditTableViewCell.m
//  weatherReport
//
//  Created by Jared on 16/2/29.
//  Copyright © 2016年 刘斌. All rights reserved.
//

#import "Jared_EditTableViewCell.h"

@implementation Jared_EditTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell{
    self.placeImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    self.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.placeImgView];
    
    self.placeLable = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 100, 50)];
    [self.contentView addSubview:self.placeLable];
}


// Model和cell通信
- (void)setJEditModel:(Jared_EditModel *)JEditModel{
    _JEditModel = JEditModel;
    self.placeImgView.image = JEditModel.placeImage;
    self.placeLable.text = JEditModel.placeName;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
