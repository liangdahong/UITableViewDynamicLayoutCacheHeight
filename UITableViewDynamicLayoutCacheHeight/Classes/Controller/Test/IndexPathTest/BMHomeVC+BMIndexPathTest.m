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
    NSLog(@"reloadData 0");
    [self.tableView reloadData];
    NSLog(@"reloadData 0");
}

- (void)insertRowsAtIndexPaths {
    switch (arc4random_uniform(2)) {
        case 0:
            {
                if (0 == self.dataArray.count) {
                    return;
                }
                NSLog(@"insertRowsAtIndexPaths 0");
                BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
                if (0 == obj.modelArray.count) {
                    return;
                }

                BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];

                NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
                if (arr.count) {
                    NSIndexPath *index = arr.lastObject;
                    [self.dataArray[index.section].modelArray insertObject:[obj1 modelWithCopy] atIndex:index.row];
                    NSLog(@"insertRowsAtIndexPaths 0");
                    [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                    NSLog(@"insertRowsAtIndexPaths 0");
                }
            }
            break;
            case 1:
                {
                    if (0 == self.dataArray.count) {
                        return;
                    }
                    NSLog(@"insertRowsAtIndexPaths 1");
                    BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
                    if (0 == obj.modelArray.count) {
                        return;
                    }

                    BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];
                    NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
                    if (arr.count) {
                        NSIndexPath *index = arr.firstObject;
                        [self.dataArray[index.section].modelArray insertObject:[obj1 modelWithCopy] atIndex:index.row];
                        NSLog(@"insertRowsAtIndexPaths 1");
                        [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                        NSLog(@"insertRowsAtIndexPaths 1");
                    }
                }
                break;
        default:
            break;
    }
}

- (void)deleteIndexPaths {

    switch (arc4random_uniform(3)) {
        case 0:
        {
            NSLog(@"deleteIndexPaths 0");
            NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
            if (arr.count) {
                NSIndexPath *index = arr.firstObject;
                [self.dataArray[index.section].modelArray removeObjectAtIndex:index.row];
                NSLog(@"deleteIndexPaths 0");
                [self.tableView deleteRowsAtIndexPaths:@[index]
                                      withRowAnimation:(UITableViewRowAnimationAutomatic)];
                NSLog(@"deleteIndexPaths 0");
            }
        }
            break;

            case 1:
            {
                NSLog(@"deleteIndexPaths 1");
                NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
                if (arr.count) {
                    NSIndexPath *index = arr.lastObject;
                    [self.dataArray[index.section].modelArray removeObjectAtIndex:index.row];
                    NSLog(@"deleteIndexPaths 1");
                    [self.tableView deleteRowsAtIndexPaths:@[index]
                                          withRowAnimation:(UITableViewRowAnimationAutomatic)];
                    NSLog(@"deleteIndexPaths 1");
                }
            }
                break;
            break;

            case 2:
            {
                NSLog(@"deleteIndexPaths 2");
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
                    NSLog(@"deleteIndexPaths 2");
                    [self.tableView deleteRowsAtIndexPaths:arr withRowAnimation:(UITableViewRowAnimationAutomatic)];
                    NSLog(@"deleteIndexPaths 2");
                }
            }
                break;
        default:
            break;
    }
}

- (void)reloadIndexPaths {
    if (arc4random_uniform(2)) {
        if (0 == self.dataArray.count) {
            return;
        }
        if (self.dataArray.count) {
            NSLog(@"reloadIndexPaths 0");
            BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];

            if (0 == obj.modelArray.count) {
                return;
            }

            BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];

            NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
            if (arr.count > 1) {
                self.dataArray[arr.firstObject.section].modelArray[arr.firstObject.row] = [obj1 modelWithCopy];
                NSLog(@"reloadIndexPaths 0");
                [self.tableView reloadRowsAtIndexPaths:@[arr.firstObject] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                NSLog(@"reloadIndexPaths 0");
            }
        }
    } else {
        if (arc4random_uniform(2)) {
            if (self.dataArray.count) {
                NSLog(@"reloadIndexPaths 1");
                BMGroupModel *obj = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];

                if (0 == obj.modelArray.count) {
                    return;
                }

                BMModel *obj1 = obj.modelArray[(NSUInteger)arc4random_uniform((uint32_t)obj.modelArray.count)];
                NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
                if (arr.count > 1) {
                    NSIndexPath *index = arr.lastObject;
                    self.dataArray[index.section].modelArray[index.row] = [obj1 modelWithCopy];
                    NSLog(@"reloadIndexPaths 1");
                    [self.tableView reloadRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationAutomatic)];
                    NSLog(@"reloadIndexPaths 1");
                }
            }
        } else {
            if (0 == self.dataArray.count) {
                return;
            }
            NSLog(@"reloadIndexPaths 2");
            NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
            if (arr.count) {
                [arr enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    BMGroupModel *groupModel = self.dataArray[(NSUInteger)arc4random_uniform((uint32_t)self.dataArray.count)];
                    if (0 == groupModel.modelArray.count) {
                        return;
                    }
                    BMModel *model = groupModel.modelArray[(NSUInteger)arc4random_uniform((uint32_t)groupModel.modelArray.count)];
                    self.dataArray[obj.section].modelArray[obj.row] = [model modelWithCopy];
                }];
                NSLog(@"reloadIndexPaths 2");
                [self.tableView reloadRowsAtIndexPaths:arr withRowAnimation:(UITableViewRowAnimationAutomatic)];
                NSLog(@"reloadIndexPaths 2");
            }

        }
    }
}

- (void)moveIndexPaths {
    NSArray <NSIndexPath *> *arr = [self.tableView indexPathsForVisibleRows];
    if (arr.count > 1) {
        NSLog(@"moveIndexPaths 0");
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
        NSLog(@"moveIndexPaths 0");
        [self.tableView moveRowAtIndexPath:index1 toIndexPath:index2];
        NSLog(@"moveIndexPaths 0");
    }
}

@end
