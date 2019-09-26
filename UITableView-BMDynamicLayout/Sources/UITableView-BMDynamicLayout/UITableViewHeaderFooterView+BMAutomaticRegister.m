//
//  UITableViewHeaderFooterView+BMAutomaticRegister.m
//  UITableView-BMTemplateLayoutCell
//
//  Created by Mac on 2019/9/27.
//  Copyright © 2019年 ( https://liangdahong.com ). All rights reserved.
//

#import "UITableViewHeaderFooterView+BMAutomaticRegister.h"

@implementation UITableViewHeaderFooterView (BMAutomaticRegister)

+ (instancetype)bm_tableViewHeaderFooterViewWithTableView:(UITableView *)tableView {
    NSString *selfClassName = NSStringFromClass(self.class);
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:selfClassName];
    if (headerFooterView) {
        return headerFooterView;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:selfClassName ofType:@"nib"];
    if (path.length) {
        headerFooterView = [[[UINib nibWithNibName:selfClassName bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        [headerFooterView setValue:selfClassName forKey:@"reuseIdentifier"];
    } else {
        headerFooterView = [[self alloc] initWithReuseIdentifier:selfClassName];
    }
    return headerFooterView;
}

@end
