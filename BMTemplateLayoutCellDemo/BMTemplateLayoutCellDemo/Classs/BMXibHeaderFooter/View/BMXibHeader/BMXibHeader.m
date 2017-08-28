//
//  BMXibHeader.m
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/8/25.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMXibHeader.h"
#import "Masonry.h"
#import "BMMasonryView.h"

@interface BMXibHeader ()

@property (strong, nonatomic) BMMasonryView *masonryView; ///< <#Description#>
@end


@implementation BMXibHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        // xib 创建view 添加到 contentView 上
        self.masonryView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BMMasonryView.class) owner:nil options:nil] firstObject];
        [self.contentView addSubview:self.masonryView];
        [self.masonryView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
        }];

        // 设置辅助view
        UIView *linView = [UIView new];
        [self.contentView addSubview:linView];
        [linView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.masonryView.mas_bottom);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(0);
        }];
    }
    return self;
}

- (void)setModel:(BMModel *)model {
    if (_model == model) {
        return;
    }
    _model = model;
    self.masonryView.nameLabel.text = [NSString stringWithFormat:@"%@ - %@", model.name, model.ID];
    self.masonryView.iconImageView.image = [UIImage imageNamed:model.icon];
    self.masonryView.descLabel.text = model.desc;
}


@end
