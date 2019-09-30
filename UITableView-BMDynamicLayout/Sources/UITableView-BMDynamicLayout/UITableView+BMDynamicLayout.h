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

typedef NS_ENUM(NSInteger, BMDynamicLayoutType) {
    BMDynamicLayoutTypeHeader,
    BMDynamicLayoutTypeFooter,
};

typedef void (^BMLayoutCellConfigurationBlock)(__kindof UITableViewCell *cell);
typedef void (^BMLayoutHeaderFooterConfigurationBlock)(__kindof UITableViewHeaderFooterView *headerFooterView);

@interface UITableView (BMDynamicLayout)

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                           configuration:(BMLayoutCellConfigurationBlock)configuration;

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                        cacheByIndexPath:(NSIndexPath *)indexPath
                           configuration:(BMLayoutCellConfigurationBlock)configuration;

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                              cacheByKey:(NSString *)key
                           configuration:(BMLayoutCellConfigurationBlock)configuration;


- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
                                                            type:(BMDynamicLayoutType)type
                                                   configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
                                                            type:(BMDynamicLayoutType)type
                                                         section:(NSInteger)section
                                                   configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
                                                            type:(BMDynamicLayoutType)type
                                                      cacheByKey:(NSString *)key
                                                   configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
@end

NS_ASSUME_NONNULL_END
