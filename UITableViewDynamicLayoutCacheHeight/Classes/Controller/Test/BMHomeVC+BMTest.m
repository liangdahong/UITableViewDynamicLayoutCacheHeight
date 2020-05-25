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


#define kBMTest_TableView_top     [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
#define kBMTest_TableView_Bottom  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height) animated:NO]; \
});\

@implementation BMHomeVC (BMTest)

- (void)test_reloadData {
    self.dataArray = AppDelegate.dataArray;
    [self.dataArray enumerateObjectsUsingBlock:^(BMGroupModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.modelArray.count) {
            [obj.modelArray removeObjectAtIndex:arc4random_uniform((uint32_t)obj.modelArray.count)];
        }
    }];
    [self.tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        kBMTest_TableView_Bottom;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            kBMTest_TableView_top;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self test_reloadData];
            });
        });
    });
}

- (void)insertSections_One_first {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.dataArray.count) {
            NSLog(@"insertSections_One_first 0");
            BMGroupModel *model = [self.dataArray[arc4random_uniform((uint32_t)self.dataArray.count)] groupModelWithCopy];
            [self.dataArray insertObject:model atIndex:0];
            NSLog(@"insertSections_One_first 1");
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            NSLog(@"insertSections_One_first 2");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                kBMTest_TableView_Bottom;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    kBMTest_TableView_top;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self insertSections_One_first];
                    });
                });
            });
        }
    });
}

- (void)insertSections_One_last {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.dataArray.count) {
            NSLog(@"insertSections_One_last 1");
            BMGroupModel *model = [self.dataArray[arc4random_uniform((uint32_t)self.dataArray.count)] groupModelWithCopy];
            uint32_t arc = (uint32_t)self.dataArray.count;
            [self.dataArray insertObject:model atIndex:arc];
            NSLog(@"insertSections_One_last 2");
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:arc] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            NSLog(@"insertSections_One_last 3");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                kBMTest_TableView_Bottom;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    kBMTest_TableView_top;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self insertSections_One_last];
                    });
                });
            });
        }
    });
}

- (void)insertSections_One_arc {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.dataArray.count) {
            NSLog(@"insertSections_One_arc 1");
            BMGroupModel *model = [self.dataArray[arc4random_uniform((uint32_t)self.dataArray.count)] groupModelWithCopy];
            uint32_t arc = arc4random_uniform((uint32_t)self.dataArray.count);
            [self.dataArray insertObject:model atIndex:arc];
            NSLog(@"insertSections_One_arc 2");
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:arc] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            NSLog(@"insertSections_One_arc 3");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                kBMTest_TableView_Bottom;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    kBMTest_TableView_top;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self insertSections_One_last];
                    });
                });
            });
        }
    });
}

- (void)insertSections_arccount_arc {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.dataArray.count) {
            NSLog(@"insertSections_One_arc 1");
            BMGroupModel *model = [self.dataArray[arc4random_uniform((uint32_t)self.dataArray.count)] groupModelWithCopy];
            uint32_t arc = arc4random_uniform((uint32_t)self.dataArray.count);
            [self.dataArray insertObject:model atIndex:arc];
            NSLog(@"insertSections_One_arc 2");
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:arc] withRowAnimation:(UITableViewRowAnimationAutomatic)];
            NSLog(@"insertSections_One_arc 3");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                kBMTest_TableView_Bottom;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    kBMTest_TableView_top;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self insertSections_One_last];
                    });
                });
            });
        }
    });
}

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
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
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
        kBMTest_TableView_Bottom;
        kBMTest_TableView_top;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self deleteIndexPaths];
            kBMTest_TableView_Bottom;
            kBMTest_TableView_top;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self reloadIndexPaths];
                kBMTest_TableView_Bottom;
                kBMTest_TableView_top;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self moveIndexPaths];
                    kBMTest_TableView_Bottom;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        
                    });
                    kBMTest_TableView_top;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self reloadData];
                        kBMTest_TableView_Bottom;
                        kBMTest_TableView_top;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            if (arc4random_uniform(2)) {
                                [self test1];
                            } else {
                                [self test2];
                            }
                            kBMTest_TableView_Bottom;
                            kBMTest_TableView_top;
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
