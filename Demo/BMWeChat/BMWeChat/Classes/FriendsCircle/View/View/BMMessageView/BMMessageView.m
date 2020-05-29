//
//  BMMessageView.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMMessageView.h"
#import "NSDate+BMKit.h"

@interface BMMessageView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *label; ///< label
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation BMMessageView

- (void)awakeFromNib {
    [super awakeFromNib];
    _iconImageView.layer.cornerRadius  = 20;
    _iconImageView.layer.masksToBounds = YES;
}

- (void)setModel:(BMModel *)model {
    _model = model;
    _label.text     = model.content;
    _nameLabel.text = model.posterInfo.nickName;
    _timeLabel.text = model.timeStr;
}

@end
