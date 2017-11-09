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

- (void)draw {
    self.titleLabel.text = [NSString stringWithFormat:@"%@ - %@", _model.name, _model.ID];
    self.iconImageView.image = [UIImage imageNamed:_model.icon];
    self.descLabel.text = _model.desc;
}

- (void)clear {
    self.titleLabel.text = @"";
    self.descLabel.text = @"";
}
@end
