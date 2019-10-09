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

#import "UITableView+BMDynamicLayout.h"
#import <objc/runtime.h>
#import "UITableView+BMPrivate.h"
#import "UITableViewCell+BMPrivate.h"
#import "UITableViewHeaderFooterView+BMPrivate.h"

#ifdef DEBUG
    #define BM_LOG(...) NSLog(__VA_ARGS__)
#else
    #define BM_LOG(...)
#endif

void tableViewDynamicLayoutLayoutIfNeeded(UIView *view);
inline void tableViewDynamicLayoutLayoutIfNeeded(UIView *view) {
    // https://juejin.im/post/5a30f24bf265da432e5c0070
    // https://objccn.io/issue-3-5/
    [view setNeedsUpdateConstraints];
    [view setNeedsLayout];
    [view layoutIfNeeded];
    [view setNeedsDisplay];
}

@implementation UITableView (BMDynamicLayout)

#pragma mark - private cell

- (CGFloat)_heightWithCellClass:(Class)clas
                  configuration:(BMLayoutCellConfigurationBlock)configuration {
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

    UIView *temp = self.superview ? self.superview : self;
    [temp setNeedsUpdateConstraints];
    [temp setNeedsLayout];
    [temp layoutIfNeeded];
    [temp setNeedsDisplay];

    view.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 0.0f);
    UITableViewCell *cell = view.subviews.firstObject;
    cell.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 0.0f);

    !configuration ? : configuration(cell);

    tableViewDynamicLayoutLayoutIfNeeded(view);

    __block CGFloat maxY  = 0.0f;
    if (cell.bm_maxYViewFixed) {
        if (cell.maxYView) {
            return CGRectGetMaxY(cell.maxYView.frame);
        } else {
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
    } else {
        [cell.contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat tempY = CGRectGetMaxY(obj.frame);
            if (tempY > maxY) {
                maxY = tempY;
            }
        }];
        return maxY;
    }
}

#pragma mark - private HeaderFooterView

- (CGFloat)_heightWithHeaderFooterViewClass:(Class)clas
                                        sel:(SEL)sel
                              configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration {
    
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

    UIView *temp = self.superview ? self.superview : self;
    [temp setNeedsUpdateConstraints];
    [temp setNeedsLayout];
    [temp layoutIfNeeded];
    [temp setNeedsDisplay];

        view.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 0.0f);
    UITableViewHeaderFooterView *headerFooterView = view.subviews.firstObject;
    headerFooterView.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 0.0f);
    
    !configuration ? : configuration(headerFooterView);

    tableViewDynamicLayoutLayoutIfNeeded(view);

    UIView *contentView = headerFooterView.contentView.subviews.count ? headerFooterView.contentView : headerFooterView;
    __block CGFloat maxY  = 0.0f;
    if (headerFooterView.bm_maxYViewFixed) {
        if (headerFooterView.maxYView) {
            return CGRectGetMaxY(headerFooterView.maxYView.frame);
        } else {
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
    } else {
        [contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat tempY = CGRectGetMaxY(obj.frame);
            if (tempY > maxY) {
                maxY = tempY;
            }
        }];
        return maxY;
    }
}

- (CGFloat)_heightWithHeaderViewClass:(Class)clas
                        configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration {
    return [self _heightWithHeaderFooterViewClass:clas sel:_cmd configuration:configuration];
}

- (CGFloat)_heightWithFooterViewClass:(Class)clas
                        configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration {
    return [self _heightWithHeaderFooterViewClass:clas sel:_cmd configuration:configuration];
}

#pragma mark - Public cell

- (CGFloat)bm_heightWithCellClass:(Class)clas
                    configuration:(BMLayoutCellConfigurationBlock)configuration {
    return [self _heightWithCellClass:clas configuration:configuration];
}

- (CGFloat)bm_heightWithCellClass:(Class)clas
                 cacheByIndexPath:(NSIndexPath *)indexPath
                    configuration:(BMLayoutCellConfigurationBlock)configuration {
    // init arr
    {
        NSMutableArray <NSMutableArray <NSNumber *> *> *arr = self.verticalArray;
        long i = (indexPath.section + 1 - arr.count);
        while (i-- > 0) {
            [self.verticalArray addObject:@[].mutableCopy];
        }
        
        NSMutableArray <NSNumber *> *arr1 = arr[indexPath.section];
        long i1 = (indexPath.row + 1 - arr1.count);
        while (i1-- > 0) {
            [arr1 addObject:@(-1)];
        }
    }
    
    {
        NSMutableArray <NSMutableArray <NSNumber *> *> *arr = self.horizontalArray;
        long i = (indexPath.section + 1 - arr.count);
        while (i-- > 0) {
            [arr addObject:@[].mutableCopy];
        }
        
        NSMutableArray <NSNumber *> *arr1 = arr[indexPath.section];
        long i1 = (indexPath.row + 1 - arr1.count);
        while (i1-- > 0) {
            [arr1 addObject:@(-1)];
        }
    }

    NSNumber *number = self.heightArray[indexPath.section][indexPath.row];

    if (number.doubleValue == -1) {
        // not cache
        self.isIndexPathHeightCache = YES;

        // get cache height
        CGFloat cellHeight = [self _heightWithCellClass:clas configuration:configuration];
        
        // save cache height
        self.heightArray[indexPath.section][indexPath.row] = @(cellHeight);
        BM_LOG(@"save height { (indexPath: %ld %ld ) (height: %@) }", indexPath.section, indexPath.row, @(cellHeight));
        return cellHeight;
        
    } else {
        BM_LOG(@"get cache height { (indexPath: %ld %ld ) (height: %@) }", indexPath.section, indexPath.row, number);
        return number.doubleValue;
    }
}

- (CGFloat)bm_heightWithCellClass:(Class)clas
                       cacheByKey:(NSString *)key
                    configuration:(BMLayoutCellConfigurationBlock)configuration {
    if (key && self.heightDictionary[key]) {
        BM_LOG(@"get cache height { (key: %@) (height: %@) }", key, self.heightDictionary[key]);
        return self.heightDictionary[key].doubleValue;
    }
    self.isIndexPathHeightCache = NO;
    CGFloat cellHeight = [self _heightWithCellClass:clas configuration:configuration];
    if (key) {
        BM_LOG(@"save height { (key: %@) (height: %@) }", key, @(cellHeight));
        self.heightDictionary[key] = @(cellHeight);
    }
    return cellHeight;
}

#pragma mark - Public HeaderFooter

- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration {
    if (type == BMHeaderFooterViewDynamicLayoutTypeHeader) {
        return [self _heightWithHeaderViewClass:clas configuration:configuration];
    } else {
        return [self _heightWithFooterViewClass:clas configuration:configuration];
    }
}

- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                               cacheBySection:(NSInteger)section
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration {
    if (type == BMHeaderFooterViewDynamicLayoutTypeHeader) {
        // init arr
        NSMutableArray <NSNumber *> *arr1 = self.headerVerticalArray;
        long i1 = (section + 1 - arr1.count);
        while (i1-- > 0) {
            [self.headerVerticalArray addObject:@(-1)];
        }
        
        NSMutableArray <NSNumber *> *arr2 = self.headerHorizontalArray;
        long i2 = (section + 1 - arr2.count);
        while (i2-- > 0) {
            [self.headerHorizontalArray addObject:@(-1)];
        }

        NSNumber *number = self.headerHeightArray[section];
        
        if (number.doubleValue == -1) {
            // not cache
            self.isSectionHeaderHeightCache = YES;
            // get cache height
            CGFloat height = [self _heightWithHeaderViewClass:clas configuration:configuration];
            // save cache height
            self.headerHeightArray[section] = @(height);
            BM_LOG(@"header save height { ( section: %ld ) (height: %@) }", section, @(height));
            return height;
        } else {
            BM_LOG(@"header get cache height { (section: %ld ) (height: %@) }", section, number);
            return number.doubleValue;
        }
    } else {
        
        // init arr
        NSMutableArray <NSNumber *> *arr1 = self.footerVerticalArray;
        long i1 = (section + 1 - arr1.count);
        while (i1-- > 0) {
            [self.footerVerticalArray addObject:@(-1)];
        }

        NSMutableArray <NSNumber *> *arr2 = self.footerHorizontalArray;
        long i2 = (section + 1 - arr2.count);
        while (i2-- > 0) {
            [self.footerHorizontalArray addObject:@(-1)];
        }
        
        NSNumber *number = self.footerHeightArray[section];
        
        if (number.doubleValue == -1) {
            // not cache
            self.isSectionFooterHeightCache = YES;
            // get cache height
            CGFloat height = [self _heightWithFooterViewClass:clas configuration:configuration];
            // save cache height
            self.footerHeightArray[section] = @(height);
            BM_LOG(@"footer save height { ( section: %ld ) (height: %@) }", section, @(height));
            return height;
        } else {
            BM_LOG(@"footer get cache height { (section: %ld ) (height: %@) }", section, number);
            return number.doubleValue;
        }
    }
}

- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                   cacheByKey:(NSString *)key
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration {
    if (type == BMHeaderFooterViewDynamicLayoutTypeHeader) {
        if (key && self.headerHeightDictionary[key]) {
            BM_LOG(@"Header get cache height { (key: %@) (height: %@) }", key, self.headerHeightDictionary[key]);
            return self.headerHeightDictionary[key].doubleValue;
        }
        self.isSectionHeaderHeightCache = NO;
        CGFloat cellHeight = [self _heightWithHeaderViewClass:clas configuration:configuration];
        if (key) {
            BM_LOG(@"Header save height { (key: %@) (height: %@) }", key, @(cellHeight));
            self.heightDictionary[key] = @(cellHeight);
        }
        return cellHeight;
        
    } else {
        if (key && self.footerHeightDictionary[key]) {
            BM_LOG(@"footer get cache height { (key: %@) (height: %@) }", key, self.footerHeightDictionary[key]);
            return self.footerHeightDictionary[key].doubleValue;
        }
        self.isSectionFooterHeightCache = NO;
        CGFloat cellHeight = [self _heightWithFooterViewClass:clas configuration:configuration];
        
        if (key) {
            BM_LOG(@"footer save height { (key: %@) (height: %@) }", key, @(cellHeight));
            self.footerHeightDictionary[key] = @(cellHeight);
        }
        return cellHeight;
    }
}

@end
