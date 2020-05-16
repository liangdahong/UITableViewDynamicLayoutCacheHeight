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

@end
