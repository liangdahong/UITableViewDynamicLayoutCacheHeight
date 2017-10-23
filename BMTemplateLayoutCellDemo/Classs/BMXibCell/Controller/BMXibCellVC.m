//
//  BMXibCellVC.m
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/22.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMXibCellVC.h"
#import "UIView+BMExtension.h"
#import "UITableView+BMTemplateLayoutCell.h"
#import "UIScrollView+BMExtension.h"
#import "UITableViewCell+BMReusable.h"
#import "BMModel.h"
#import "BMCell.h"

@interface BMXibCellVC () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <BMModel *> *dataArray;

@end

@implementation BMXibCellVC
#pragma mark -
#pragma mark - init
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"加一点数据" style:0 target:self action:@selector(addModelClock)];
}

#pragma mark - getters setters

- (NSMutableArray<BMModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}

#pragma mark - 系统delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BMCell bm_cellWithTableView:tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BMCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.dataArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMModel *model = self.dataArray[indexPath.row];
    return [tableView bm_heightForCellWithCellClass:BMCell.class cacheByKey:model.ID configuration:^(__kindof BMCell *cell) {
        cell.model = model;
    }];
}

#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应

- (void)addModelClock {
    static NSInteger count = 0;
    int arc = 20;
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
            model.icon = [NSString stringWithFormat:@"%d.jpg", arc4random_uniform(8) + 1];
        } else {
            model.icon = [NSString stringWithFormat:@"%d.png", arc4random_uniform(5) + 1];
        }
        model.ID = [NSString stringWithFormat:@"%ld", (long)count++];
        [self.dataArray addObject:model];
        [mua addObject:[NSIndexPath  indexPathForRow:self.dataArray.count - 1 inSection:0]];
    }
    [self.tableView reloadData];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionBottom];
    });
}

@end
