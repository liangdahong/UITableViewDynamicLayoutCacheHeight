//
//  BMHomeVC.m
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/22.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMHomeVC.h"
#import "BMModel.h"
#import "BMCell.h"
#import "BMHeaderView.h"
#import "UIFooterView.h"
#import "UITableViewDynamicLayoutCacheHeight.h"

@interface BMHomeVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BMHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UITableViewDynamicLayoutCacheHeight";
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
    return [tableView bm_heightWithCellClass:BMCell.class cacheByIndexPath:indexPath configuration:^(__kindof BMCell * _Nonnull cell) {
        // 这里对 cell 继续和 willDisplayCell 类似此填充数据
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
