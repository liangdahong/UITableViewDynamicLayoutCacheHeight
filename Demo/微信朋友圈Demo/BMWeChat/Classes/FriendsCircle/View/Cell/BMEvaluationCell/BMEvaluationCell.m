//
//  BMEvaluationCell.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMEvaluationCell.h"

@interface BMEvaluationCell ()

@property (weak, nonatomic) IBOutlet UILabel *coLabel;

@end

@implementation BMEvaluationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)draw {
    _coLabel.attributedText = _model.contentAtt;
}

- (void)clear {
    _coLabel.text = nil;
}

@end
