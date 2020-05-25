
//
//  BMHomeVC+BMReloadRowsAtIndexPaths.m
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by liangdahong on 2020/5/25.
//  Copyright © 2020 梁大红. All rights reserved.
//

#import "BMHomeVC+IndexPaths.h"

@implementation BMHomeVC (IndexPaths)

- (void)test_BMReloadRowsAtIndexPaths {
    NSMutableArray <NSIndexPath *> *indexPaths = @[].mutableCopy;
    [self.dataArray enumerateObjectsUsingBlock:^(BMGroupModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.modelArray enumerateObjectsUsingBlock:^(BMModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            if (arc4random_uniform(4) == 0) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:idx1 inSection:idx]];
            }
        }];
    }];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.dataArray.count) {
            BMGroupModel *model = self.dataArray[arc4random_uniform((uint32_t)self.dataArray.count)];
            if (model.modelArray.count) {
                self.dataArray[obj.section].modelArray[obj.row] = [model.modelArray[arc4random_uniform((uint32_t)model.modelArray.count)] modelWithCopy];
            }
        }
    }];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimationAutomatic)];
}

- (void)test_BMDeleteIndexPaths {
    NSMutableArray <NSIndexPath *> *indexPaths = @[].mutableCopy;
    [self.dataArray enumerateObjectsUsingBlock:^(BMGroupModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj.modelArray enumerateObjectsUsingBlock:^(BMModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            if (arc4random_uniform(4) == 0) {
                [indexPaths addObject:[NSIndexPath indexPathForRow:idx1 inSection:idx]];
            }
        }];
    }];
    [indexPaths sortUsingComparator:^NSComparisonResult(NSIndexPath *  _Nonnull obj1, NSIndexPath *  _Nonnull obj2) {
        if (obj1.section == obj2.section) {
            return obj1.row < obj2.row;
        }
        return obj1.section < obj2.section;
    }];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArray[obj.section].modelArray removeObjectAtIndex:obj.row];
    }];
    [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:(UITableViewRowAnimationAutomatic)];
}

@end
