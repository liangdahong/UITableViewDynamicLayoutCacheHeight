//
//  BMXibCellVC.m
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/22.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMXibCellVC.h"
#import "UITableView+BMDynamicLayout.h"
#import "BMModel.h"
#import "BMCell.h"
#import "BMHeaderView.h"
#import "UIFooterView.h"
#import "BMSystemAdaptiveHeightVC.h"

@interface BMXibCellVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <BMModel *> *dataArray;
@property (nonatomic, strong) BMSystemAdaptiveHeightVC *systemAdaptiveHeightVC; ///< systemAdaptiveHeightVC

@end

@implementation BMXibCellVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"系统自适应" style:0 target:self action:@selector(otherClick)];
}

- (void)otherClick {
    [self.navigationController pushViewController:self.systemAdaptiveHeightVC animated:YES];
}

- (BMSystemAdaptiveHeightVC *)systemAdaptiveHeightVC {
    if (!_systemAdaptiveHeightVC) {
        _systemAdaptiveHeightVC = [BMSystemAdaptiveHeightVC new];
        _systemAdaptiveHeightVC.dataArray = self.dataArray;
    }
    return _systemAdaptiveHeightVC;
}

- (NSMutableArray<BMModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
        static NSInteger count = 0;
        int arc = 10;
        NSMutableArray *mua = [@[] mutableCopy];
        while (arc--) {
            BMModel *model = [BMModel new];
            int arci = arc4random_uniform(20) + 1;
            NSMutableString *string = [NSMutableString string];
            while (arci--) {
                [string appendString:@"消息消息消息"];
            }
            [string appendString:@"详情完~"];
            
            model.desc = string;
            int arcd = arc4random_uniform(5)+1;
            NSMutableString *string1 = [NSMutableString string];
            while (arcd--) {
                [string1 appendString:@"标题标题标题"];
            }
            [string1 appendString:@"标题完~"];
            model.name = string1;
            model.icon = [NSString stringWithFormat:@"%d.png", arc4random_uniform(8) + 1];
            model.ID = [NSString stringWithFormat:@"%ld", (long)count++];
            [self.dataArray addObject:model];
            [mua addObject:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0]];
        }
        [self.tableView reloadData];
    }
    return _dataArray;
}

#pragma mark - 系统delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BMCell bm_tableViewCellWithTableView:tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BMCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.dataArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMModel *model = self.dataArray[indexPath.row];
    return [tableView bm_heightForCellWithCellClass:BMCell.class cacheByIndexPath:indexPath tableViewWidth:UIScreen.mainScreen.bounds.size.width configuration:^(__kindof BMCell *cell) {
        cell.model = model;
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BMHeaderView *view = [BMHeaderView bm_tableViewHeaderFooterViewWithTableView:tableView];
    view.contentView.backgroundColor = [UIColor redColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [tableView bm_heightForHeaderFooterViewWithHeaderFooterViewClass:BMHeaderView.class isHeaderView:YES section:section configuration:^(__kindof BMHeaderView * _Nonnull headerFooterView) {
        headerFooterView.contentView.backgroundColor = [UIColor redColor];
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIFooterView *view = [UIFooterView bm_tableViewHeaderFooterViewWithTableView:tableView];
    view.contentView.backgroundColor = [UIColor blueColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [tableView bm_heightForHeaderFooterViewWithHeaderFooterViewClass:UIFooterView.class isHeaderView:NO section:section configuration:^(__kindof UIFooterView * _Nonnull headerFooterView) {
    }];
}

@end
