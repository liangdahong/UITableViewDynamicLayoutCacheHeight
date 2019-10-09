//    MIT License
//
//    Copyright (c) 2019 https://liangdahong.com
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

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
