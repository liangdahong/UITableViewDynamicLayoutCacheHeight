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
#import "UITableViewCell+BMPrivate.h"
#import "UITableViewHeaderFooterView+BMPrivate.h"
#import "UITableViewHeaderFooterView+BMDynamicLayout.h"
#import "UITableViewCell+BMDynamicLayout.h"
#import "UITableViewDynamicLayoutCacheHeight.h"

void tableViewDynamicLayoutLayoutIfNeeded(UIView *view);
inline void tableViewDynamicLayoutLayoutIfNeeded(UIView *view) {
    // https://juejin.im/post/5a30f24bf265da432e5c0070/
    // https://objccn.io/issue-3-5/
    // http://tech.gc.com/demystifying-ios-layout/
    [view setNeedsLayout];
    [view layoutIfNeeded];
}

@implementation UITableView (BMDynamicLayout)

#pragma mark - private cell

- (UIView *)_cellViewWithCellClass:(Class)clas {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    UIView *view = dict[NSStringFromClass(clas)];

    if (!view) {
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clas) ofType:@"nib"];
        UIView *cell = nil;
        if (path.length) {
            cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas) owner:nil options:nil].firstObject;
        } else {
            cell = [[clas alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        view = [UIView new];
        [view addSubview:cell];
        dict[NSStringFromClass(clas)] = view;
    }
    return view;
}

- (CGFloat)_heightWithCellClass:(Class)clas
                  configuration:(BMConfigurationCellBlock)configuration {
    UIView *view = [self _cellViewWithCellClass:clas];
    // 获取 TableView 宽度
    UIView *temp = self.superview ? self.superview : self;
    tableViewDynamicLayoutLayoutIfNeeded(temp);
    CGFloat width = CGRectGetWidth(self.frame);

    // 设置 Frame
    view.frame = CGRectMake(0.0f, 0.0f, width, 0.0f);
    UITableViewCell *cell = view.subviews.firstObject;
    cell.frame = CGRectMake(0.0f, 0.0f, width, 0.0f);

    // 让外面布局 Cell
    !configuration ? : configuration(cell);

    // 刷新布局
    tableViewDynamicLayoutLayoutIfNeeded(view);

    // 获取需要的高度
    __block CGFloat maxY  = 0.0f;
    if (cell.bm_maxYViewFixed) {
        if (cell.maxYView) {
            return CGRectGetMaxY(cell.maxYView.frame);
        }
        __block UIView *maxXView = nil;
        [cell.contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat tempY = CGRectGetMaxY(obj.frame);
            if (tempY > maxY) {
                maxY = tempY;
                maxXView = obj;
            }
        }];
        cell.maxYView = maxXView;
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

- (CGFloat)_heightWithHeaderFooterViewClass:(Class)clas
                                        sel:(SEL)sel
                              configuration:(BMConfigurationHeaderFooterViewBlock)configuration {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, sel);
    if (!dict) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, sel, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    UIView *view = dict[NSStringFromClass(clas)];

    if (!view) {
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clas) ofType:@"nib"];
        UIView *headerView = nil;
        if (path.length) {
            headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas) owner:nil options:nil].firstObject;
        } else {
            headerView = [[clas alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        }
        view = [UIView new];
        [view addSubview:headerView];
        dict[NSStringFromClass(clas)] = view;
    }

    // 获取 TableView 宽度
    UIView *temp = self.superview ? self.superview : self;
    tableViewDynamicLayoutLayoutIfNeeded(temp);
    CGFloat width = CGRectGetWidth(self.frame);

    // 设置 Frame
    view.frame = CGRectMake(0.0f, 0.0f, width, 0.0f);
    UITableViewHeaderFooterView *headerFooterView = view.subviews.firstObject;
    headerFooterView.frame = CGRectMake(0.0f, 0.0f, width, 0.0f);

    // 让外面布局 UITableViewHeaderFooterView
    !configuration ? : configuration(headerFooterView);
    // 刷新布局
    tableViewDynamicLayoutLayoutIfNeeded(view);

    UIView *contentView = headerFooterView.contentView.subviews.count ? headerFooterView.contentView : headerFooterView;

    // 获取需要的高度
    __block CGFloat maxY  = 0.0f;
    if (headerFooterView.bm_maxYViewFixed) {
        if (headerFooterView.maxYView) {
            return CGRectGetMaxY(headerFooterView.maxYView.frame);
        }
        __block UIView *maxXView = nil;
        [contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat tempY = CGRectGetMaxY(obj.frame);
            if (tempY > maxY) {
                maxY = tempY;
                maxXView = obj;
            }
        }];
        headerFooterView.maxYView = maxXView;
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
    return [self _heightWithCellClass:clas configuration:configuration];
}

- (CGFloat)bm_heightWithCellClass:(Class)clas
                 cacheByIndexPath:(NSIndexPath *)indexPath
                    configuration:(BMConfigurationCellBlock)configuration {
    if (__builtin_expect((!self.isDynamicLayoutInitializationed), 0)) {
        BM_UITableView_DynamicLayout_LOG(@"没有初始化过 %@", NSStringFromSelector(_cmd));
        [self dynamicLayoutInitialization];
    }
    NSNumber *number = self.heightArray[indexPath.section][indexPath.row];
    if (number.doubleValue < 0.0) {
        // not cache
        // get cache height
        CGFloat cellHeight = [self _heightWithCellClass:clas configuration:configuration];
        // save cache height
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
        BM_UITableView_DynamicLayout_LOG(@"没有初始化过 %@", NSStringFromSelector(_cmd));
        [self dynamicLayoutInitialization];
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
