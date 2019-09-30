//
//  UITableViewHeaderFooterView+BMAutomaticRegister.m
//  UITableView-BMTemplateLayoutCell
//
//  Created by Mac on 2019/9/27.
//  Copyright © 2019年 ( https://liangdahong.com ). All rights reserved.
//

#import "UITableViewHeaderFooterView+BMAutomaticRegister.h"
#import <objc/runtime.h>

@implementation UITableViewHeaderFooterView (BMAutomaticRegister)

- (BOOL)bm_maxYViewFixed {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setBm_maxYViewFixed:(BOOL)bm_maxYViewFixed {
    objc_setAssociatedObject(self, @selector(bm_maxYViewFixed), @(bm_maxYViewFixed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

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
