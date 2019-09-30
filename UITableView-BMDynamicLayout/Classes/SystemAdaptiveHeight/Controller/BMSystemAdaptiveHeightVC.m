//
//  BMSystemAdaptiveHeightVC.m
//  UITableView-BMTemplateLayoutCell
//
//  Created by liangdahong on 2019/9/26.
//  Copyright © 2019 ( https://liangdahong.com ). All rights reserved.
//

#import "BMSystemAdaptiveHeightVC.h"
#import "UITableView+BMDynamicLayout1.h"
#import "BMSystemAdaptiveHeighCell.h"
#import "BMSystemAdaptiveHeighHeaderView.h"
#import "BMSystemAdaptiveHeighFooterView.h"

@interface BMSystemAdaptiveHeightVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BMSystemAdaptiveHeightVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    self.tableView.estimatedSectionHeaderHeight = 100;
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedSectionFooterHeight = 100;
    self.tableView.sectionFooterHeight = UITableViewAutomaticDimension;
}

#pragma mark - 系统delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BMSystemAdaptiveHeighCell bm_tableViewCellWithTableView:tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BMSystemAdaptiveHeighCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.dataArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BMSystemAdaptiveHeighHeaderView *view = [BMSystemAdaptiveHeighHeaderView bm_tableViewHeaderFooterViewWithTableView:tableView];
    view.contentView.backgroundColor = [UIColor redColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    BMSystemAdaptiveHeighFooterView *view = [BMSystemAdaptiveHeighFooterView bm_tableViewHeaderFooterViewWithTableView:tableView];
    view.contentView.backgroundColor = [UIColor blueColor];
    return view;
}

@end
