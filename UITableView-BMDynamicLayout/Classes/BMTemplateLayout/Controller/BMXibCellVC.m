//
//  BMXibCellVC.m
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/22.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMXibCellVC.h"
#import "UITableView+BMDynamicLayout1.h"
#import "BMModel.h"
#import "BMCell.h"
#import "BMHeaderView.h"
#import "UIFooterView.h"
#import "BMSystemAdaptiveHeightVC.h"

@interface BMXibCellVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <NSMutableArray <BMModel *> *> *dataArray;
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

- (NSMutableArray<NSMutableArray<BMModel *> *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
        int arc = arc4random_uniform(10)+4;
        while (arc--) {
            NSMutableArray *arr1 = @[].mutableCopy;
            int arc1 = arc4random_uniform(3)+4;
            while (arc1--) {
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
                [arr1 addObject:model];
            }
            [_dataArray addObject:arr1];
        }
        
        [_dataArray enumerateObjectsUsingBlock:^(NSMutableArray<BMModel *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj enumerateObjectsUsingBlock:^(BMModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
                obj1.ID = [NSString stringWithFormat:@"%lu-%lu", (unsigned long)idx, idx1];
            }];
        }];
        
    }
    return _dataArray;
}

#pragma mark - 系统delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"++++++++需要cell");
    return [BMCell bm_tableViewCellWithTableView:tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BMCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"---------就要显示 cell");
    cell.model = self.dataArray[indexPath.section][indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    self.dataArray
    
//    [tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:0];
    
    id obj = self.dataArray[0];
    [self.dataArray removeObjectAtIndex:0];
    [self.dataArray insertObject:obj atIndex:1];
    [tableView moveSection:0 toSection:1];
    
//    [self.dataArray removeObjectAtIndex:0];
//    [tableView deleteSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:0];
    
//    [self.dataArray insertObject:self.dataArray[1] atIndex:0];
//    [tableView insertSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:0];
    
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:0];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"========获取高度");
    return [tableView bm_heightForCellWithCellClass:BMCell.class cacheByIndexPath:indexPath configuration:^(__kindof BMCell * _Nonnull cell) {
        cell.model = self.dataArray[indexPath.section][indexPath.row];
    }];
//    return [tableView bm_heightForCellWithCellClass:BMCell.class cacheByIndexPath:indexPath tableViewWidth:UIScreen.mainScreen.bounds.size.width configuration:^(__kindof BMCell *cell) {
//        cell.model = model;
//    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BMHeaderView *view = [BMHeaderView bm_tableViewHeaderFooterViewWithTableView:tableView];
    view.contentView.backgroundColor = [UIColor redColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [tableView bm_heightForHeaderFooterViewWithHeaderFooterViewClass:BMHeaderView.class type:(BMDynamicLayoutTypeHeader) section:section configuration:^(__kindof BMHeaderView * _Nonnull headerFooterView) {
    }];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIFooterView *view = [UIFooterView bm_tableViewHeaderFooterViewWithTableView:tableView];
    view.contentView.backgroundColor = [UIColor blueColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return [tableView bm_heightForHeaderFooterViewWithHeaderFooterViewClass:UIFooterView.class type:(BMDynamicLayoutTypeFooter) section:section configuration:^(__kindof UIFooterView * _Nonnull headerFooterView) {
    }];
}

@end
