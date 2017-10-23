//
//  BMRootVC.m
//  BMDragCellCollectionViewDemo
//
//  Created by ___liangdahong on 2017/8/22.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import "BMRootVC.h"
#import "BMSettingModel.h"
#import "UITableViewCell+BMReusable.h"
#import "BMXibCellVC.h"
#import "BMMasonryCellVC.h"
#import "BMMasonryHeaderFooterVC.h"
#import "BMXibHeaderFooterVC.h"

@interface BMRootVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray <NSArray<BMSettingModel *>*> *modelArray; ///< modelArray

@end

@implementation BMRootVC

#pragma mark -

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BMTemplateLayoutCell";
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - getters setters

- (NSArray<NSArray<BMSettingModel *> *> *)modelArray {
    if (!_modelArray) {
        _modelArray = @[
                        @[
                            [BMSettingModel modelWithTitle:@"xib cell" selector:@selector(xibCell:)],
                            [BMSettingModel modelWithTitle:@"masonry cell" selector:@selector(masonryCell:)]
                            ],
                        @[
                            [BMSettingModel modelWithTitle:@"xib header footer" selector:@selector(xibHeaderFooter:)],
                            [BMSettingModel modelWithTitle:@"masonry header footer" selector:@selector(masonryHeaderFooter:)],
                          ]
                        ];
    }
    return _modelArray;
}

#pragma mark - 系统delegate

#pragma mark - UITableViewDataSource UITableViewDelegate
#pragma mark - UITableViewDataSource UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell bm_cellWithTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    BMSettingModel *model = self.modelArray[indexPath.section][indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BMSettingModel *model = self.modelArray[indexPath.section][indexPath.row];
    if (!model.selector) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Demo 未完成" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:model.selector withObject:model];
#pragma clang diagnostic pop
}

#pragma mark - UITableViewDelegate

#pragma mark - 自定义delegate

#pragma mark - 公有方法

#pragma mark - 私有方法

- (void)xibCell:(BMSettingModel *)model {
    [self.navigationController pushViewController:[BMXibCellVC new] animated:YES];
}

- (void)masonryCell:(BMSettingModel *)model {
    [self.navigationController pushViewController:[BMMasonryCellVC new] animated:YES];
}

- (void)xibHeaderFooter:(BMSettingModel *)model {
    [self.navigationController pushViewController:[BMXibHeaderFooterVC new] animated:YES];
}

- (void)masonryHeaderFooter:(BMSettingModel *)model {
    [self.navigationController pushViewController:[BMMasonryHeaderFooterVC new] animated:YES];
}

- (void)setUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Github地址" style:0 target:self action:@selector(githubClick)];
}

- (void)githubClick {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/asiosldh/UITableView-BMTemplateLayoutCell"]];
}

#pragma mark - 事件响应

@end
