//
//  BMHomeVC+BMSectionTest.m
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by mac on 2020/4/5.
//  Copyright © 2020 liangdahong. All rights reserved.
//

#import "BMHomeVC+BMSectionTest.h"

@implementation BMHomeVC (BMSectionTest)

- (void)insertSections {
    if (0 == self.dataArray.count) {
        return;
    }
    BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
    [self.dataArray insertObject:[obj groupModelWithCopy] atIndex:0];
    [self.tableView insertSections:[NSMutableIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationAutomatic)];
}

- (void)deleteSections {
    switch (arc4random_uniform(2)) {
        case 0:
        {
            NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
            if (arr.count) {
                [self.dataArray removeObjectAtIndex:arr.firstObject.section];
                [self.tableView deleteSections:[NSMutableIndexSet indexSetWithIndex:arr.firstObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            }
        }
            break;
        case 1:
        {
            NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
            if (arr.count) {
                [self.dataArray removeObjectAtIndex:arr.lastObject.section];
                [self.tableView deleteSections:[NSMutableIndexSet indexSetWithIndex:arr.lastObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            }
        }
            break;

        default:
            break;
    }


}

- (void)reloadSections {
    switch (arc4random_uniform(2)) {
        case 0:
        {
            NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
            if (arr.count) {
                if (0 == self.dataArray.count) {
                    return;
                }
                BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
                if (obj.modelArray.count == self.dataArray[arr.firstObject.section].modelArray.count) {
                    self.dataArray[arr.firstObject.section] = obj;
                    [self.tableView reloadSections:[NSMutableIndexSet indexSetWithIndex:arr.firstObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                } else {
                    [self.tableView reloadSections:[NSMutableIndexSet indexSetWithIndex:arr.firstObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                }
            }
        }
            break;
        case 1:
        {
            NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
            if (arr.count) {
                if (0 == self.dataArray.count) {
                    return;
                }
                BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
                if (obj.modelArray.count == self.dataArray[arr.firstObject.section].modelArray.count) {
                    self.dataArray[arr.firstObject.section] = obj;
                    [self.tableView reloadSections:[NSMutableIndexSet indexSetWithIndex:arr.lastObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                } else {
                    [self.tableView reloadSections:[NSMutableIndexSet indexSetWithIndex:arr.lastObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                }
            }
        }
            break;
        default:
            break;
    }
}

- (void)moveSection {
    if (0 == self.dataArray.count) {
        return;
    }
    NSUInteger arc1 = (NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count);
    NSUInteger arc2 = 0;
    if (arc1 == 0) {
        arc2 = 2;
    }
    id obj = self.dataArray[arc1];
    [self.dataArray removeObjectAtIndex:arc1];
    [self.dataArray insertObject:obj atIndex:arc2];
    [self.tableView moveSection:arc1 toSection:arc2];
}

@end
