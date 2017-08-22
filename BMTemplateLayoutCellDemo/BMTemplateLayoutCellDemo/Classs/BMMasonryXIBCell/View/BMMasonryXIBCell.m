//
//  BMMasonryXIBCell.m
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/23.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMMasonryXIBCell.h"

@implementation BMMasonryXIBCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (UILabel *)descLabel {
    if (!_descLabel) {
    }
    return _descLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

@end
