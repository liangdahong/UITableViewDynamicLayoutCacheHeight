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

IB_DESIGNABLE
@interface UITableView (BMDynamicLayout)

///< 如果你的应用是不支持屏幕旋转的，建议设置此值为 TableView 的宽度（通常是屏幕宽度），可提升一定的性能。
///< fixedWidth
@property (nonatomic, assign) IBInspectable CGFloat fixedWidth;

/**
 get cell height with class configuration
 */
- (CGFloat)bm_heightWithCellClass:(Class)clas
                    configuration:(void (^)(__kindof UITableViewCell *cell))configuration;

/**
 get cell height with class indexPath configuration
 */
- (CGFloat)bm_heightWithCellClass:(Class)clas
                 cacheByIndexPath:(NSIndexPath *)indexPath
                    configuration:(void (^)(__kindof UITableViewCell *cell))configuration;

/**
 get cell height with class key configuration
 */
- (CGFloat)bm_heightWithCellClass:(Class)clas
                       cacheByKey:(NSString *)key
                    configuration:(void (^)(__kindof UITableViewCell *cell))configuration;

/**
 get headerFooterView height with class type configuration
 */
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                configuration:(void (^)(__kindof UITableViewHeaderFooterView *headerFooterView))configuration;

/**
 get headerFooterView height with class type section configuration
 */
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                               cacheBySection:(NSInteger)section
                                configuration:(void (^)(__kindof UITableViewHeaderFooterView *headerFooterView))configuration;

/**
 get headerFooterView height with class type key configuration
 */
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                   cacheByKey:(NSString *)key
                                configuration:(void (^)(__kindof UITableViewHeaderFooterView *headerFooterView))configuration;

@end

NS_ASSUME_NONNULL_END
