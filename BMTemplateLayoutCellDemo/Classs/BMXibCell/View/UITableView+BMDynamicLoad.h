//
//  UITableView+BMDynamicLoad.h
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/11/28.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (BMDynamicLoad)

@property (copy, nonatomic) dispatch_block_t hitTestBlock;

@end
