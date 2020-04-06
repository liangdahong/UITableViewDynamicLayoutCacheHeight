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
#import "UIFooterView.h"
#import "UITableViewDynamicLayoutCacheHeight.h"
#import "BMHomeVC+BMTest.h"

@implementation BMHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UITableViewDynamicLayoutCacheHeight";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"点我测试" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightItemDidClick)];
}

#pragma mark - 系统delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray[section].modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BMCell bm_tableViewCellWithTableView:tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BMCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.dataArray[indexPath.section].modelArray[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView bm_heightWithCellClass:BMCell.class cacheByIndexPath:indexPath configuration:^(__kindof BMCell *cell) {
        cell.model = self.dataArray[indexPath.section].modelArray[indexPath.row];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableViewHeaderFooterView

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BMHeaderView *view = [BMHeaderView bm_tableViewHeaderFooterViewWithTableView:tableView];
    view.titleLabel.text = self.dataArray[section].headerTitle;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [tableView bm_heightWithHeaderFooterViewClass:BMHeaderView.class type:(BMHeaderFooterViewDynamicLayoutTypeHeader) cacheBySection:section configuration:^(__kindof BMHeaderView * _Nonnull headerFooterView) {
        headerFooterView.titleLabel.text = self.dataArray[section].headerTitle;
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIFooterView *view = [UIFooterView bm_tableViewHeaderFooterViewWithTableView:tableView];
    view.titleLabel.text = self.dataArray[section].footerTitle;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [tableView bm_heightWithHeaderFooterViewClass:UIFooterView.class type:(BMHeaderFooterViewDynamicLayoutTypeFooter) cacheBySection:section configuration:^(__kindof UIFooterView * _Nonnull headerFooterView) {
        headerFooterView.titleLabel.text = self.dataArray[section].footerTitle;
    }];
}

@end
