//
//  UITableViewHeaderFooterView+BMReusable.h
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/8/28.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBMTableViewHeaderFooterViewProperty(clas, propertyName) @property (strong, nonatomic) clas *propertyName;

#define kBMTableViewHeaderFooterViewInit(clas, propertyName)\
\
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {\
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {\
        _##propertyName = [[[UINib nibWithNibName:NSStringFromClass(clas.class) bundle:nil] instantiateWithOwner:nil options:nil] firstObject];\
        [self.contentView addSubview:_##propertyName];\
        _##propertyName.translatesAutoresizingMaskIntoConstraints = NO;\
        NSLayoutConstraint *constraintTop    = [NSLayoutConstraint constraintWithItem:_##propertyName attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];\
        NSLayoutConstraint *constraintLeft   = [NSLayoutConstraint constraintWithItem:_##propertyName attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];\
        NSLayoutConstraint *constraintRight  = [NSLayoutConstraint constraintWithItem:_##propertyName attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0];\
        [self.contentView addConstraints:@[constraintTop, constraintLeft, constraintRight]];\
    }\
    return self;\
}\
\

@interface UITableViewHeaderFooterView (BMReusable)

+ (instancetype)bm_tableViewHeaderFooterViewWithTableView:(UITableView *)tableView;

@end
