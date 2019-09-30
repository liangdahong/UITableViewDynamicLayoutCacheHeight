//
//  UITableViewHeaderFooterView+BMAutomaticRegister.h
//  UITableView-BMTemplateLayoutCell
//
//  Created by Mac on 2019/9/27.
//  Copyright © 2019年 ( https://liangdahong.com ). All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface UITableViewHeaderFooterView (BMAutomaticRegister)

@property (nonatomic, assign) IBInspectable BOOL bm_maxYViewFixed; ///< maxY view whether fixed, default NO.

+ (instancetype)bm_tableViewHeaderFooterViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
