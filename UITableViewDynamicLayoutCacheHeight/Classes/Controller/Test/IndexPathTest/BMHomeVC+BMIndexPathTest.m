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
            NSIndexPath *index = arr.firstObject;
            [self.dataArray[index.section].modelArray insertObject:[obj1 modelWithCopy] atIndex:index.row];
            [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"随机取 IndexPath 插入位置 当前屏幕的最一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
        BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            NSIndexPath *index = arr.lastObject;
            [self.dataArray[index.section].modelArray insertObject:[obj1 modelWithCopy] atIndex:index.row];
            [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationAutomatic)];
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
            NSIndexPath *index = arr.firstObject;
            [self.dataArray[index.section].modelArray removeObjectAtIndex:index.row];
            [self.tableView deleteRowsAtIndexPaths:@[index]
                                  withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"删除当前屏幕显示的最后一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            NSIndexPath *index = arr.lastObject;
            [self.dataArray[index.section].modelArray removeObjectAtIndex:index.row];
            [self.tableView deleteRowsAtIndexPaths:@[index]
                                  withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"删除当前屏幕显示的全部 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        NSMutableArray *tempIndexPaths = arr.mutableCopy;
        [tempIndexPaths sortUsingComparator:^NSComparisonResult(NSIndexPath *  _Nonnull obj1, NSIndexPath *  _Nonnull obj2) {
            if (obj1.section == obj2.section) {
                return obj1.row < obj2.row;
            }
            return obj1.section < obj2.section;
        }];
        [tempIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.dataArray[obj.section].modelArray removeObjectAtIndex:obj.row];
        }];
        if (arr.count) {
            [self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)reloadIndexPaths {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"reloadIndexPaths " message:nil preferredStyle:UIAlertControllerStyleAlert];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"刷新当前屏幕的第一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
        BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count > 1) {
            self.dataArray[arr.firstObject.section].modelArray[arr.firstObject.row] = [obj1 modelWithCopy];
            [self.tableView reloadRowsAtIndexPaths:@[arr.firstObject] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"刷新当前屏幕的最后一个 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
        BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count > 1) {
            NSIndexPath *index = arr.lastObject;
            self.dataArray[index.section].modelArray[index.row] = [obj1 modelWithCopy];
            [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"刷新当前屏幕的全部 cell" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
        if (arr.count) {
            [arr enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BMGroupModel *groupModel = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
                BMModel *model = groupModel.modelArray[(NSUInteger)arc4random_uniform((uint32_t)groupModel.modelArray.count)];
                self.dataArray[obj.section].modelArray[obj.row] = [model modelWithCopy];
            }];
            [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:(UITableViewRowAnimationAutomatic)];
        }
    }]];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)moveIndexPaths {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"移动" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"屏幕第一个 Cell 移动到屏幕最后的位置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
