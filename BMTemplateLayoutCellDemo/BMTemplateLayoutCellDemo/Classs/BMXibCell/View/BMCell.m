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

@end

@implementation BMCell

- (void)setModel:(BMModel *)model {
    if (_model == model) {
        return;
    }
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@ - %@", model.name, model.ID];
    self.iconImageView.image = [UIImage imageNamed:model.icon];
    self.descLabel.text = model.desc;
}

@end
