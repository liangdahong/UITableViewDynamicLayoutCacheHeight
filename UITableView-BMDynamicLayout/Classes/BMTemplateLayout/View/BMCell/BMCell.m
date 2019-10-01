//
//  BMCell.m
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/17.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMCell.h"
#define KISVertical UIScreen.mainScreen.bounds.size.height > UIScreen.mainScreen.bounds.size.width

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
    _titleLabel.text = [NSString stringWithFormat:@"%@ - %@", _model.name, _model.ID];
    _iconImageView.image = [UIImage imageNamed:_model.icon];
    _descLabel.text = _model.desc;
    _userLabel.text = @"idhong";
    _timeLabel.text = @"2018年02月12日09:48";

    if (KISVertical) {
        _widthCons.constant = model.vsize.width;
        _heightCons.constant = model.vsize.height;
    } else {
        _widthCons.constant = model.hsize.width;
        _heightCons.constant = model.hsize.height;
    }
}

@end
