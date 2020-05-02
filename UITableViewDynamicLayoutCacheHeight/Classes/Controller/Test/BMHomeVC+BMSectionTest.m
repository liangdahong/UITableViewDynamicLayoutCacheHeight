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
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"插入 section " message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"随机取一组插入位置 section = 0" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
        [self.dataArray insertObject:[obj groupModelWithCopy] atIndex:0];
        [self.tableView insertSections:[NSMutableIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationAutomatic)];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)deleteSections {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"删除 section" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"删除当前屏幕上的第一个 cell 所在的 组" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            [self.dataArray removeObjectAtIndex:arr.firstObject.section];
            [self.tableView deleteSections:[NSMutableIndexSet indexSetWithIndex:arr.firstObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"删除当前屏幕上的最后一个 cell 所在的 组" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            [self.dataArray removeObjectAtIndex:arr.lastObject.section];
            [self.tableView deleteSections:[NSMutableIndexSet indexSetWithIndex:arr.lastObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)reloadSections {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"刷新 section" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"刷新当前屏幕上的第一个 cell 所在的 组" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
            if (obj.modelArray.count == self.dataArray[arr.firstObject.section].modelArray.count) {
                self.dataArray[arr.firstObject.section] = obj;
                [self.tableView reloadSections:[NSMutableIndexSet indexSetWithIndex:arr.firstObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            } else {
                [self.tableView reloadSections:[NSMutableIndexSet indexSetWithIndex:arr.firstObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            }
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"刷新当前屏幕上的最后一个 cell 所在的 组" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
            if (obj.modelArray.count == self.dataArray[arr.firstObject.section].modelArray.count) {
                self.dataArray[arr.firstObject.section] = obj;
                [self.tableView reloadSections:[NSMutableIndexSet indexSetWithIndex:arr.lastObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            } else {
                [self.tableView reloadSections:[NSMutableIndexSet indexSetWithIndex:arr.lastObject.section] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            }
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)moveSection {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"move section" message:nil preferredStyle:UIAlertControllerStyleAlert];
    NSUInteger arc1 = (NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count);
    NSUInteger arc2 = 0;
    if (arc1 == 0) {
        arc2 = 2;
    }
    [alertVC addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"arc move Section %lu <-> %lu", (unsigned long)arc1, (unsigned long)arc2] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        id obj = self.dataArray[arc1];
        [self.dataArray removeObjectAtIndex:arc1];
        [self.dataArray insertObject:obj atIndex:arc2];
        [self.tableView moveSection:arc1 toSection:arc2];
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
