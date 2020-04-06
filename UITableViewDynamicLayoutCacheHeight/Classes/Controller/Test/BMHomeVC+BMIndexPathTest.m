//
//  BMHomeVC+BMIndexPathTest.m
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by mac on 2020/4/5.
//  Copyright © 2020 liangdahong. All rights reserved.
//

#import "BMHomeVC+BMIndexPathTest.h"
@implementation BMHomeVC (BMIndexPathTest)

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)insertRowsAtIndexPaths {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"insertRowsAtIndexPaths " message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"随机取 IndexPath 插入位置 当前屏幕的第一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
        BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            [self.dataArray[arr.firstObject.section].modelArray insertObject:obj1 atIndex:arr.firstObject.row];
            [self.tableView insertRowsAtIndexPaths:@[
                [NSIndexPath indexPathForRow:arr.firstObject.row inSection:arr.firstObject.section]
            ] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"随机取 IndexPath 插入位置 当前屏幕的最一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
        BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            [self.dataArray[arr.firstObject.section].modelArray insertObject:obj1 atIndex:arr.lastObject.row];
            [self.tableView insertRowsAtIndexPaths:@[
                [NSIndexPath indexPathForRow:arr.lastObject.row inSection:arr.lastObject.section]
            ] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)deleteIndexPaths {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"deleteIndexPaths " message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"删除当前屏幕显示的第一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            [self.dataArray[arr.firstObject.section].modelArray removeObjectAtIndex:arr.firstObject.row];
            [self.tableView deleteRowsAtIndexPaths:@[arr.firstObject] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"删除当前屏幕显示的最后一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            [self.dataArray[arr.lastObject.section].modelArray removeObjectAtIndex:arr.lastObject.row];
            [self.tableView deleteRowsAtIndexPaths:@[arr.lastObject] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)reloadIndexPaths {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"reloadIndexPaths " message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"随机取 IndexPath 刷新 当前屏幕的第一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
        BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            self.dataArray[arr.firstObject.section].modelArray[arr.firstObject.row] = obj1;
            [self.tableView reloadRowsAtIndexPaths:@[arr.firstObject] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"随机取 IndexPath 刷新 当前屏幕的最后一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
        BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            self.dataArray[arr.lastObject.section].modelArray[arr.lastObject.row] = obj1;
            [self.tableView reloadRowsAtIndexPaths:@[arr.lastObject] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"随机取 IndexPath 刷新 当前屏幕的第一个 和 最后一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
        BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count > 1) {
            self.dataArray[arr.lastObject.section].modelArray[arr.lastObject.row] = obj1;
            [self.tableView reloadRowsAtIndexPaths:@[arr.lastObject,arr.firstObject] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"随机取 IndexPath 刷新 当前屏幕的全部 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
        BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            self.dataArray[arr.lastObject.section].modelArray[arr.lastObject.row] = obj1;
            [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)moveIndexPaths {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"moveIndexPaths " message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"随机取 IndexPath 刷新 当前屏幕的第一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count > 1) {
            NSIndexPath *index1 = arr.firstObject;
            NSIndexPath *index2 = arr.lastObject;
            if (index1.section == index2.section) {
                id t = self.dataArray[index1.section].modelArray[index1.row];
                [self.dataArray[index1.section].modelArray removeObjectAtIndex:index1.row];
                [self.dataArray[index2.section].modelArray insertObject:t atIndex:index2.row];
            } else {
                id t = self.dataArray[index1.section].modelArray[index1.row];
                [self.dataArray[index1.section].modelArray removeObjectAtIndex:index1.row];
                [self.dataArray[index2.section].modelArray insertObject:t atIndex:index2.row];
            }
            [self.tableView moveRowAtIndexPath:index1 toIndexPath:index2];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
