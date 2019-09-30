//
//  UITableViewCell+BMAutomaticRegister.h
//  UITableView-BMTemplateLayoutCell
//
//  Created by Mac on 2019/9/27.
//  Copyright © 2019年 ( https://liangdahong.com ). All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface UITableViewCell (BMAutomaticRegister)

@property (nonatomic, assign) IBInspectable BOOL bm_maxYViewFixed; ///< maxY view whether fixed, default NO.

+ (instancetype)bm_tableViewCellWithTableView:(UITableView *)tableView;
+ (instancetype)bm_tableViewCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@end

NS_ASSUME_NONNULL_END
