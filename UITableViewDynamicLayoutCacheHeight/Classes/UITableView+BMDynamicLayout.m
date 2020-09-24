//    MIT License
//
//    Copyright (c) 2019 https://github.com/liangdahong
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

#import "UITableView+BMDynamicLayout.h"
#import <objc/runtime.h>
#import "UITableView+BMPrivate.h"
#import "UITableViewHeaderFooterView+BMDynamicLayout.h"
#import "UITableViewCell+BMDynamicLayout.h"
#import "UITableViewDynamicLayoutCacheHeight.h"
#import "UITableView+BMPrivate.h"

void tableViewDynamicLayoutLayoutIfNeeded(UIView *view);
inline void tableViewDynamicLayoutLayoutIfNeeded(UIView *view) {
    // 1、https://juejin.im/post/5a30f24bf265da432e5c0070
    // 2、https://objccn.io/issue-3-5
    // 3、http://tech.gc.com/demystifying-ios-layout
    [view setNeedsLayout];
    [view layoutIfNeeded];
}

#pragma mark - UITableViewCell BMDynamicLayoutPrivate

@interface UITableViewCell (BMDynamicLayoutPrivate)

@property (nonatomic, strong) UIView *dynamicLayout_maxYView;

@end

@implementation UITableViewCell (BMDynamicLayoutPrivate)

- (UIView *)dynamicLayout_maxYView {
    return objc_getAssociatedObject(self, @selector(setDynamicLayout_maxYView:));
}

- (void)setDynamicLayout_maxYView:(UIView *)dynamicLayout_maxYView {
    objc_setAssociatedObject(self, _cmd, dynamicLayout_maxYView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma mark - UITableViewHeaderFooterView BMDynamicLayoutPrivate

@interface UITableViewHeaderFooterView (BMDynamicLayoutPrivate)

@property (nonatomic, strong) UIView *dynamicLayout_maxYView;

@end

@implementation UITableViewHeaderFooterView (BMDynamicLayoutPrivate)

- (UIView *)dynamicLayout_maxYView {
    return objc_getAssociatedObject(self, @selector(setDynamicLayout_maxYView:));
}

- (void)setDynamicLayout_maxYView:(UIView *)dynamicLayout_maxYView {
    objc_setAssociatedObject(self, _cmd, dynamicLayout_maxYView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma mark - UITableView BMDynamicLayout

@implementation UITableView (BMDynamicLayout)

#pragma mark - private cell

- (UIView *)_cellViewWithCellClass:(Class)clas {
    NSString *cellClassName = NSStringFromClass(clas);

    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UIView *view = dict[cellClassName];
    if (view) {
        return view;
    }
    
    NSBundle *bundle = [NSBundle bundleForClass:clas];
    NSString *path = [bundle pathForResource:kSwiftClassNibName(cellClassName) ofType:@"nib"];
    UITableViewCell *cell = nil;
    if (path.length > 0) {
        NSArray <UITableViewCell *> *arr = [[UINib nibWithNibName:kSwiftClassNibName(cellClassName) bundle:bundle] instantiateWithOwner:nil options:nil];
        for (UITableViewCell *obj in arr) {
            if ([obj isMemberOfClass:clas]) {
                cell = obj;
                // 清空 reuseIdentifier
                [cell setValue:nil forKey:@"reuseIdentifier"];
                break;
            }
        }
    }
    if (!cell) {
        // 这里使用默认的 UITableViewCellStyleDefault 类型。
        // 如果需要自定义高度，通常都是使用的此类型, 暂时不考虑其他。
        cell = [[clas alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    view = [UIView new];
    [view addSubview:cell];
    dict[cellClassName] = view;
    return view;
}

- (CGFloat)_heightWithCellClass:(Class)clas
                  configuration:(BMConfigurationCellBlock)configuration {
    UIView *view = [self _cellViewWithCellClass:clas];
    
    // 设置 Frame
    view.frame = CGRectMake(0.0, 0.0, self.bm_layoutWidth, 0.0);
    UITableViewCell *cell = view.subviews[0];
    cell.frame = CGRectMake(0.0, 0.0, self.bm_layoutWidth, 0.0);
    
    dispatch_async(dispatch_get_main_queue(), ^(void) {
        // 刷新完成后 如果 tableView 的真实宽度和刚才的宽度不同就刷新 tableView
        if (fabs(self.bm_layoutWidth - CGRectGetWidth(self.bounds)) > 0.1 ) {
            BM_UITableView_DynamicLayout_LOG(@"❌❌❌❌ tableView 宽度有调整，需要刷新 真实宽度：%@  刚才布局时取的无效宽度：%@",
                                             @(CGRectGetWidth(self.bounds)),
                                             @(self.bm_layoutWidth));
            // 保存真正的 width
            self.bm_layoutWidth = CGRectGetWidth(self.bounds);
            // 清除无效的缓存
            [self bm_clearInvalidCache];
            // 刷新 tableView
            [self reloadData];
        }
    });

    // 让外面布局 Cell
    !configuration ? : configuration(cell);

    // 刷新布局
    tableViewDynamicLayoutLayoutIfNeeded(view);

    // 获取需要的高度
    __block CGFloat maxY  = 0.0;
    if (cell.bm_maxYViewFixed) {
        if (cell.dynamicLayout_maxYView) {
            return CGRectGetMaxY(cell.dynamicLayout_maxYView.frame);
        }
        __block UIView *maxXView = nil;
        [cell.contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat tempY = CGRectGetMaxY(obj.frame);
            if (tempY > maxY) {
                maxY = tempY;
                maxXView = obj;
            }
        }];
        cell.dynamicLayout_maxYView = maxXView;
        return maxY;
    }
    [cell.contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat tempY = CGRectGetMaxY(obj.frame);
        if (tempY > maxY) {
            maxY = tempY;
        }
    }];
    return maxY;
}

#pragma mark - private HeaderFooterView

- (UIView *)_headerFooterViewWithHeaderFooterViewClass:(Class)clas
                                                   sel:(SEL)sel {
    NSString *headerFooterViewClassName = NSStringFromClass(clas);

    NSMutableDictionary *dict = objc_getAssociatedObject(self, sel);
    if (!dict) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, sel, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    UIView *view = dict[headerFooterViewClassName];
    if (view) {
        // 直接返回
        return view;
    }

    NSBundle *bundle = [NSBundle bundleForClass:clas];
    NSString *path = [bundle pathForResource:kSwiftClassNibName(headerFooterViewClassName) ofType:@"nib"];
    UIView *headerView = nil;
    if (path.length > 0) {
        NSArray <UITableViewHeaderFooterView *> *arr = [[UINib nibWithNibName:kSwiftClassNibName(headerFooterViewClassName) bundle:bundle] instantiateWithOwner:nil options:nil];
        for (UITableViewHeaderFooterView *obj in arr) {
            if ([obj isMemberOfClass:clas]) {
                headerView = obj;
                // 清空 reuseIdentifier
                [headerView setValue:nil forKey:@"reuseIdentifier"];
                break;
            }
        }
    }
    if (!headerView) {
        headerView = [[clas alloc] initWithReuseIdentifier:nil];
    }
    view = [UIView new];
    [view addSubview:headerView];
    dict[headerFooterViewClassName] = view;
    return view;
}

- (CGFloat)_heightWithHeaderFooterViewClass:(Class)clas
                                        sel:(SEL)sel
                              configuration:(BMConfigurationHeaderFooterViewBlock)configuration {
    UIView *view = [self _headerFooterViewWithHeaderFooterViewClass:clas sel:sel];
    // 设置 Frame
    view.frame = CGRectMake(0.0, 0.0, self.bm_layoutWidth, 0.0);
    UITableViewHeaderFooterView *headerFooterView = view.subviews[0];
    headerFooterView.frame = CGRectMake(0.0, 0.0, self.bm_layoutWidth, 0.0);

    dispatch_async(dispatch_get_main_queue(), ^(void) {
        // 刷新完成后 如果 tableView 的真实宽度和刚才的宽度不同就刷新 tableView
        if (fabs(self.bm_layoutWidth - CGRectGetWidth(self.bounds)) > 0.1 ) {
            BM_UITableView_DynamicLayout_LOG(@"❌❌❌❌ tableView 宽度有调整，需要刷新 真实宽度：%@  刚才布局时取的无效宽度：%@",
                                             @(CGRectGetWidth(self.bounds)),
                                             @(self.bm_layoutWidth));
            // 保存真正的 width
            self.bm_layoutWidth = CGRectGetWidth(self.bounds);
            // 清除无效的缓存
            [self bm_clearInvalidCache];
            // 刷新 tableView
            [self reloadData];
        }
    });
    
    // 让外面布局 UITableViewHeaderFooterView
    !configuration ? : configuration(headerFooterView);
    
    // 刷新布局
    tableViewDynamicLayoutLayoutIfNeeded(view);

    UIView *contentView = headerFooterView.contentView.subviews.count ? headerFooterView.contentView : headerFooterView;

    // 获取需要的高度
    __block CGFloat maxY  = 0.0;
    if (headerFooterView.bm_maxYViewFixed) {
        if (headerFooterView.dynamicLayout_maxYView) {
            return CGRectGetMaxY(headerFooterView.dynamicLayout_maxYView.frame);
        }
        __block UIView *maxXView = nil;
        [contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat tempY = CGRectGetMaxY(obj.frame);
            if (tempY > maxY) {
                maxY = tempY;
                maxXView = obj;
            }
        }];
        headerFooterView.dynamicLayout_maxYView = maxXView;
        return maxY;
    }
    [contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat tempY = CGRectGetMaxY(obj.frame);
        if (tempY > maxY) {
            maxY = tempY;
        }
    }];
    return maxY;
}

- (CGFloat)_heightWithHeaderViewClass:(Class)clas
                        configuration:(BMConfigurationHeaderFooterViewBlock)configuration {
    return [self _heightWithHeaderFooterViewClass:clas sel:_cmd configuration:configuration];
}

- (CGFloat)_heightWithFooterViewClass:(Class)clas
                        configuration:(BMConfigurationHeaderFooterViewBlock)configuration {
    return [self _heightWithHeaderFooterViewClass:clas sel:_cmd configuration:configuration];
}

#pragma mark - Public cell

- (CGFloat)bm_heightWithCellClass:(Class)clas
                    configuration:(BMConfigurationCellBlock)configuration {
    if (__builtin_expect((!self.isDynamicLayoutInitializationed), 0)) {
        [self bm_dynamicLayoutInitialization];
    }
    return [self _heightWithCellClass:clas configuration:configuration];
}

- (CGFloat)bm_heightWithCellClass:(Class)clas
                 cacheByIndexPath:(NSIndexPath *)indexPath
                    configuration:(BMConfigurationCellBlock)configuration {
    if (__builtin_expect((!self.isDynamicLayoutInitializationed), 0)) {
        [self bm_dynamicLayoutInitialization];
    }
    NSNumber *number = self.heightArray[indexPath.section][indexPath.row];
    if (number.doubleValue < 0.0) {
        // 没有缓存
        // 计算高度
        CGFloat cellHeight = [self _heightWithCellClass:clas configuration:configuration];
        // 缓存高度
        self.heightArray[indexPath.section][indexPath.row] = @(cellHeight);
        BM_UITableView_DynamicLayout_LOG(@"BMLog:⚠️计算高度⚠️ Cell: %@ save height { (indexPath: %@ %@ ) (height: %@) }",
                                         NSStringFromClass(clas),
                                         @(indexPath.section),
                                         @(indexPath.row),
                                         @(cellHeight));
        return cellHeight;
    }
    BM_UITableView_DynamicLayout_LOG(@"BMLog:✅✅读缓存✅✅ Cell: %@ get cache height { (indexPath: %@ %@ ) (height: %@) }",
                                     NSStringFromClass(clas),
                                     @(indexPath.section),
                                     @(indexPath.row), number);
    return number.doubleValue;
}

- (CGFloat)bm_heightWithCellClass:(Class)clas
                       cacheByKey:(id<NSCopying>)key
                    configuration:(BMConfigurationCellBlock)configuration {
    if (__builtin_expect((!self.isDynamicLayoutInitializationed), 0)) {
        [self bm_dynamicLayoutInitialization];
    }
    if (key && self.heightDictionary[key]) {
        BM_UITableView_DynamicLayout_LOG(@"BMLog:✅✅读缓存✅✅Cell: %@ get cache height { (key: %@) (height: %@) }", NSStringFromClass(clas), key, self.heightDictionary[key]);
        return self.heightDictionary[key].doubleValue;
    }
    CGFloat cellHeight = [self _heightWithCellClass:clas configuration:configuration];
    if (key) {
        BM_UITableView_DynamicLayout_LOG(@"BMLog:⚠️计算高度⚠️ Cell: %@ save height { (key: %@) (height: %@) }", NSStringFromClass(clas), key, @(cellHeight));
        self.heightDictionary[key] = @(cellHeight);
    }
    return cellHeight;
}

#pragma mark - Public HeaderFooter

- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                configuration:(BMConfigurationHeaderFooterViewBlock)configuration {
    if (__builtin_expect((!self.isDynamicLayoutInitializationed), 0)) {
        [self bm_dynamicLayoutInitialization];
    }
    if (type == BMHeaderFooterViewDynamicLayoutTypeHeader) {
        return [self _heightWithHeaderViewClass:clas configuration:configuration];
    }
    return [self _heightWithFooterViewClass:clas configuration:configuration];
}

- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                               cacheBySection:(NSInteger)section
                                configuration:(BMConfigurationHeaderFooterViewBlock)configuration {
    if (__builtin_expect((!self.isDynamicLayoutInitializationed), 0)) {
        [self bm_dynamicLayoutInitialization];
    }
    if (type == BMHeaderFooterViewDynamicLayoutTypeHeader) {
        NSNumber *number = self.headerHeightArray[section];
        if (number.doubleValue >= 0.0) {
            BM_UITableView_DynamicLayout_LOG(@"BMLog:✅✅读缓存✅✅ Header: %@ get cache height { (section: %@ ) (height: %@) }", NSStringFromClass(clas), @(section), number);
            return number.doubleValue;
        }
        // not cache
        // get cache height
        CGFloat height = [self _heightWithHeaderViewClass:clas configuration:configuration];
        // save cache height
        self.headerHeightArray[section] = @(height);
        BM_UITableView_DynamicLayout_LOG(@"BMLog:⚠️计算高度⚠️ Header: %@ save height { ( section: %@ ) (height: %@) }", NSStringFromClass(clas), @(section), @(height));
        return height;
    }
    NSNumber *number = self.footerHeightArray[section];
    if (number.doubleValue >= 0.0) {
        BM_UITableView_DynamicLayout_LOG(@"BMLog:✅✅读缓存✅✅ Footer: %@ get cache height { (section: %@ ) (height: %@) }", NSStringFromClass(clas), @(section), number);
        return number.doubleValue;
    }
    // not cache
    // get cache height
    CGFloat height = [self _heightWithFooterViewClass:clas configuration:configuration];
    // save cache height
    self.footerHeightArray[section] = @(height);
    BM_UITableView_DynamicLayout_LOG(@"BM:⚠️计算高度⚠️ Footer: %@ save height { ( section: %@ ) (height: %@) }", NSStringFromClass(clas), @(section), @(height));
    return height;
}

- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                   cacheByKey:(id<NSCopying>)key
                                configuration:(BMConfigurationHeaderFooterViewBlock)configuration {
    if (__builtin_expect((!self.isDynamicLayoutInitializationed), 0)) {
        [self bm_dynamicLayoutInitialization];
    }
    if (type == BMHeaderFooterViewDynamicLayoutTypeHeader) {
        if (key && self.headerHeightDictionary[key]) {
            BM_UITableView_DynamicLayout_LOG(@"BMLog:✅✅读缓存✅✅ Header: %@ get cache height { (key: %@) (height: %@) }", NSStringFromClass(clas), key, self.headerHeightDictionary[key]);
            return self.headerHeightDictionary[key].doubleValue;
        }
        CGFloat cellHeight = [self _heightWithHeaderViewClass:clas configuration:configuration];
        if (key) {
            BM_UITableView_DynamicLayout_LOG(@"BML:⚠️计算高度⚠️ Header: %@ save height { (key: %@) (height: %@) }", NSStringFromClass(clas), key, @(cellHeight));
            self.heightDictionary[key] = @(cellHeight);
        }
        return cellHeight;

    }
    if (key && self.footerHeightDictionary[key]) {
        BM_UITableView_DynamicLayout_LOG(@"BMLog:✅✅读缓存✅✅ Footer: %@ get cache height { (key: %@) (height: %@) }", NSStringFromClass(clas), key, self.footerHeightDictionary[key]);
        return self.footerHeightDictionary[key].doubleValue;
    }
    CGFloat cellHeight = [self _heightWithFooterViewClass:clas configuration:configuration];
    if (key) {
        BM_UITableView_DynamicLayout_LOG(@"BML:⚠️计算高度⚠️  Footer: %@ save height { (key: %@) (height: %@) }", NSStringFromClass(clas), key, @(cellHeight));
        self.footerHeightDictionary[key] = @(cellHeight);
    }
    return cellHeight;
}

@end
