//
//  UITableView+BMTemplateLayoutCell.h
//
//  Copyright © 2017年 https://github.com/asiosldh/UITableView-BMTemplateLayoutCell All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 BMLayoutCellConfigurationBlock
 
 @param cell 需要布局的Cell
 */
typedef void (^BMLayoutCellConfigurationBlock)(__kindof UITableViewCell *cell);

/**
 BMLayoutHeaderFooterViewConfigurationBlock
 
 @param headerFooterView 需要布局的tableViewHeaderFooterView
 */
typedef void (^BMLayoutHeaderFooterViewConfigurationBlock)(__kindof UITableViewHeaderFooterView *headerFooterView);

#pragma mark - BMTemplateLayoutCell

/**
 BMTemplateLayoutCell
 */
IB_DESIGNABLE
@interface UITableView (BMTemplateLayoutCell)

@property (assign, nonatomic, getter=isScreenRotating) IBInspectable BOOL screenRotating; ///< 是否支持屏幕旋转，默认NO

/**
 获取 Cell 的高度（内部不做任何缓存操作）
 
 @param clas Cell Class
 @param configuration 布局block
 @return 应该的高度
 */
- (CGFloat)bm_heightForCellWithCellClass:(Class)clas configuration:(BMLayoutCellConfigurationBlock)configuration;

/**
 获取 Cell 的高度（内部自动处理缓存）
 
 @param clas Cell Class
 @param indexPath 内部会使用 indexPath 做缓存
 @param configuration 布局block
 @return 应该的高度
 */
- (CGFloat)bm_heightForCellWithCellClass:(Class)clas cacheByIndexPath:(NSIndexPath *)indexPath configuration:(BMLayoutCellConfigurationBlock)configuration;

/**
 获取 Cell 的高度（内部自动处理缓存，推荐使用）
 
 @param clas Cell Class
 @param key 唯一key，内部以此key来做缓存key
 @param configuration 布局block
 @return 应该的高度
 */
- (CGFloat)bm_heightForCellWithCellClass:(Class)clas cacheByKey:(NSString *)key configuration:(BMLayoutCellConfigurationBlock)configuration;

@end

#pragma mark - BMTemplateLayoutHeaderFooterView

/**
 BMTemplateLayoutHeaderFooterView
 */
@interface UITableView (BMTemplateLayoutHeaderFooterView)

/**
 获取 HeaderFooterView 的高度（内部不做任何缓存操作）
 
 @param clas HeaderFooterView class
 @param configuration 布局block
 @return 应该的高度
 */
- (CGFloat)bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:(Class)clas configuration:(BMLayoutHeaderFooterViewConfigurationBlock)configuration;

/**
 获取 HeaderFooterView 的高度（内部自动处理缓存）
 
 @param clas HeaderFooterView class
 @param isHeaderView 是否是表头（组的头部：YES 组的尾部：NO）
 @param section 内部会使用 section 做缓存
 @param configuration 布局block
 @return 应该的高度
 */
- (CGFloat)bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:(Class)clas isHeaderView:(BOOL)isHeaderView section:(NSInteger)section configuration:(BMLayoutHeaderFooterViewConfigurationBlock)configuration;

/**
 获取 HeaderFooterView 的高度（内部自动处理缓存）
 
 @param clas HeaderFooterView class
 @param key 唯一key，内部会以次key来做缓存
 @param configuration 布局block
 @return 应该的高度
 */
- (CGFloat)bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:(Class)clas cacheByKey:(NSString *)key configuration:(BMLayoutHeaderFooterViewConfigurationBlock)configuration;

@end

#pragma mark - UITableViewCell BMTemplateLayoutCell

IB_DESIGNABLE
@interface UITableViewCell (BMTemplateLayoutCell)

/**
 最大Y的View是否为变化的，默认:NO（固定）,如果Cell的最大Y的View是变化的请设置为YES,通常是在设置了2个最大View时使用。
 */
@property (assign, nonatomic, getter=isDynamicCellBottomView) IBInspectable BOOL dynamicCellBottomView;

@end

#pragma mark - UITableViewHeaderFooterView BMTemplateLayoutCell

IB_DESIGNABLE
@interface UITableViewHeaderFooterView (BMTemplateLayoutCell)

/**
 最大Y的View是否为变化的，默认:NO（固定）,如果UITableViewHeaderFooterView的最大Y的View是变化的请设置为YES,通常是在设置了2个（更多）最大View时使用。
 */
@property (assign, nonatomic, getter=isDynamicHeaderFooterBottomView) IBInspectable BOOL dynamicHeaderFooterBottomView;

@end

NS_ASSUME_NONNULL_END
