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
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation BMCell

- (void)draw {
    _titleLabel.text = [NSString stringWithFormat:@"%@ - %@", _model.name, _model.ID];
    _iconImageView.image = [UIImage imageNamed:_model.icon];
    _descLabel.text = _model.desc;
    _timeLabel.text  = @"2017年11月28日11:41:03";
}

- (void)clear {
    _titleLabel.text = @"";
    _descLabel.text  = @"";
    _timeLabel.text  = @"";
}
@end
