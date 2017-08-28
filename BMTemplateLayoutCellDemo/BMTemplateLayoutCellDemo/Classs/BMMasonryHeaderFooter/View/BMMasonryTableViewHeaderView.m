//
//  BMMasonryTableViewHeaderView.m
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/8/25.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMMasonryTableViewHeaderView.h"
#import "Masonry.h"

@interface BMMasonryTableViewHeaderView ()

@property (strong, nonatomic) UILabel *descLabel; ///< descLabel

@end

@implementation BMMasonryTableViewHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];

        UIView *linView = [UIView new];
        [self.contentView addSubview:linView];
        [linView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLabel.mas_bottom).mas_offset(10);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
    }
    return self;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.numberOfLines = 0;
        _descLabel.text = @"_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel_descLabel";
    }
    return _descLabel;
}

@end
