//
//  UITableView+BMDynamicLayout.h
//  UITableView-BMDynamicLayout
//
//  Created by liangdahong on 2019/9/30.
//  Copyright © 2019 liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+BMAutomaticRegister.h"
#import "UITableViewHeaderFooterView+BMAutomaticRegister.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BMHeaderFooterViewDynamicLayoutType) {
    BMHeaderFooterViewDynamicLayoutTypeHeader,
    BMHeaderFooterViewDynamicLayoutTypeFooter,
};

typedef void (^BMLayoutCellConfigurationBlock)(__kindof UITableViewCell *cell);
typedef void (^BMLayoutHeaderFooterConfigurationBlock)(__kindof UITableViewHeaderFooterView *headerFooterView);

@interface UITableView (BMDynamicLayout)

- (CGFloat)bm_heightWithCellClass:(Class)clas
                    configuration:(BMLayoutCellConfigurationBlock)configuration;

- (CGFloat)bm_heightWithCellClass:(Class)clas
                 cacheByIndexPath:(NSIndexPath *)indexPath
                    configuration:(BMLayoutCellConfigurationBlock)configuration;

- (CGFloat)bm_heightWithCellClass:(Class)clas
                       cacheByKey:(NSString *)key
                    configuration:(BMLayoutCellConfigurationBlock)configuration;

- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                      section:(NSInteger)section
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                   cacheByKey:(NSString *)key
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
@end

NS_ASSUME_NONNULL_END
