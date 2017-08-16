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

/**
 交换2个方法的调用

 @param class class
 @param originalSelector originalSelector
 @param swizzledSelector swizzledSelector
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

@interface UITableView ()

@property (strong, nonatomic, readonly) NSMutableDictionary *portraitCacheCellHeightMutableDictionary; ///< portraitCacheCellHeightMutableDictionary
@property (strong, nonatomic, readonly) NSMutableDictionary *landscapeCacheCellHeightMutableDictionary; ///< landscapeCacheCellHeightMutableDictionary
@property (strong, nonatomic, readonly) NSMutableDictionary *reusableCellWithIdentifierMutableDictionary; ///< reusableCellWithIdentifierMutableDictionary

@end

@implementation UITableView (BMTemplateLayoutCell)

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas configuration:(BMLayoutCellConfigurationBlock)configuration {
    // 创建新的重用标识
    NSString *noReuseIdentifier = [NSString stringWithFormat:@"noReuse%@", NSStringFromClass(clas.class)];
    
    NSString *noReuseIdentifierChar = self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier];
    if (!noReuseIdentifierChar) {
        noReuseIdentifierChar = noReuseIdentifier;
        self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier] = noReuseIdentifier;
    }
    // 取特定的重用标识是否绑定的Cell
    UITableViewCell *noCacheCell = objc_getAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar));
    
    if (!noCacheCell) {
        // 没有绑定就创建
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clas.class) ofType:@"nib"];
        if (path.length) {
            noCacheCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas.class) owner:nil options:nil] firstObject];
            [noCacheCell setValue:noReuseIdentifier forKey:@"reuseIdentifier"];
        } else {
            noCacheCell = [[clas alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noReuseIdentifier];
        }
        // 绑定起来
        objc_setAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar), noCacheCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        NSLog(@"创建cell 这个 cell 不参与重用 ---- %p", noCacheCell);
    }
    
    // 不存在就布局一下，在获取高度进行缓存
    UIView *tempView = [UIView new];
    tempView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
    [tempView addSubview:noCacheCell];
    noCacheCell.frame = CGRectMake(0, 0, self.frame.size.width, 100);
    configuration(noCacheCell);
    [tempView layoutIfNeeded];
    
    __block CGFloat maxY = 0;
    [noCacheCell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (maxY <  CGRectGetMaxY(obj.frame)) {
            maxY = CGRectGetMaxY(obj.frame);
        }
    }];
    maxY += .5;
    return maxY;
}

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                        cacheByIndexPath:(NSIndexPath *)indexPath
                           configuration:(BMLayoutCellConfigurationBlock)configuration {
    // 创建新的重用标识
    NSString *noReuseIdentifier = [NSString stringWithFormat:@"noReuse%@", NSStringFromClass(clas.class)];
    
    NSString *noReuseIdentifierChar = self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier];
    if (!noReuseIdentifierChar) {
        noReuseIdentifierChar = noReuseIdentifier;
        self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier] = noReuseIdentifier;
    }
    // 取特定的重用标识是否绑定的Cell
    UITableViewCell *noCacheCell = objc_getAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar));
    
    if (!noCacheCell) {
        // 没有绑定就创建
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clas.class) ofType:@"nib"];
        if (path.length) {
            noCacheCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas.class) owner:nil options:nil] firstObject];
            [noCacheCell setValue:noReuseIdentifier forKey:@"reuseIdentifier"];
        } else {
            noCacheCell = [[clas alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noReuseIdentifier];
        }
        // 绑定起来
        objc_setAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar), noCacheCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        NSLog(@"创建cell 这个 cell 不参与重用 ---- %p", noCacheCell);
    }
    // 参加缓存 key (待优化)
    NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    
    BOOL isPortrait = (CGRectGetWidth([[UIScreen mainScreen] bounds]) < CGRectGetHeight([[UIScreen mainScreen] bounds]));
    NSNumber *heightValue = (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[cacheID];
    if (!heightValue) {
        // 不存在就布局一下，在获取高度进行缓存
        UIView *tempView = [UIView new];
        tempView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        [tempView addSubview:noCacheCell];
        noCacheCell.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        configuration(noCacheCell);
        [tempView layoutIfNeeded];
        
        __block CGFloat maxY = 0;
        [noCacheCell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (maxY <  CGRectGetMaxY(obj.frame)) {
                maxY = CGRectGetMaxY(obj.frame);
            }
        }];
        maxY += .5;
        (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[cacheID] = @(maxY);
        NSLog(@"%d isPortrait:%@ first calculate height  height: %f", isPortrait, indexPath, maxY);
        return maxY;
    }
    return [heightValue doubleValue];
}

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas cacheByKey:(NSString *)key configuration:(BMLayoutCellConfigurationBlock)configuration {
    // 创建新的重用标识
    NSString *noReuseIdentifier = [NSString stringWithFormat:@"noReuse%@", NSStringFromClass(clas.class)];
    
    NSString *noReuseIdentifierChar = self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier];
    if (!noReuseIdentifierChar) {
        noReuseIdentifierChar = noReuseIdentifier;
        self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier] = noReuseIdentifier;
    }
    // 取特定的重用标识是否绑定的Cell
    UITableViewCell *noCacheCell = objc_getAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar));
    
    if (!noCacheCell) {
        // 没有绑定就创建
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clas.class) ofType:@"nib"];
        if (path.length) {
            noCacheCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas.class) owner:nil options:nil] firstObject];
            [noCacheCell setValue:noReuseIdentifier forKey:@"reuseIdentifier"];
        } else {
            noCacheCell = [[clas alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noReuseIdentifier];
        }
        // 绑定起来
        objc_setAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar), noCacheCell, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        NSLog(@"创建cell 这个 cell 不参与重用 ---- %p", noCacheCell);
    }
    // 参加缓存 key (待优化)
    NSString *cacheID = key;
    BOOL isPortrait = (CGRectGetWidth([[UIScreen mainScreen] bounds]) < CGRectGetHeight([[UIScreen mainScreen] bounds]));
    NSNumber *heightValue = (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[cacheID];
    if (!heightValue) {
        // 不存在就布局一下，在获取高度进行缓存
        UIView *tempView = [UIView new];
        tempView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        [tempView addSubview:noCacheCell];
        noCacheCell.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        configuration(noCacheCell);
        [tempView layoutIfNeeded];
        
        __block CGFloat maxY = 0;
        [noCacheCell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (maxY <  CGRectGetMaxY(obj.frame)) {
                maxY = CGRectGetMaxY(obj.frame);
            }
        }];
        maxY += .5;
        (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[cacheID] = @(maxY);
        return maxY;
    }
    return [heightValue doubleValue];
}

- (NSMutableDictionary *)portraitCacheCellHeightMutableDictionary {
    // landscape 创建存储缓存高度的字典
    NSMutableDictionary *portraitCacheCellHeightMutableDictionary = objc_getAssociatedObject(self, _cmd);
    if (!portraitCacheCellHeightMutableDictionary) {
        portraitCacheCellHeightMutableDictionary = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, portraitCacheCellHeightMutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return portraitCacheCellHeightMutableDictionary;
}

- (NSMutableDictionary *)landscapeCacheCellHeightMutableDictionary {
    // vertical 创建存储缓存高度的字典
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
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", idx]];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", idx]];
        
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", idx]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", idx]];
        
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
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", section]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", section]];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", section]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", section]];
    }
    {
        NSInteger row = [self.dataSource tableView:self numberOfRowsInSection:newSection];
        while (row--) {
            NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)newSection, (long)row];
            [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
            [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
        }
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", newSection]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", newSection]];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", newSection]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", newSection]];
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
    
    // 创建新的重用标识
    NSString *noReuseIdentifier = [NSString stringWithFormat:@"noReuse%@", NSStringFromClass(clas.class)];
    
    NSString *noReuseIdentifierChar = self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier];
    if (!noReuseIdentifierChar) {
        noReuseIdentifierChar = noReuseIdentifier;
        self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier] = noReuseIdentifier;
    }
    // 取特定的重用标识是否绑定的Cell
    UITableViewHeaderFooterView *noCachetableViewHeaderFooterView = objc_getAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar));
    
    if (!noCachetableViewHeaderFooterView) {
        // 没有绑定就创建
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clas.class) ofType:@"nib"];
        if (path.length) {
            noCachetableViewHeaderFooterView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas.class) owner:nil options:nil] firstObject];
            [noCachetableViewHeaderFooterView setValue:noReuseIdentifier forKey:@"reuseIdentifier"];
        } else {
            noCachetableViewHeaderFooterView = [[clas alloc] initWithReuseIdentifier:noReuseIdentifier];
        }
        // 绑定起来
        objc_setAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar), noCachetableViewHeaderFooterView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        NSLog(@"创建cell 这个 noCachetableViewHeaderFooterView 不参与重用 ---- %p", noCachetableViewHeaderFooterView);
    }
    
    // 不存在就布局一下，在获取高度进行缓存
    UIView *tempView = [UIView new];
    tempView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
    [tempView addSubview:noCachetableViewHeaderFooterView];
    noCachetableViewHeaderFooterView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
    configuration(noCachetableViewHeaderFooterView);
    [tempView layoutIfNeeded];
    
    __block CGFloat maxY = 0;
    [noCachetableViewHeaderFooterView.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (maxY <  CGRectGetMaxY(obj.frame)) {
            maxY = CGRectGetMaxY(obj.frame);
        }
    }];
    return maxY;
}

- (CGFloat)bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:(Class)clas isHeaderView:(BOOL)isHeaderView section:(NSInteger)section configuration:(BMLayoutHeaderFooterViewConfigurationBlock)configuration {
    // 创建新的重用标识
    NSString *noReuseIdentifier = [NSString stringWithFormat:@"noReuse%@", NSStringFromClass(clas.class)];
    
    NSString *noReuseIdentifierChar = self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier];
    if (!noReuseIdentifierChar) {
        noReuseIdentifierChar = noReuseIdentifier;
        self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier] = noReuseIdentifier;
    }
    // 取特定的重用标识是否绑定的Cell
    UITableViewHeaderFooterView *noCachetableViewHeaderFooterView = objc_getAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar));
    
    if (!noCachetableViewHeaderFooterView) {
        // 没有绑定就创建
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clas.class) ofType:@"nib"];
        if (path.length) {
            noCachetableViewHeaderFooterView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas.class) owner:nil options:nil] firstObject];
            [noCachetableViewHeaderFooterView setValue:noReuseIdentifier forKey:@"reuseIdentifier"];
        } else {
            noCachetableViewHeaderFooterView = [[clas alloc] initWithReuseIdentifier:noReuseIdentifier];
        }
        // 绑定起来
        objc_setAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar), noCachetableViewHeaderFooterView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        NSLog(@"创建cell 这个 noCachetableViewHeaderFooterView 不参与重用 ---- %p", noCachetableViewHeaderFooterView);
    }
    // 参加缓存 key (待优化)
    NSString *cacheID = [NSString stringWithFormat:@"%@:%ld", isHeaderView ? @"Header" : @ "Footer" ,section];
    BOOL isPortrait = (CGRectGetWidth([[UIScreen mainScreen] bounds]) < CGRectGetHeight([[UIScreen mainScreen] bounds]));
    NSNumber *heightValue = (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[cacheID];
    if (!heightValue) {
        // 不存在就布局一下，在获取高度进行缓存
        UIView *tempView = [UIView new];
        tempView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        [tempView addSubview:noCachetableViewHeaderFooterView];
        noCachetableViewHeaderFooterView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        configuration(noCachetableViewHeaderFooterView);
        [tempView layoutIfNeeded];
        
        __block CGFloat maxY = 0;
        [noCachetableViewHeaderFooterView.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (maxY <  CGRectGetMaxY(obj.frame)) {
                maxY = CGRectGetMaxY(obj.frame);
            }
        }];
        (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[cacheID] = @(maxY);
        return maxY;
    }
    return [heightValue doubleValue];
}

- (CGFloat)bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:(Class)clas cacheByKey:(NSString *)key configuration:(BMLayoutHeaderFooterViewConfigurationBlock)configuration {
    // 创建新的重用标识
    NSString *noReuseIdentifier = [NSString stringWithFormat:@"noReuse%@", NSStringFromClass(clas.class)];
    
    NSString *noReuseIdentifierChar = self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier];
    if (!noReuseIdentifierChar) {
        noReuseIdentifierChar = noReuseIdentifier;
        self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier] = noReuseIdentifier;
    }
    // 取特定的重用标识是否绑定的Cell
    UITableViewHeaderFooterView *noCachetableViewHeaderFooterView = objc_getAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar));
    
    if (!noCachetableViewHeaderFooterView) {
        // 没有绑定就创建
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clas.class) ofType:@"nib"];
        if (path.length) {
            noCachetableViewHeaderFooterView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas.class) owner:nil options:nil] firstObject];
            [noCachetableViewHeaderFooterView setValue:noReuseIdentifier forKey:@"reuseIdentifier"];
        } else {
            noCachetableViewHeaderFooterView = [[clas alloc] initWithReuseIdentifier:noReuseIdentifier];
        }
        // 绑定起来
        objc_setAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar), noCachetableViewHeaderFooterView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        NSLog(@"创建cell 这个 noCachetableViewHeaderFooterView 不参与重用 ---- %p", noCachetableViewHeaderFooterView);
    }
    // 参加缓存 key (待优化)
    NSString *cacheID = [NSString stringWithFormat:@"HeaderFooter:%@", key];
    BOOL isPortrait = (CGRectGetWidth([[UIScreen mainScreen] bounds]) < CGRectGetHeight([[UIScreen mainScreen] bounds]));
    NSNumber *heightValue = (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[cacheID];
    if (!heightValue) {
        // 不存在就布局一下，在获取高度进行缓存
        UIView *tempView = [UIView new];
        tempView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        [tempView addSubview:noCachetableViewHeaderFooterView];
        noCachetableViewHeaderFooterView.frame = CGRectMake(0, 0, self.frame.size.width, 100);
        configuration(noCachetableViewHeaderFooterView);
        [tempView layoutIfNeeded];
        
        __block CGFloat maxY = 0;
        [noCachetableViewHeaderFooterView.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (maxY <  CGRectGetMaxY(obj.frame)) {
                maxY = CGRectGetMaxY(obj.frame);
            }
        }];
        (isPortrait ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[cacheID] = @(maxY);
        return maxY;
    }
    return [heightValue doubleValue];
}

@end
