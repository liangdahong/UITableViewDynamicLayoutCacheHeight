//
//  UITableViewCell+BMAutomaticRegister.m
//  UITableView-BMTemplateLayoutCell
//
//  Created by Mac on 2019/9/27.
//  Copyright © 2019年 ( https://liangdahong.com ). All rights reserved.
//

#import "UITableViewCell+BMAutomaticRegister.h"
#import <objc/runtime.h>

@implementation UITableViewCell (BMAutomaticRegister)

- (BOOL)bm_maxYViewFixed {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setBm_maxYViewFixed:(BOOL)bm_maxYViewFixed {
    objc_setAssociatedObject(self, @selector(bm_maxYViewFixed), @(bm_maxYViewFixed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (instancetype)bm_tableViewCellWithTableView:(UITableView *)tableView {
    return [self bm_tableViewCellWithTableView:tableView style:UITableViewCellStyleDefault];
}

+ (instancetype)bm_tableViewCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style {
    NSString *selfClassName = NSStringFromClass(self.class);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selfClassName];
    if (cell) {
        return cell;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:selfClassName ofType:@"nib"];
    if (path.length) {
        cell = [[[UINib nibWithNibName:selfClassName bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        [cell setValue:selfClassName forKey:@"reuseIdentifier"];
    } else {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:selfClassName];
    }
    return cell;
}

@end
