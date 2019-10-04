//
//  UITableViewCell+BMDynamicLayout.h
//  UITableView-BMDynamicLayout
//
//  Created by Mac on 2019/10/4.
//  Copyright © 2019年 liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface UITableViewCell (BMDynamicLayout)

@property (nonatomic, assign) IBInspectable BOOL bm_maxYViewFixed; ///< maxY view whether fixed, default NO.

+ (instancetype)bm_tableViewCellWithTableView:(UITableView *)tableView;
+ (instancetype)bm_tableViewCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@end

NS_ASSUME_NONNULL_END
