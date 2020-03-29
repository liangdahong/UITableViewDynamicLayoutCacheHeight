//
//  BMCell.m
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/17.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMCell.h"

@interface BMCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCons;

@end

@implementation BMCell

- (void)setModel:(BMModel *)model {
    _model = model;
    _titleLabel.text = _model.name;
    _iconImageView.image = [UIImage imageNamed:_model.icon];
    _descLabel.text = _model.desc;
    _userLabel.text = @"Jack";
    _timeLabel.text = @"2018年02月12日";
    _widthCons.constant = model.size.width;
    _heightCons.constant = model.size.height;
}

@end
