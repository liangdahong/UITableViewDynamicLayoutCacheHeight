//
//  UITableViewHeaderFooterView+BMReusable.m
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/8/28.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "UITableViewHeaderFooterView+BMReusable.h"

@implementation UITableViewHeaderFooterView (BMReusable)

+ (instancetype)bm_tableViewHeaderFooterViewWithTableView:(UITableView *)tableView {
    UITableViewHeaderFooterView *tableViewHeaderFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(self.class)];
    if (!tableViewHeaderFooterView) {
        tableViewHeaderFooterView = [[self alloc] initWithReuseIdentifier:NSStringFromClass(self.class)];
    }
    return tableViewHeaderFooterView;
}

@end
