
//
//  BMHeaderView.m
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/15.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMHeaderView.h"
#import "Masonry.h"

@implementation BMHeaderView

- (UILabel *)descLabel {
    if (!_descLabel) {
        _descLabel = [UILabel new];
        _descLabel.numberOfLines = 0;
        _descLabel.backgroundColor = [UIColor orangeColor];
    }
    return _descLabel;
}

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.descLabel];
        [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
        }];

        UIView *linView = [UIView new];
        [self.contentView addSubview:linView];
        [linView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.descLabel.mas_bottom);
            make.left.right.mas_equalTo(-10);
            make.height.mas_equalTo(0);
        }];
    }
    return self;
}
@end
