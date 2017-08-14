//
//  UITableView+BMTemplateLayoutCell.h
//  IMTableViewDemo
//
//  Created by http://idhong.com/ on 2017/8/14.
//  Copyright © 2017年 https://github.com/asiosldh/UITableView-BMTemplateLayoutCell All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BMLayoutCellConfigurationBlock)(__kindof UITableViewCell *layoutCell);

@interface BMTemplateLayoutCellBottonView : UIView

@end

@interface UITableView (BMTemplateLayoutCell)

- (CGFloat)bm_heightForCellWithIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath configuration:(BMLayoutCellConfigurationBlock)configuration;

@end
