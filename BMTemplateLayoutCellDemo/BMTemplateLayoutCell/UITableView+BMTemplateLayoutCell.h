//
//  UITableView+BMTemplateLayoutCell.h
//  IMTableViewDemo
//
//  Created by ___liangdahong on 2017/8/14.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef UIView * (^BMLayoutCellConfigurationBlock)(__kindof UITableViewCell *layoutCell);

@interface UITableView (BMTemplateLayoutCell)

- (CGFloat)bm_heightForCellWithIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath configuration:(BMLayoutCellConfigurationBlock)configuration;

@end
