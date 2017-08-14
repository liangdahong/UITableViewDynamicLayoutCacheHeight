//
//  TableViewCell.m
//  IMTableViewDemo
//
//  Created by __liangdahong on 2017/8/12.
//  Copyright © 2017年 https://github.com/asiosldh/UITableView-BMTemplateLayoutCell All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.LABEEE.layer.cornerRadius = 10;
    self.LABEEE.layer.masksToBounds = YES;
}
@end
