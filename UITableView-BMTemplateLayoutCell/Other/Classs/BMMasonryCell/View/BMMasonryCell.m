//
//  BMMasonryCell.m
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/8/24.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMMasonryCell.h"
#import "Masonry.h"

@interface BMMasonryCell ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *descLabel;

@end

@implementation BMMasonryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {

    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];

    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(10);
        make.right.mas_lessThanOrEqualTo(-10);
    }];

    [self.contentView addSubview:self.descLabel];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-30);
    }];

    // 由此view确定cell需要的高度
    UIView *tempView = [UIView new];
    [self.contentView addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.descLabel.mas_bottom). mas_offset(10);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(0);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.numberOfLines = 0;
    }
    return _descLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

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
