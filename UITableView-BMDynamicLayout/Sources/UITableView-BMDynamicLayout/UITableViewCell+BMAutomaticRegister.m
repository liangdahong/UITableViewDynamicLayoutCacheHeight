//
//  UITableViewCell+BMAutomaticRegister.m
//  UITableView-BMTemplateLayoutCell
//
//  Created by Mac on 2019/9/27.
//  Copyright © 2019年 ( https://liangdahong.com ). All rights reserved.
//

#import "UITableViewCell+BMAutomaticRegister.h"

@implementation UITableViewCell (BMAutomaticRegister)

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
