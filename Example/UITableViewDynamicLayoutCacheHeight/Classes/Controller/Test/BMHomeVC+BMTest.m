//
//  BMHomeVC+BMTest.m
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by mac on 2020/4/5.
//  Copyright © 2020 liangdahong. All rights reserved.
//

#import "BMHomeVC+BMTest.h"
#import "AppDelegate.h"
#import "BMHomeVC+IndexPaths.h"
#import "BMHomeVC+BMSectionTest.h"

#define kBMTest_TableView_top     [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
#define kBMTest_TableView_Bottom  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
    [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.bounds.size.height) animated:NO]; \
});\

@implementation BMHomeVC (BMTest)

- (void)test_while_deleteIndexPaths_reloadRowsAtIndexPaths {
    if ([self.tableView visibleCells].count <= 2) {
        self.dataArray = AppDelegate.dataArray;
        [self.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self test_while_deleteIndexPaths_reloadRowsAtIndexPaths];
        });
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test_BMDeleteIndexPaths];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            kBMTest_TableView_Bottom;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self test_BMReloadRowsAtIndexPaths];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    kBMTest_TableView_top;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self test_while_deleteIndexPaths_reloadRowsAtIndexPaths];
                    });
                });
            });
        });
    });
}

- (void)test_while_deleteSections_reloadRowsAtSections {
    if ([self.tableView visibleCells].count <= 2) {
        self.dataArray = AppDelegate.dataArray;
        [self.tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self test_while_deleteSections_reloadRowsAtSections];
        });
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test_BMDeleteSections];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            kBMTest_TableView_Bottom;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self test_BMReloadRowsAtSections];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    kBMTest_TableView_top;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self test_while_deleteSections_reloadRowsAtSections];
                    });
                });
            });
        });
    });
}

@end
