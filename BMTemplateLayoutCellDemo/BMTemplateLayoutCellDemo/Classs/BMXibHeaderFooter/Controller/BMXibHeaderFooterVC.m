//
//  BMXibHeaderFooterVC.m
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/8/25.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMXibHeaderFooterVC.h"
#import "BMXibHeader.h"
#import "UITableView+BMTemplateLayoutCell.h"
#import "BMModel.h"
#import "UITableViewHeaderFooterView+BMReusable.h"
#import "UITableViewCell+BMReusable.h"

@interface BMXibHeaderFooterVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <BMModel *> *dataArray;

@end

@implementation BMXibHeaderFooterVC


#pragma mark -

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

#pragma mark - getters setters

- (NSMutableArray<BMModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}
#pragma mark - 系统delegate

#pragma mark - UITableViewDataSource UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell bm_cellWithTableView:tableView];
    cell.textLabel.text = @"我是cell";
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [BMXibHeader bm_tableViewHeaderFooterViewWithTableView:tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(BMXibHeader *)view forSection:(NSInteger)section {
    view.model = self.dataArray[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    BMModel *model = self.dataArray[section];
    return [tableView bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:BMXibHeader.class cacheByKey:model.ID configuration:^(__kindof BMXibHeader *headerFooterView) {
        headerFooterView.model = model;
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01;
}

#pragma mark - UITableViewDelegate

#pragma mark - 自定义delegate

#pragma mark - 公有方法

#pragma mark - 私有方法

- (void)setUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"加一点数据" style:0 target:self action:@selector(addModelClock)];
    self.tableView.rowHeight = 20;
}

#pragma mark - 事件响应
- (void)addModelClock {
    static NSInteger count = 0;
    int arc = 3;
    NSMutableArray *mua = [@[] mutableCopy];
    while (arc--) {
        
        BMModel *model = [BMModel new];
        int arci = arc4random_uniform(200)+10;
        NSMutableString *string = [NSMutableString string];
        while (arci--) {
            if (arc4random_uniform(2)) {
                [string appendString:@"消"];
            } else {
                [string appendString:@"息"];
            }
        }
        model.desc = string;
        int arcd = arc4random_uniform(50)+10;
        NSMutableString *string1 = [NSMutableString string];
        while (arcd--) {
            if (arc4random_uniform(2)) {
                [string1 appendString:@"名"];
            } else {
                [string1 appendString:@"称"];
            }
        }
        model.name = string1;
        
        if (arc4random_uniform(2)) {
            if (arc4random_uniform(2)) {
                model.icon = @"001";
            } else {
                if (arc4random_uniform(2)) {
                    model.icon = @"002";
                } else {
                    model.icon = @"003";
                }
            }
        } else {
            if (arc4random_uniform(2)) {
                model.icon = @"010";
            } else {
                if (arc4random_uniform(2)) {
                    model.icon = @"011";
                } else {
                    model.icon = @"012";
                }
            }
        }
        model.ID = [NSString stringWithFormat:@"%ld", (long)count++];
        [self.dataArray addObject:model];
        [mua addObject:[NSIndexPath  indexPathForRow:self.dataArray.count - 1 inSection:0]];
    }
    [self.tableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:self.dataArray.count - 1] animated:YES scrollPosition:UITableViewScrollPositionBottom];
    });
}

@end
