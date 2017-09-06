//
//  UITableView+BMTemplateLayoutCell.m
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

#import "UITableView+BMTemplateLayoutCell.h"
#import <objc/runtime.h>

#define isPortrait  (CGRectGetWidth([[UIScreen mainScreen] bounds]) < CGRectGetHeight([[UIScreen mainScreen] bounds]))

/**
 交换2个方法的调用
 */
void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    // 1.获取旧 Method
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    // 2.获取新 Method
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    // 3.交换方法
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

CGFloat height(NSNumber *value) {
#if CGFLOAT_IS_DOUBLE
    return value.doubleValue;
#else
    return value.floatValue;
#endif
}

#ifdef DEBUG 
    #define BMTemplateLayoutCellLog(...) NSLog(__VA_ARGS__)
#else
    #define BMTemplateLayoutCellLog(...)
#endif

@interface UITableView ()

@property (strong, nonatomic, readonly) NSMutableDictionary *portraitCacheCellHeightMutableDictionary;     ///< portraitCacheCellHeightMutableDictionary
@property (strong, nonatomic, readonly) NSMutableDictionary *landscapeCacheCellHeightMutableDictionary;    ///< landscapeCacheCellHeightMutableDictionary
@property (strong, nonatomic, readonly) NSMutableDictionary *portraitCacheKeyCellHeightMutableDictionary;  ///< portraitCacheKeyCellHeightMutableDictionary
@property (strong, nonatomic, readonly) NSMutableDictionary *landscapeCacheKeyCellHeightMutableDictionary; ///< landscapeCacheKeyCellHeightMutableDictionary
@property (strong, nonatomic, readonly) NSMutableDictionary *reusableCellWithIdentifierMutableDictionary;  ///< reusableCellWithIdentifierMutableDictionary

@end

@implementation UITableView (BMTemplateLayoutCell)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(reloadData),
            @selector(insertSections:withRowAnimation:),
            @selector(deleteSections:withRowAnimation:),
            @selector(reloadSections:withRowAnimation:),
            @selector(moveSection:toSection:),
            @selector(insertRowsAtIndexPaths:withRowAnimation:),
            @selector(deleteRowsAtIndexPaths:withRowAnimation:),
            @selector(reloadRowsAtIndexPaths:withRowAnimation:),
            @selector(moveRowAtIndexPath:toIndexPath:)
        };
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"bm_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            swizzleMethod(self.class, originalSelector, swizzledSelector);
        }
    });
}

- (UIView *)bm_tempViewCellWithCellClass:(Class)clas {
    // 创建新的重用标识
    NSString *noReuseIdentifier = [NSString stringWithFormat:@"noReuse%@", NSStringFromClass(clas.class)];
    NSString *noReuseIdentifierChar = self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier];
    if (!noReuseIdentifierChar) {
        noReuseIdentifierChar = noReuseIdentifier;
        self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier] = noReuseIdentifier;
    }
    // 取特定的重用标识是否绑定的Cell
    UIView *tempView = objc_getAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar));
    if (!tempView) {
        // 没有绑定就创建
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clas.class) ofType:@"nib"];
        UITableViewCell *noCacheCell = nil;
        if (path.length) {
            noCacheCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas.class) owner:nil options:nil] firstObject];
            [noCacheCell setValue:noReuseIdentifier forKey:@"reuseIdentifier"];
        } else {
            noCacheCell = [[clas alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noReuseIdentifier];
        }
        // 绑定起来
        tempView = [UIView new];
        [tempView addSubview:noCacheCell];
        objc_setAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar), tempView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        BMTemplateLayoutCellLog(@"第一次创建 %@ 的布局对象 cell：%@", clas, noCacheCell);
    }
    return tempView;
}

- (CGFloat)bm_layoutIfNeededCellWith:(UITableViewCell *)cell configuration:(BMLayoutCellConfigurationBlock)configuration {
    cell.superview.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.0f);
    cell.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.0f);
    configuration(cell);
    [cell.superview layoutIfNeeded];
    __block CGFloat maxY = 0.0f;
    [cell.contentView.subviews  enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (maxY <  CGRectGetMaxY(obj.frame)) {
            maxY = CGRectGetMaxY(obj.frame);
        }
    }];
    if (maxY > 0.0f) {
        maxY += 0.5f;
    }
    return maxY;
}

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas configuration:(BMLayoutCellConfigurationBlock)configuration {
    if (!clas || configuration) {
        return 0.0f;
    }
    UIView *tempView = [self bm_tempViewCellWithCellClass:clas];
    return [self bm_layoutIfNeededCellWith:tempView.subviews[0] configuration:configuration];
}

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                        cacheByIndexPath:(NSIndexPath *)indexPath
                           configuration:(BMLayoutCellConfigurationBlock)configuration {
    if (!clas || !configuration) {
        return 0.0f;
    }
    if (!indexPath) {
       return [self bm_heightForCellWithCellClass:clas configuration:configuration];
    }
    NSString *key = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    
    NSNumber *heightValue = (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[key];
    if (heightValue) {
        BMTemplateLayoutCellLog(@"%@已缓存了 取缓存:%@", indexPath, heightValue);
        return height(heightValue);
    }
    UIView *tempView = [self bm_tempViewCellWithCellClass:clas];
    CGFloat height = [self bm_layoutIfNeededCellWith:tempView.subviews[0] configuration:configuration];
    (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[key] = @(height);
    BMTemplateLayoutCellLog(@"%@没有缓存 布局获取到的高度是:%f", indexPath, height);
    return height;
}

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas cacheByKey:(NSString *)key configuration:(BMLayoutCellConfigurationBlock)configuration {
    if (!clas || !configuration) {
        return 0.0f;
    }
    if (!key || key.length == 0) {
        return [self bm_heightForCellWithCellClass:clas configuration:configuration];
    }
    NSNumber *heightValue = (isPortrait ? self.portraitCacheKeyCellHeightMutableDictionary :  self.landscapeCacheKeyCellHeightMutableDictionary)[key];
    if (heightValue) {
        BMTemplateLayoutCellLog(@"cacheByKey:%@ 取缓存:%@", key, heightValue);
        return height(heightValue);
    }
    UIView *tempView = [self bm_tempViewCellWithCellClass:clas];
    CGFloat height = [self bm_layoutIfNeededCellWith:tempView.subviews[0] configuration:configuration];
    (isPortrait ? self.portraitCacheKeyCellHeightMutableDictionary :  self.landscapeCacheKeyCellHeightMutableDictionary)[key] = @(height);
    return height;
}

- (NSMutableDictionary *)portraitCacheCellHeightMutableDictionary {
    NSMutableDictionary *portraitCacheCellHeightMutableDictionary = objc_getAssociatedObject(self, _cmd);
    if (!portraitCacheCellHeightMutableDictionary) {
        portraitCacheCellHeightMutableDictionary = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, portraitCacheCellHeightMutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return portraitCacheCellHeightMutableDictionary;
}

- (NSMutableDictionary *)landscapeCacheCellHeightMutableDictionary {
    NSMutableDictionary *landscapeCacheCellHeightMutableDictionary = objc_getAssociatedObject(self, _cmd);
    if (!landscapeCacheCellHeightMutableDictionary) {
        landscapeCacheCellHeightMutableDictionary = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, landscapeCacheCellHeightMutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return landscapeCacheCellHeightMutableDictionary;
}

- (NSMutableDictionary *)reusableCellWithIdentifierMutableDictionary {
    NSMutableDictionary *reusableCellWithIdentifierMutableDictionary = objc_getAssociatedObject(self, _cmd);
    if (!reusableCellWithIdentifierMutableDictionary) {
        reusableCellWithIdentifierMutableDictionary = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, reusableCellWithIdentifierMutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return reusableCellWithIdentifierMutableDictionary;
}

- (NSMutableDictionary *)portraitCacheKeyCellHeightMutableDictionary {
    NSMutableDictionary *portraitCacheKeyCellHeightMutableDictionary = objc_getAssociatedObject(self, _cmd);
    if (!portraitCacheKeyCellHeightMutableDictionary) {
        portraitCacheKeyCellHeightMutableDictionary = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, portraitCacheKeyCellHeightMutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return portraitCacheKeyCellHeightMutableDictionary;
}

- (NSMutableDictionary *)landscapeCacheKeyCellHeightMutableDictionary {
    NSMutableDictionary *landscapeCacheKeyCellHeightMutableDictionary = objc_getAssociatedObject(self, _cmd);
    if (!landscapeCacheKeyCellHeightMutableDictionary) {
        landscapeCacheKeyCellHeightMutableDictionary = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, landscapeCacheKeyCellHeightMutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return landscapeCacheKeyCellHeightMutableDictionary;
}

- (void)bm_reloadData {
    [self.portraitCacheCellHeightMutableDictionary  removeAllObjects];
    [self.landscapeCacheCellHeightMutableDictionary removeAllObjects];
    [self bm_reloadData];
}

- (void)bm_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    // 待优化
    [self.portraitCacheCellHeightMutableDictionary  removeAllObjects];
    [self.landscapeCacheCellHeightMutableDictionary removeAllObjects];
    [self bm_insertSections:sections withRowAnimation:animation];
}

- (void)bm_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    // 待优化
    [self.portraitCacheCellHeightMutableDictionary  removeAllObjects];
    [self.landscapeCacheCellHeightMutableDictionary removeAllObjects];
    [self bm_deleteSections:sections withRowAnimation:animation];
}

- (void)bm_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    // 将需要刷新的的 section 的高度缓存清除
    [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger row = [self.dataSource tableView:self numberOfRowsInSection:idx];
        while (row--) {
            NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)idx, (long)row];
            [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
            [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
        }
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)idx]];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)idx]];
        
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)idx]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)idx]];
        
    }];
    [self bm_reloadSections:sections withRowAnimation:animation];
}

- (void)bm_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    // 待优化
    {
        NSInteger row = [self.dataSource tableView:self numberOfRowsInSection:section];
        while (row--) {
            NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)section, (long)row];
            [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
            [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
        }
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)section]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)section]];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)section]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)section]];
    }
    {
        NSInteger row = [self.dataSource tableView:self numberOfRowsInSection:newSection];
        while (row--) {
            NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)newSection, (long)row];
            [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
            [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
        }
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)newSection]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)newSection]];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)newSection]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)newSection]];
    }
    [self bm_moveSection:section toSection:newSection];
}

- (void)bm_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    // 待优化
    [self.portraitCacheCellHeightMutableDictionary  removeAllObjects];
    [self.landscapeCacheCellHeightMutableDictionary removeAllObjects];
    [self bm_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)bm_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    // 待优化
    [self.portraitCacheCellHeightMutableDictionary  removeAllObjects];
    [self.landscapeCacheCellHeightMutableDictionary removeAllObjects];
    [self bm_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)bm_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    // 将需要刷新的 indexPath 的高度缓存清除
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)obj.section, (long)obj.row];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
        [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
    }];
    [self bm_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)bm_moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // 待优化
    {
        NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)sourceIndexPath.section, (long)sourceIndexPath.row];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
        [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
    }
    {
        NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)destinationIndexPath.section, (long)destinationIndexPath.row];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
        [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
    }
    [self bm_moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

@end

@implementation UITableView (BMTemplateLayoutHeaderFooterView)

- (CGFloat)bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:(Class)clas configuration:(BMLayoutHeaderFooterViewConfigurationBlock)configuration {
    // 没有缓存创建临时View来布局获取高度
    UIView *tempView = [self bm_tempViewHeaderFooterViewWithHeaderFooterViewClass:clas];
    // 布局获取高度
    return [self bm_layoutIfNeededHeaderFooterViewWith:tempView.subviews[0] configuration:configuration];
}

- (CGFloat)bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:(Class)clas isHeaderView:(BOOL)isHeaderView section:(NSInteger)section configuration:(BMLayoutHeaderFooterViewConfigurationBlock)configuration {
    NSString *key = [NSString stringWithFormat:@"%@:%ld", isHeaderView ? @"Header" : @ "Footer" ,(long)section];
    NSNumber *heightValue = (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[key];
    // 有缓存就直接返回
    if (heightValue) {
        BMTemplateLayoutCellLog(@"组头部%ld已缓存了 取缓存:%@", (long)section, heightValue);
        return height(heightValue);
    }
    // 没有缓存创建临时View来布局获取高度
    UIView *tempView = [self bm_tempViewHeaderFooterViewWithHeaderFooterViewClass:clas];
    
    // 布局获取高度
    CGFloat height = [self bm_layoutIfNeededHeaderFooterViewWith:tempView.subviews[0] configuration:configuration];
    
    // 缓存起来
    (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[key] = @(height);
    BMTemplateLayoutCellLog(@"组头部%ld没有缓存 布局获取到的高度是:%f", (long)section, height);
    return height;
}

- (CGFloat)bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:(Class)clas cacheByKey:(NSString *)key configuration:(BMLayoutHeaderFooterViewConfigurationBlock)configuration {
    if (!clas || !configuration) {
        return 0.0f;
    }
    if (!key || key.length == 0.0f) {
        return [self bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:clas configuration:configuration];
    }
    
    NSNumber *heightValue = ((isPortrait) ? self.portraitCacheKeyCellHeightMutableDictionary :  self.landscapeCacheKeyCellHeightMutableDictionary)[key];
    // 有缓存就直接返回
    if (heightValue) {
        return height(heightValue);
    }
    // 没有缓存创建临时View来布局获取高度
    UIView *tempView = [self bm_tempViewHeaderFooterViewWithHeaderFooterViewClass:clas];
    
    // 布局获取高度
    CGFloat height = [self bm_layoutIfNeededHeaderFooterViewWith:tempView.subviews[0] configuration:configuration];
    
    // 缓存起来
    (isPortrait ? self.portraitCacheKeyCellHeightMutableDictionary :  self.landscapeCacheKeyCellHeightMutableDictionary)[key] = @(height);
    return height;
}

- (UIView *)bm_tempViewHeaderFooterViewWithHeaderFooterViewClass:(Class)clas {
    NSString *noReuseIdentifier = [NSString stringWithFormat:@"noReuse%@", NSStringFromClass(clas.class)];
    NSString *noReuseIdentifierChar = self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier];
    if (!noReuseIdentifierChar) {
        noReuseIdentifierChar = noReuseIdentifier;
        self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier] = noReuseIdentifier;
    }
    UIView *tempView = objc_getAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar));
    if (!tempView) {
        // 没有绑定就创建
        UITableViewHeaderFooterView *noCachetableViewHeaderFooterView = [[clas alloc] initWithReuseIdentifier:noReuseIdentifier];
        // 绑定起来
        tempView = [UIView new];
        [tempView addSubview:noCachetableViewHeaderFooterView];
        objc_setAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar), tempView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        BMTemplateLayoutCellLog(@"第一次创建 %@ 的布局对象 HeaderFooterView：%@", clas, noCachetableViewHeaderFooterView);
    }
    return tempView;
}

- (CGFloat)bm_layoutIfNeededHeaderFooterViewWith:(UITableViewHeaderFooterView *)tableViewHeaderFooterView configuration:(BMLayoutHeaderFooterViewConfigurationBlock)configuration {
    tableViewHeaderFooterView.superview.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.0f);
    tableViewHeaderFooterView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.0f);
    configuration(tableViewHeaderFooterView);
    [tableViewHeaderFooterView.superview layoutIfNeeded];
    __block CGFloat maxY = 0.0f;
    [tableViewHeaderFooterView.contentView.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (maxY <  CGRectGetMaxY(obj.frame)) {
            maxY = CGRectGetMaxY(obj.frame);
        }
    }];
    return maxY;
}

@end
