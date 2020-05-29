//
//  BMFriendPraiseListLabel.m
//  TTTAttributedLabelDemo
//
//  Created by ___liangdahong on 2017/5/19.
//  Copyright © 2017年 https://github.com/asiosldh/TTTAttributedLabelDemo All rights reserved
//

#import "BMFriendPraiseListLabel.h"
#import "TTTAttributedLabel.h"
#import "Masonry.h"

@interface BMFriendPraiseListLabel () <TTTAttributedLabelDelegate>

@property (strong, nonatomic) TTTAttributedLabel *attributedLabel; ///< TTTAttributedLabel
@property (strong, nonatomic) NSArray <NSString *> *friendArray; ///< 数据源

@end


@implementation BMFriendPraiseListLabel

@dynamic text;
@dynamic attributedText;

#pragma mark -

#pragma mark - init

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

#pragma mark - getters setters

- (TTTAttributedLabel *)attributedLabel {
    if (!_attributedLabel) {
        _attributedLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _attributedLabel.delegate = self;
        _attributedLabel.numberOfLines = 0;
    }
    return _attributedLabel;
}

#pragma mark - 系统delegate

#pragma mark - 自定义delegate

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    if (self.friendPraiseClickBlock) {
        self.friendPraiseClickBlock([components[@"_friendPraiseListLabel"] unsignedIntegerValue]);
    }
}

#pragma mark - 公有方法

- (void)setFriendArray:(NSArray<NSString *> *)friendArray segmentationString:(NSString *)segmentationString {
    if (!friendArray.count) {
        self.attributedLabel.text = nil;
        return;
    }

    NSMutableString *string = [@"" mutableCopy];
    [friendArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [string appendString:obj];
        [string appendString:segmentationString];
    }];

    if (string.length) {
        [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    }

    NSMutableAttributedString *atributeStr = [[NSMutableAttributedString alloc] initWithString:string attributes:self.attributes];
    self.attributedLabel.text = atributeStr;
    self.attributedLabel.linkAttributes = self.normalAttributes ? self.normalAttributes : @{NSForegroundColorAttributeName : [UIColor blueColor], NSFontAttributeName : [UIFont systemFontOfSize:15.0f]};
    self.attributedLabel.activeLinkAttributes = self.highlightedAttributes ? self.highlightedAttributes : @{NSBackgroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:15.0f]};
    
    __block NSUInteger rangeSearch = 0;
    [friendArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSRange serviceRange = [string rangeOfString:obj options:NSLiteralSearch range:NSMakeRange(rangeSearch, string.length - rangeSearch)];
        if (serviceRange.location != NSNotFound) {
            rangeSearch = serviceRange.location + serviceRange.length + 1;
            NSDictionary *dict = [@{@"_friendPraiseListLabel" : @(idx)} copy];
            [self.attributedLabel addLinkToTransitInformation:dict withRange:serviceRange];
        }
    }];
}

#pragma mark - 私有方法

- (void)initUI {
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor clearColor];
    self.textColor = [UIColor clearColor];
    [self addSubview:self.attributedLabel];
    [self.attributedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

#pragma mark - 事件响应

@end
