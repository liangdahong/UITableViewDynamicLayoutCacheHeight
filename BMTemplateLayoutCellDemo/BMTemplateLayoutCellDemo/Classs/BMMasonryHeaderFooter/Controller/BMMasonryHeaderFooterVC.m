//
//  BMMasonryHeaderFooterVC.m
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/8/25.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMMasonryHeaderFooterVC.h"
#import "BMMasonryTableViewHeaderView.h"
#import "UITableView+BMTemplateLayoutCell.h"
#import "UITableViewHeaderFooterView+BMReusable.h"

@interface BMMasonryHeaderFooterVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BMMasonryHeaderFooterVC

#pragma mark -

#pragma mark - 生命周期

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUI];
}

#pragma mark - getters setters

#pragma mark - 系统delegate

#pragma mark - UITableViewDataSource UITableViewDelegate
#pragma mark - UITableViewDataSource UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [BMMasonryTableViewHeaderView bm_tableViewHeaderFooterViewWithTableView:tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(BMMasonryTableViewHeaderView *)view forSection:(NSInteger)section {
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [tableView bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:BMMasonryTableViewHeaderView.class cacheByKey:@"c" configuration:^(__kindof UITableViewHeaderFooterView *headerFooterView) {
    }];
}

#pragma mark - UITableViewDelegate

#pragma mark - 自定义delegate

#pragma mark - 公有方法

#pragma mark - 私有方法

- (void)setUI {
}

#pragma mark - 事件响应
@end
