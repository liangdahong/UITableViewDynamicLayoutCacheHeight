//
//  UITableViewCell+BMPrivate.m
//  UITableView-BMDynamicLayout
//
//  Created by liangdahong on 2019/9/30.
//  Copyright © 2019 liangdahong. All rights reserved.
//

#import "UITableViewCell+BMPrivate.h"
#import <objc/runtime.h>

@implementation UITableViewCell (BMPrivate)

- (UIView *)maxYView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMaxYView:(UIView *)maxYView {
    objc_setAssociatedObject(self, @selector(maxYView), maxYView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
