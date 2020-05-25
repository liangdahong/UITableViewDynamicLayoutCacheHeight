//
//  BMHomeVC+BMSectionTest.m
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by mac on 2020/4/5.
//  Copyright © 2020 liangdahong. All rights reserved.
//

#import "BMHomeVC+BMSectionTest.h"

@implementation BMHomeVC (BMSectionTest)

- (void)test_BMReloadRowsAtSections {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [self.dataArray enumerateObjectsUsingBlock:^(BMGroupModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (arc4random_uniform(4) == 0) {
            [indexSet addIndex:idx];
        }
    }];
    [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        self.dataArray[idx] = [self.dataArray[arc4random_uniform((uint32_t)self.dataArray.count)] groupModelWithCopy];
    }];
    [self.tableView reloadSections:indexSet withRowAnimation:(UITableViewRowAnimationAutomatic)];
}

- (void)test_BMDeleteSections {
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    [self.dataArray enumerateObjectsUsingBlock:^(BMGroupModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (arc4random_uniform(3) == 0) {
            [indexSet addIndex:idx];
        }
    }];
    [indexSet enumerateIndexesWithOptions:NSEnumerationReverse usingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArray removeObjectAtIndex:idx];
    }];
    [self.tableView deleteSections:indexSet withRowAnimation:(UITableViewRowAnimationAutomatic)];
}

@end
