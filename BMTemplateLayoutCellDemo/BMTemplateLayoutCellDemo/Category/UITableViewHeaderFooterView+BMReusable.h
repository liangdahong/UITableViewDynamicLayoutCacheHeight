//
//  UITableViewHeaderFooterView+BMReusable.h
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/8/28.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kBMTableViewHeaderFooterViewProperty(clas, propertyName) @property (strong, nonatomic) clas *propertyName;

#define kkBMTableViewHeaderFooterViewInit(clas, propertyName)\
\
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {\
if (self = [super initWithReuseIdentifier:reuseIdentifier]) {\
_##propertyName = [[[UINib nibWithNibName:NSStringFromClass(clas.class) bundle:nil] instantiateWithOwner:nil options:nil] firstObject];\
[self.contentView addSubview:_##propertyName];\
[_##propertyName mas_makeConstraints:^(MASConstraintMaker *make) {\
make.top.left.right.mas_equalTo(0);\
}];\
}\
return self;\
}\
\

@interface UITableViewHeaderFooterView (BMReusable)

+ (instancetype)bm_tableViewHeaderFooterViewWithTableView:(UITableView *)tableView;

@end
