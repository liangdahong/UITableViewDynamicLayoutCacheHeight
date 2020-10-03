//
//  ViewController.m
//  ExampleCategory
//
//  Created by liangdahong on 2020/10/3.
//

#import "ViewController.h"
#import <UITableViewDynamicLayoutCacheHeight/UITableViewCell+BMDynamicLayout.h>
#import <UITableViewDynamicLayoutCacheHeight/UITableViewHeaderFooterView+BMDynamicLayout.h>
#import "DHTableViewCell.h"
#import "DHTableViewHeaderFooterView.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

#pragma mark - Life Cycle

#pragma mark - Public Method

#pragma mark - Action

#pragma mark - Custom Delegate

#pragma mark - System Delegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2  == 0) {
        UITableViewCell *cell = [UITableViewCell bm_tableViewCellFromAllocWithTableView:tableView];
        cell.textLabel.text = indexPath.description;
        return cell;
    } else {
        DHTableViewCell *cell = [DHTableViewCell bm_tableViewCellFromNibWithTableView:tableView];
        cell.textLabel.text = indexPath.description;
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UITableViewHeaderFooterView bm_tableViewHeaderFooterViewFromAllocWithTableView:tableView];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [DHTableViewHeaderFooterView bm_tableViewHeaderFooterViewFromNibWithTableView:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 100;
}

#pragma mark - Getters Setters

#pragma mark - Private Method

@end
