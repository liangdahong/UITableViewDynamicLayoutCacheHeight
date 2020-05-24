//
//  BMHomeVC+BMTest.m
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by mac on 2020/4/5.
//  Copyright © 2020 liangdahong. All rights reserved.
//

#import "BMHomeVC+BMTest.h"
#import "BMHomeVC+BMSectionTest.h"
#import "BMHomeVC+BMIndexPathTest.h"
#import "AppDelegate.h"

@implementation BMHomeVC (BMTest)

- (void)rightItemDidClick {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"测试" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"插入 section " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self insertSections];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"删除 section " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteSections];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"移动 section " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self moveSection];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"刷新 section " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self reloadSections];
    }]];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"插入 cell " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self insertRowsAtIndexPaths];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"删除 cell " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteIndexPaths];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"移动 cell " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self moveIndexPaths];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"刷新 cell " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self reloadIndexPaths];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"刷新 tableView " style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self reloadData];
    }]];

    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)test3 {
    if ([self.tableView visibleCells].count <= 2) {
        self.dataArray = AppDelegate.dataArray;
        [self.tableView reloadData];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self deleteIndexPaths];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self test3];
        });
    });
}

- (void)test1 {
    if ([self.tableView visibleCells].count <= 2) {
        self.dataArray = AppDelegate.dataArray;
        [self.tableView reloadData];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self insertRowsAtIndexPaths];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self deleteIndexPaths];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self reloadIndexPaths];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self moveIndexPaths];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self reloadData];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            if (arc4random_uniform(2)) {
                                [self test1];
                            } else {
                                [self test2];
                            }
                        });
                    });
                });
            });
        });
    });
}

- (void)test2 {
    if ([self.tableView visibleCells].count <= 2) {
        self.dataArray = AppDelegate.dataArray;
        [self.tableView reloadData];
    }

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self insertSections];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self deleteSections];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self reloadSections];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self moveSection];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (arc4random_uniform(2)) {
                            [self test1];
                        } else {
                            [self test2];
                        }
                    });
                });
            });
        });
    });
}

@end
