//
//  UITableView+BMDynamicLayout.h
//  UITableView-BMDynamicLayout
//
//  Created by liangdahong on 2019/9/30.
//  Copyright © 2019 liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+BMDynamicLayout.h"
#import "UITableViewHeaderFooterView+BMDynamicLayout.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BMHeaderFooterViewDynamicLayoutType) {
    BMHeaderFooterViewDynamicLayoutTypeHeader,
    BMHeaderFooterViewDynamicLayoutTypeFooter,
};

typedef void (^BMLayoutCellConfigurationBlock)(__kindof UITableViewCell *cell);
typedef void (^BMLayoutHeaderFooterConfigurationBlock)(__kindof UITableViewHeaderFooterView *headerFooterView);

@interface UITableView (BMDynamicLayout)

/**
 get cell height with class configuration
 */
- (CGFloat)bm_heightWithCellClass:(Class)clas
                    configuration:(BMLayoutCellConfigurationBlock)configuration;

/**
 get cell height with class indexPath configuration
 */
- (CGFloat)bm_heightWithCellClass:(Class)clas
                 cacheByIndexPath:(NSIndexPath *)indexPath
                    configuration:(BMLayoutCellConfigurationBlock)configuration;

/**
 get cell height with class key configuration
 */
- (CGFloat)bm_heightWithCellClass:(Class)clas
                       cacheByKey:(NSString *)key
                    configuration:(BMLayoutCellConfigurationBlock)configuration;

/**
 get headerFooterView height with class type configuration
 */
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

/**
 get headerFooterView height with class type section configuration
 */
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                               cacheBySection:(NSInteger)section
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

/**
 get headerFooterView height with class type key configuration
 */
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                   cacheByKey:(NSString *)key
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
@end

NS_ASSUME_NONNULL_END
