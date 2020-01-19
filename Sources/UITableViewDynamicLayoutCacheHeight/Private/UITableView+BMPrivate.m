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

#import "UITableView+BMPrivate.h"
#import "UITableViewDynamicLayoutMacro.h"
#import <objc/runtime.h>

@implementation UITableView (BMPrivate)

#pragma mark - header property

- (BOOL)isSectionHeaderHeightCache {
    NSNumber *num = objc_getAssociatedObject(self, _cmd);
    return num.boolValue;
}

- (void)setIsSectionHeaderHeightCache:(BOOL)isSectionHeaderHeightCache {
    objc_setAssociatedObject(self, @selector(isSectionHeaderHeightCache), @(isSectionHeaderHeightCache), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSString *,NSNumber *> *)headerHeightDictionary {
    return KIS_VERTICAL ? self.headerVerticalDictionary : self.headerHorizontalDictionary;
}

- (NSMutableDictionary<NSString *,NSNumber *> *)headerVerticalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableDictionary<NSString *,NSNumber *> *)headerHorizontalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
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
    if (!arr) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

- (NSMutableArray<NSNumber *> *)headerHorizontalArray {
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (!arr) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

#pragma mark - cell property

- (BOOL)isIndexPathHeightCache {
    NSNumber *num = objc_getAssociatedObject(self, _cmd);
    return num.boolValue;
}

- (void)setIsIndexPathHeightCache:(BOOL)isIndexPathHeightCache {
    objc_setAssociatedObject(self, @selector(isIndexPathHeightCache), @(isIndexPathHeightCache), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSString *, NSNumber *> *)heightDictionary {
    return KIS_VERTICAL ? self.verticalDictionary : self.horizontalDictionary;
}

- (NSMutableDictionary<NSString *,NSNumber *> *)verticalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableDictionary<NSString *,NSNumber *> *)horizontalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
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
    if (!arr) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

- (NSMutableArray<NSMutableArray <NSNumber *> *> *)horizontalArray {
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (!arr) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

#pragma mark - footer property

- (BOOL)isSectionFooterHeightCache {
    NSNumber *num = objc_getAssociatedObject(self, _cmd);
    return num.boolValue;
}

- (void)setIsSectionFooterHeightCache:(BOOL)isSectionFooterHeightCache {
    objc_setAssociatedObject(self, @selector(isSectionFooterHeightCache), @(isSectionFooterHeightCache), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary<NSString *,NSNumber *> *)footerHeightDictionary {
    return KIS_VERTICAL ? self.footerVerticalDictionary : self.footerHorizontalDictionary;
}

- (NSMutableDictionary<NSString *,NSNumber *> *)footerVerticalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableDictionary<NSString *,NSNumber *> *)footerHorizontalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
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
    if (!arr) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

- (NSMutableArray<NSNumber *> *)footerHorizontalArray {
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (!arr) {
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

- (void)tableView_dynamicLayout_reloadData {
    if (self.isIndexPathHeightCache) {
        [self.verticalArray removeAllObjects];
        [self.horizontalArray removeAllObjects];
    }
    
    if (self.isSectionHeaderHeightCache) {
        [self.headerVerticalArray removeAllObjects];
        [self.headerHorizontalArray removeAllObjects];
    }
    
    if (self.isSectionFooterHeightCache) {
        [self.footerVerticalArray removeAllObjects];
        [self.footerHorizontalArray removeAllObjects];
    }

    [self tableView_dynamicLayout_reloadData];
}

- (void)tableView_dynamicLayout_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isIndexPathHeightCache) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            [self.verticalArray insertObject:@[].mutableCopy atIndex:section];
            [self.horizontalArray insertObject:@[].mutableCopy atIndex:section];
        }];
    }
    
    if (self.isSectionHeaderHeightCache) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            [self.headerVerticalArray insertObject:@(-1) atIndex:section];
            [self.headerHorizontalArray insertObject:@(-1) atIndex:section];
        }];
    }
    
    if (self.isSectionFooterHeightCache) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            [self.footerVerticalArray insertObject:@(-1) atIndex:section];
            [self.footerHorizontalArray insertObject:@(-1) atIndex:section];
        }];
    }

    [self tableView_dynamicLayout_insertSections:sections withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isIndexPathHeightCache) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            [self.verticalArray removeObjectAtIndex:section];
            [self.horizontalArray removeObjectAtIndex:section];
        }];
    }
    
    if (self.isSectionHeaderHeightCache) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            [self.headerVerticalArray removeObjectAtIndex:section];
            [self.headerHorizontalArray removeObjectAtIndex:section];
        }];
    }
    
    if (self.isSectionFooterHeightCache) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            [self.footerVerticalArray removeObjectAtIndex:section];
            [self.footerHorizontalArray removeObjectAtIndex:section];
        }];
    }
    [self tableView_dynamicLayout_deleteSections:sections withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isIndexPathHeightCache) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            [self.verticalArray[section] removeAllObjects];
            [self.horizontalArray[section] removeAllObjects];
        }];
    }
    
    if (self.isSectionHeaderHeightCache) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            self.headerVerticalArray[section] = @(-1);
            self.headerHorizontalArray[section] = @(-1);
        }];
    }
    
    if (self.isSectionFooterHeightCache) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            self.footerVerticalArray[section] = @(-1);
            self.footerHorizontalArray[section] = @(-1);
        }];
    }
    
    [self tableView_dynamicLayout_reloadSections:sections withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    if (self.isIndexPathHeightCache) {
        id obj = self.verticalArray[section];
        [self.verticalArray removeObjectAtIndex:section];
        [self.verticalArray insertObject:obj atIndex:newSection];
        
        id obj1 = self.horizontalArray[section];
        [self.horizontalArray removeObjectAtIndex:section];
        [self.horizontalArray insertObject:obj1 atIndex:newSection];
    }
    
    if (self.isSectionHeaderHeightCache) {
        id obj = self.headerVerticalArray[section];
        [self.headerVerticalArray removeObjectAtIndex:section];
        [self.headerVerticalArray insertObject:obj atIndex:newSection];

        id obj1 = self.headerHorizontalArray[section];
        [self.headerHorizontalArray removeObjectAtIndex:section];
        [self.headerHorizontalArray insertObject:obj1 atIndex:newSection];
    }

    if (self.isSectionFooterHeightCache) {
        id obj = self.footerVerticalArray[section];
        [self.footerVerticalArray removeObjectAtIndex:section];
        [self.footerVerticalArray insertObject:obj atIndex:newSection];
        
        id obj1 = self.footerHorizontalArray[section];
        [self.footerHorizontalArray removeObjectAtIndex:section];
        [self.footerHorizontalArray insertObject:obj1 atIndex:newSection];
    }
    
    [self tableView_dynamicLayout_moveSection:section toSection:newSection];
}

- (void)tableView_dynamicLayout_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isIndexPathHeightCache) {
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray <NSMutableArray <NSNumber *> *> *arr = self.verticalArray;
            long i = (obj.section + 1 - arr.count);
            while (i-- > 0) {
                [self.verticalArray addObject:@[].mutableCopy];
            }
            [self.verticalArray[obj.section] insertObject:@(-1) atIndex:idx];
            
            NSMutableArray <NSMutableArray <NSNumber *> *> *arr1 = self.horizontalArray;
            long i1 = (obj.section + 1 - arr1.count);
            while (i1-- > 0) {
                [self.horizontalArray addObject:@[].mutableCopy];
            }
            [self.horizontalArray[obj.section] insertObject:@(-1) atIndex:idx];
        }];
    }
    [self tableView_dynamicLayout_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isIndexPathHeightCache) {
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.verticalArray[obj.section] removeObjectAtIndex:obj.row];
            [self.horizontalArray[obj.section] removeObjectAtIndex:obj.row];
        }];
    }
    [self tableView_dynamicLayout_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    if (self.isIndexPathHeightCache) {
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            self.verticalArray[obj.section][obj.row] = @(-1);
            self.horizontalArray[obj.section][obj.row] = @(-1);
        }];
    }
    [self tableView_dynamicLayout_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)tableView_dynamicLayout_moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    if (self.isIndexPathHeightCache) {
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
    }
    [self tableView_dynamicLayout_moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
}

@end