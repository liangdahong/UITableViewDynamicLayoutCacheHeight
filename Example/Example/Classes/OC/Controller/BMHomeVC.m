//    MIT License
//
//    Copyright (c) 2019 https://github.com/liangdahong
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

#import "BMHomeVC.h"
#import "BMModel.h"
#import "BMCell.h"
#import "BMHeaderView.h"
#import "BMFooterView.h"
#import "UITableViewDynamicLayoutCacheHeight.h"
#import "AppDelegate.h"
#import "BMHomeVC+BMTest.h"
//#import "Example-swift.h"

//#define kTEST_KEY_CACHE arc4random_uniform(2)
#define kTEST_KEY_CACHE NO

@implementation BMHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CellCacheHeight";
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否启动自动测试模块" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"启动" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self test_while_deleteIndexPaths_reloadRowsAtIndexPaths];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self test_while_deleteSections_reloadRowsAtSections];
        });
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"不启动" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
    
    // swift
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Swift" style:(UIBarButtonItemStylePlain) target:self action:@selector(swiftButtonClick)];
}

#pragma mark - 系统delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray[section].modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMCell *cell = [BMCell bm_tableViewCellFromNibWithTableView:tableView];
    cell.model = self.dataArray[indexPath.section].modelArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
    if (kTEST_KEY_CACHE) {
        return [tableView bm_heightWithCellClass:BMCell.class cacheByKey:indexPath.description configuration:^(__kindof BMCell *cell) {
            // 配置 Cell
            // 同 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 一样
            cell.model = self.dataArray[indexPath.section].modelArray[indexPath.row];
        }];
    } else {
        return [tableView bm_heightWithCellClass:BMCell.class cacheByIndexPath:indexPath configuration:^(__kindof BMCell *cell) {
            // 配置 Cell
            // 同 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 一样
            cell.model = self.dataArray[indexPath.section].modelArray[indexPath.row];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewHeaderFooterView

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BMHeaderView *view = [BMHeaderView bm_tableViewHeaderFooterViewFromNibWithTableView:tableView];
    view.titleLabel.text = self.dataArray[section].headerTitle;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (kTEST_KEY_CACHE) {
        return [tableView bm_heightWithHeaderFooterViewClass:BMHeaderView.class type:BMHeaderFooterViewDynamicLayoutTypeHeader cacheByKey:@(section) configuration:^(__kindof BMHeaderView *headerFooterView) {
            // 配置 headerView
            // 同 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
            headerFooterView.titleLabel.text = self.dataArray[section].headerTitle;
        }];;
    } else {
        return [tableView bm_heightWithHeaderFooterViewClass:BMHeaderView.class type:(BMHeaderFooterViewDynamicLayoutTypeHeader) cacheBySection:section configuration:^(__kindof BMHeaderView * _Nonnull headerFooterView) {
            // 配置 headerView
            // 同 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
            headerFooterView.titleLabel.text = self.dataArray[section].headerTitle;
        }];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    BMFooterView *view = [BMFooterView bm_tableViewHeaderFooterViewFromNibWithTableView:tableView];
    view.titleLabel.text = self.dataArray[section].footerTitle;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (kTEST_KEY_CACHE) {
        return [tableView bm_heightWithHeaderFooterViewClass:BMFooterView.class type:BMHeaderFooterViewDynamicLayoutTypeFooter cacheByKey:@(section) configuration:^(__kindof BMFooterView *headerFooterView) {
            // 配置 footerView
            // 同 - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
            headerFooterView.titleLabel.text = self.dataArray[section].footerTitle;
        }];
    } else {
        return [tableView bm_heightWithHeaderFooterViewClass:BMFooterView.class type:(BMHeaderFooterViewDynamicLayoutTypeFooter) cacheBySection:section configuration:^(__kindof BMFooterView * _Nonnull headerFooterView) {
            // 配置 footerView
            // 同 - (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
            headerFooterView.titleLabel.text = self.dataArray[section].footerTitle;
        }];
    }
}

#pragma mark - Action

- (void)swiftButtonClick {
//    [self.navigationController pushViewController:SwiftTestVC.new animated:YES];
}

@end
