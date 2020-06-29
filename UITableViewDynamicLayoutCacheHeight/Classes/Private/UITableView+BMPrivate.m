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

#import "UITableView+BMPrivate.h"
#import <objc/runtime.h>
#import "UITableViewDynamicLayoutCacheHeight.h"

#define kIS_VERTICAL (UIScreen.mainScreen.bounds.size.height > UIScreen.mainScreen.bounds.size.width)
#define kDefaultHeight @(-1.0)

#ifdef DEBUG
    #define kChangedCacheLog [self _changedCacheLog];
#else
    #define kChangedCacheLog
#endif


@interface UITableView (__BMPrivate__)

@property (nonatomic, strong, readonly) NSMutableDictionary <id<NSCopying>, NSNumber *> *headerVerticalDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary <id<NSCopying>, NSNumber *> *headerHorizontalDictionary;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *headerVerticalArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *headerHorizontalArray;

@property (nonatomic, strong, readonly) NSMutableDictionary <id<NSCopying>, NSNumber *> *verticalDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary <id<NSCopying>, NSNumber *> *horizontalDictionary;
@property (nonatomic, strong, readonly) NSMutableArray <NSMutableArray <NSNumber *> *> *verticalArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSMutableArray <NSNumber *> *> *horizontalArray;

@property (nonatomic, strong, readonly) NSMutableDictionary <id<NSCopying>, NSNumber *> *footerVerticalDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary <id<NSCopying>, NSNumber *> *footerHorizontalDictionary;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *footerVerticalArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *footerHorizontalArray;

@end

@implementation UITableView (BMPrivate)

#pragma mark - header property

- (NSMutableDictionary<id<NSCopying>, NSNumber *> *)headerHeightDictionary {
    return kIS_VERTICAL ? self.headerVerticalDictionary : self.headerHorizontalDictionary;
}

- (NSMutableDictionary<id<NSCopying>, NSNumber *> *)headerVerticalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((dict == nil), 0)) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableDictionary<id<NSCopying>, NSNumber *> *)headerHorizontalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((dict == nil), 0)) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableArray<NSNumber *> *)headerHeightArray {
    return kIS_VERTICAL ? self.headerVerticalArray : self.headerHorizontalArray;
}

- (NSMutableArray<NSNumber *> *)headerVerticalArray {
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((arr == nil), 0)) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

- (NSMutableArray<NSNumber *> *)headerHorizontalArray {
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((arr == nil), 0)) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

#pragma mark - cell property

- (NSMutableDictionary<id<NSCopying>, NSNumber *> *)heightDictionary {
    return kIS_VERTICAL ? self.verticalDictionary : self.horizontalDictionary;
}

- (NSMutableDictionary<id<NSCopying>, NSNumber *> *)verticalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((dict == nil), 0)) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableDictionary<id<NSCopying>, NSNumber *> *)horizontalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((dict == nil), 0)) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableArray<NSMutableArray<NSNumber *> *> *)heightArray {
    return kIS_VERTICAL ? self.verticalArray : self.horizontalArray;
}

- (NSMutableArray<NSMutableArray<NSNumber *> *> *)verticalArray {
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((arr == nil), 0)) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

- (NSMutableArray<NSMutableArray <NSNumber *> *> *)horizontalArray {
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((arr == nil), 0)) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

#pragma mark - footer property

- (NSMutableDictionary<id<NSCopying>, NSNumber *> *)footerHeightDictionary {
    return kIS_VERTICAL ? self.footerVerticalDictionary : self.footerHorizontalDictionary;
}

- (NSMutableDictionary<id<NSCopying>, NSNumber *> *)footerVerticalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((dict == nil), 0)) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableDictionary<id<NSCopying>, NSNumber *> *)footerHorizontalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((dict == nil), 0)) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableArray<NSNumber *> *)footerHeightArray {
    return kIS_VERTICAL ? self.footerVerticalArray : self.footerHorizontalArray;
}

- (NSMutableArray<NSNumber *> *)footerVerticalArray {
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((arr == nil), 0)) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

- (NSMutableArray<NSNumber *> *)footerHorizontalArray {
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((arr == nil), 0)) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

- (BOOL)isDynamicLayoutInitializationed {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)bm_dynamicLayoutInitialization {
    [self _initCacheArrayWithDataSource:self.dataSource];
    objc_setAssociatedObject(self, @selector(isDynamicLayoutInitializationed), @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - load

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
            SEL swizzledSelector = NSSelectorFromString([@"tableView_dynamicLayout_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            Method originalMethod = class_getInstanceMethod(self, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)tableView_dynamicLayout_reloadData {
    // reloadData 时，清空缓存数据。
    if (self.isDynamicLayoutInitializationed) {
        [self _initCacheArrayWithDataSource:self.dataSource];
    }
    [self tableView_dynamicLayout_reloadData];
}

- (void)tableView_dynamicLayout_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isDynamicLayoutInitializationed) {
        // 清空缓存数据，这里可以优化，由于需要考虑太多的情况，暂时没有提供全面的测试方法，暂时直接全部刷新。
        [self _initCacheArrayWithDataSource:self.dataSource];
        kChangedCacheLog
    }
    [self tableView_dynamicLayout_insertSections:sections withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isDynamicLayoutInitializationed) {
        [sections enumerateIndexesWithOptions:(NSEnumerationReverse) usingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            // cell
            [self.verticalArray         removeObjectAtIndex:section];
            [self.horizontalArray       removeObjectAtIndex:section];
            // header footer
            [self.headerVerticalArray   removeObjectAtIndex:section];
            [self.headerHorizontalArray removeObjectAtIndex:section];
            [self.footerVerticalArray   removeObjectAtIndex:section];
            [self.footerHorizontalArray removeObjectAtIndex:section];
        }];
        kChangedCacheLog
    }
    [self tableView_dynamicLayout_deleteSections:sections withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isDynamicLayoutInitializationed) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            // 组的数据可能改变 需要重新获取组的行数
            NSInteger sectionCount = [self.dataSource tableView:self numberOfRowsInSection:section];
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:sectionCount];
            while (sectionCount-- > 0) {
                [arr addObject:kDefaultHeight];
            }
            self.verticalArray[section]   = arr.mutableCopy;
            self.horizontalArray[section] = arr.mutableCopy;

            // header footer
            self.headerVerticalArray[section]   = kDefaultHeight;
            self.headerHorizontalArray[section] = kDefaultHeight;
            self.footerVerticalArray[section]   = kDefaultHeight;
            self.footerHorizontalArray[section] = kDefaultHeight;
        }];
        kChangedCacheLog
    }
    [self tableView_dynamicLayout_reloadSections:sections withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    if (self.isDynamicLayoutInitializationed) {
        // 清空缓存数据，这里可以优化，由于需要考虑太多的情况，暂时没有提供全面的测试方法，暂时直接全部刷新。
        [self _initCacheArrayWithDataSource:self.dataSource];
        kChangedCacheLog
    }
    [self tableView_dynamicLayout_moveSection:section toSection:newSection];
}

- (void)tableView_dynamicLayout_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isDynamicLayoutInitializationed) {
        // 清空缓存数据，这里可以优化，由于需要考虑太多的情况，暂时没有提供全面的测试方法，暂时直接全部刷新。
        [self _initCacheArrayWithDataSource:self.dataSource];
        kChangedCacheLog
    }
    [self tableView_dynamicLayout_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isDynamicLayoutInitializationed) {
        NSMutableArray *tempIndexPaths = indexPaths.mutableCopy;
        [tempIndexPaths sortUsingComparator:^NSComparisonResult(NSIndexPath *  _Nonnull obj1, NSIndexPath *  _Nonnull obj2) {
            if (obj1.section == obj2.section) {
                return obj1.row < obj2.row;
            }
            return obj1.section < obj2.section;
        }];
        [tempIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.verticalArray[obj.section]   removeObjectAtIndex:obj.row];
            [self.horizontalArray[obj.section] removeObjectAtIndex:obj.row];
        }];
        kChangedCacheLog
    }
    [self tableView_dynamicLayout_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isDynamicLayoutInitializationed) {
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            self.verticalArray[obj.section][obj.row]   = kDefaultHeight;
            self.horizontalArray[obj.section][obj.row] = kDefaultHeight;
        }];
        kChangedCacheLog
    }
    [self tableView_dynamicLayout_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    if (self.isDynamicLayoutInitializationed) {
        // 清空缓存数据，这里可以优化，由于需要考虑太多的情况，暂时没有提供全面的测试方法，暂时直接全部刷新。
        [self _initCacheArrayWithDataSource:self.dataSource];
        kChangedCacheLog
    }
    [self tableView_dynamicLayout_moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
}

#pragma mark - Private Method

- (void)_initCacheArrayWithDataSource:(id<UITableViewDataSource>)dataSource {
    if (!dataSource) {
        return;
    }
    BM_UITableView_DynamicLayout_LOG(@"初始化缓存");
    // 1、清空 cell 的以 IndexPath 为标识的高度缓存
    NSInteger sections = 1;
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self];
    }

    // 1-1、竖屏状态下的 cell 高度缓存
    // 1-2、横屏状态下的 cell 高度缓存
    NSInteger tempSections = 0;
    NSMutableArray *verticalArray   = [NSMutableArray arrayWithCapacity:sections];
    NSMutableArray *horizontalArray = [NSMutableArray arrayWithCapacity:sections];
    while (tempSections < sections) {
        NSInteger rowCount = [dataSource tableView:self numberOfRowsInSection:tempSections];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:rowCount];
        while (rowCount-- > 0) {
            [arr addObject:kDefaultHeight];
        }
        [verticalArray addObject:arr];
        [horizontalArray addObject:arr.mutableCopy];
        tempSections++;
    }
    [self.verticalArray removeAllObjects];
    [self.verticalArray addObjectsFromArray:verticalArray.copy];

    [self.horizontalArray removeAllObjects];
    [self.horizontalArray addObjectsFromArray:horizontalArray.copy];
    [self _initHeaderFooterCacheArrayWithSections:sections];
    kChangedCacheLog
}

- (void)_initHeaderFooterCacheArrayWithSections:(NSInteger)sections {
    // 2-1、竖屏状态下的 HeaderView 高度缓存
    // 2-2、横屏状态下的 HeaderView 高度缓存
    // 2-3、竖屏状态下的 FooterView 高度缓存
    // 2-4、横屏状态下的 FooterView 高度缓存
    [self.headerVerticalArray   removeAllObjects];
    [self.headerHorizontalArray removeAllObjects];
    [self.footerVerticalArray   removeAllObjects];
    [self.footerHorizontalArray removeAllObjects];
    NSInteger temp = 0;
    while (temp++ < sections) {
        [self.headerVerticalArray   addObject:kDefaultHeight];
        [self.headerHorizontalArray addObject:kDefaultHeight];
        [self.footerVerticalArray   addObject:kDefaultHeight];
        [self.footerHorizontalArray addObject:kDefaultHeight];
    }
}

- (void)_changedCacheLog {
#ifdef DEBUG
    if (UITableViewDynamicLayoutCacheHeight.isOpenDebugLog) {
        [self.verticalArray enumerateObjectsUsingBlock:^(NSMutableArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BM_UITableView_DynamicLayout_LOG(@"修改了数据时: 初始化后 cell 竖屏：%@", @(obj.count));
        }];
        [self.horizontalArray enumerateObjectsUsingBlock:^(NSMutableArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BM_UITableView_DynamicLayout_LOG(@"修改了数据时: 初始化后 cell 横屏：%@", @(obj.count));
        }];
        BM_UITableView_DynamicLayout_LOG(@"修改了数据时: 初始化后 header 竖屏：%@", @(self.headerVerticalArray.count));
        BM_UITableView_DynamicLayout_LOG(@"修改了数据时: 初始化后 header 横屏：%@", @(self.headerHorizontalArray.count));
        BM_UITableView_DynamicLayout_LOG(@"修改了数据时: 初始化后 footer 竖屏：%@", @(self.footerVerticalArray.count));
        BM_UITableView_DynamicLayout_LOG(@"修改了数据时: 初始化后 footer 横屏：%@", @(self.footerHorizontalArray.count));
    }
#endif
}

@end

