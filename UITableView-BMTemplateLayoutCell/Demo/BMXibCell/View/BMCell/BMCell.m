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


@end

@implementation BMCell

- (void)draw {
    _titleLabel.text = [NSString stringWithFormat:@"%@ - %@", _model.name, _model.ID];
    _iconImageView.image = [UIImage imageNamed:_model.icon];
    _descLabel.text = _model.desc;
    _userLabel.text = @"idhong";
    _timeLabel.text = @"2018年02月12日09:48";
}

- (void)clear {
    _titleLabel.text = @"";
    _descLabel.text  = @"";
    _userLabel.text  = @"";
    _timeLabel.text  = @"";
    _iconImageView.image = nil;
}

@end
