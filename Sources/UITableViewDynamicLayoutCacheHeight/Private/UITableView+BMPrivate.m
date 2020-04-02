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

#define KIS_VERTICAL (UIScreen.mainScreen.bounds.size.height > UIScreen.mainScreen.bounds.size.width)

@implementation UITableView (BMPrivate)

#pragma mark - header property

- (NSMutableDictionary<id<NSCopying>, NSNumber *> *)headerHeightDictionary {
    return KIS_VERTICAL ? self.headerVerticalDictionary : self.headerHorizontalDictionary;
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
    return KIS_VERTICAL ? self.headerVerticalArray : self.headerHorizontalArray;
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
    return KIS_VERTICAL ? self.verticalDictionary : self.horizontalDictionary;
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
    return KIS_VERTICAL ? self.verticalArray : self.horizontalArray;
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
    return KIS_VERTICAL ? self.footerVerticalDictionary : self.footerHorizontalDictionary;
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
    return KIS_VERTICAL ? self.footerVerticalArray : self.footerHorizontalArray;
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

- (void)_clearCache {
    // 1、清空 cell 的以 IndexPath 为标识的高度缓存
       NSInteger sections = 1;
       if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
           sections = [self.dataSource numberOfSectionsInTableView:self];
       }
       NSInteger tempSections = 0;
       NSMutableArray *arr1 = @[].mutableCopy;
       while (tempSections < sections) {
           NSInteger row = [self.dataSource tableView:self numberOfRowsInSection:tempSections];
           NSMutableArray *arr = @[].mutableCopy;
           while (row-- > 0) {
               [arr addObject:@-1];
           }
           [arr1 addObject:arr];
           tempSections++;
       }
       // 1-1、、竖屏状态下的 cell 高度缓存
       [self.verticalArray removeAllObjects];
       [self.verticalArray addObjectsFromArray:arr1];

       // 1-2、横屏状态下的 cell 高度缓存
       [self.horizontalArray removeAllObjects];
       [self.horizontalArray addObjectsFromArray:arr1];

       // 2、初始化 HeaderFooterView 的以 sections 为标识的高度缓存 Array
       NSMutableArray *arr2 = @[].mutableCopy;
       while (sections-- > 0) {
           [arr2 addObject:@-1];
       }
       // 2、清空 HeaderFooterView 的以 sections 为标识的高度缓存
       // 2-1、竖屏状态下的 HeaderView 高度缓存
       // 2-2、横屏状态下的 HeaderView 高度缓存
       // 2-3、竖屏状态下的 FooterView 高度缓存
       // 2-4、横屏状态下的 FooterView 高度缓存
       [@[self.headerVerticalArray,
          self.headerHorizontalArray,
          self.footerVerticalArray,
          self.footerHorizontalArray] enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           [obj removeAllObjects];
           [obj addObjectsFromArray:arr2];
       }];
}

- (void)tableView_dynamicLayout_reloadData {
    [self _clearCache];
    [self tableView_dynamicLayout_reloadData];
}

- (void)tableView_dynamicLayout_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
//    [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
//        // 1、cell array insertObject
//        // 插入数据
//        // 初始化 size 数据
//        NSInteger rowCount = [self.dataSource tableView:self numberOfRowsInSection:section];
//        NSMutableArray *arr = @[].mutableCopy;
//        while (rowCount-- > 0) {
//            [arr addObject:@-1];
//        }
//        [self.verticalArray insertObject:arr.mutableCopy atIndex:section];
//        [self.horizontalArray insertObject:arr.mutableCopy atIndex:section];
//
//        // 2、header footer array insertObject
//        [@[self.headerVerticalArray,
//           self.headerHorizontalArray,
//           self.footerVerticalArray,
//           self.footerHorizontalArray] enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj insertObject:@(-1) atIndex:section];
//        }];
//    }];
    [self _clearCache];
    [self tableView_dynamicLayout_insertSections:sections withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
//    [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
//        [@[self.verticalArray,
//           self.horizontalArray,
//           self.headerVerticalArray,
//           self.headerHorizontalArray,
//           self.footerVerticalArray,
//           self.footerHorizontalArray] enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [obj removeObjectAtIndex:section];
//        }];
//    }];
    [self _clearCache];
    [self tableView_dynamicLayout_deleteSections:sections withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
        [@[self.verticalArray[section],
           self.horizontalArray[section]] enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                obj1 = @(-1);
            }];
        }];
    }];

    [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
        [@[self.headerVerticalArray,
           self.headerHorizontalArray,
           self.footerVerticalArray,
           self.footerHorizontalArray] enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj[section] = @(-1);
        }];
    }];
    [self tableView_dynamicLayout_reloadSections:sections withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    [@[self.verticalArray,
       self.horizontalArray,
       self.headerVerticalArray,
       self.headerHorizontalArray,
       self.footerVerticalArray,
       self.footerHorizontalArray] enumerateObjectsUsingBlock:^(NSMutableArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id temp = obj[section];
        [obj removeObjectAtIndex:section];
        [obj insertObject:temp atIndex:newSection];
    }];
    [self tableView_dynamicLayout_moveSection:section toSection:newSection];
}

- (void)tableView_dynamicLayout_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
//    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx1, BOOL * _Nonnull stop1) {
//
//        NSMutableArray <NSMutableArray <NSNumber *> *> *arr = self.verticalArray;
//        long i = (obj.section + 1 - arr.count);
//        while (i-- > 0) {
//            [self.verticalArray addObject:@[].mutableCopy];
//        }
//        [self.verticalArray[obj.section] insertObject:@(-1) atIndex:obj.row];
//
//        NSMutableArray <NSMutableArray <NSNumber *> *> *arr1 = self.horizontalArray;
//        long i1 = (obj.section + 1 - arr1.count);
//        while (i1-- > 0) {
//            [self.horizontalArray addObject:@[].mutableCopy];
//        }
//        [self.horizontalArray[obj.section] insertObject:@(-1) atIndex:obj.row];
//
//    }];
    [self _clearCache];
    [self tableView_dynamicLayout_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
//    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.verticalArray[obj.section] removeObjectAtIndex:obj.row];
//        [self.horizontalArray[obj.section] removeObjectAtIndex:obj.row];
//    }];
    [self _clearCache];
    [self tableView_dynamicLayout_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        self.verticalArray[obj.section][obj.row] = @(-1);
        self.horizontalArray[obj.section][obj.row] = @(-1);
    }];
    [self tableView_dynamicLayout_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    if (indexPath.section == newIndexPath.section) {
        NSInteger sec = indexPath.section;
        id obj = self.verticalArray[sec][indexPath.row];
        [self.verticalArray[sec] removeObjectAtIndex:indexPath.row];
        [self.verticalArray[sec] insertObject:obj atIndex:newIndexPath.row];
        
        id obj1 = self.horizontalArray[sec][indexPath.row];
        [self.horizontalArray[sec] removeObjectAtIndex:indexPath.row];
        [self.horizontalArray[sec] insertObject:obj1 atIndex:newIndexPath.row];
        
    } else {
        id obj = self.verticalArray[indexPath.section][indexPath.row];
        [self.verticalArray[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.verticalArray[newIndexPath.section] insertObject:obj atIndex:newIndexPath.row];
        
        id obj1 = self.horizontalArray[indexPath.section][indexPath.row];
        [self.horizontalArray[indexPath.section] removeObjectAtIndex:indexPath.row];
        [self.horizontalArray[newIndexPath.section] insertObject:obj1 atIndex:newIndexPath.row];
    }
    [self tableView_dynamicLayout_moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
}

@end
