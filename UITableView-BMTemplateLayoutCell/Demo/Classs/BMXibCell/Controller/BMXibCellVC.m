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
#import "UITableView+BMDynamicLoad.h"

@interface BMXibCellVC () <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *needLoadArr;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray <BMModel *> *dataArray;

@end

@implementation BMXibCellVC
#pragma mark -
#pragma mark - init
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    needLoadArr = [@[] mutableCopy];
    _tableView.hitTestBlock = ^{
        [needLoadArr removeAllObjects];
        [self loadContent];
    };
}

#pragma mark - getters setters

- (NSMutableArray<BMModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
        static NSInteger count = 0;
        int arc = 100;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [BMCell bm_cellWithTableView:tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BMCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self drawCell:cell withIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMModel *model = self.dataArray[indexPath.row];
    return [tableView bm_heightForCellWithCellClass:BMCell.class cacheByIndexPath:indexPath configuration:^(__kindof BMCell *cell) {
        cell.model = model;
        [cell draw];
    }];
}

// 按需加载 - 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载。
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    // 将要滚动到的 NSIndexPath
    NSIndexPath *ip = [self.tableView indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
    // 当前的 NSIndexPath
    NSIndexPath *cip = [[self.tableView indexPathsForVisibleRows] firstObject];
    // 当前位置和结束位置多余 skipCount 就需要按需加载处理（这个数字一般需考虑tableView高度和Cell的平均高度来估计）建议tableView高度 / 最小的Cell的高度
    NSInteger skipCount = 10;
    // 目标index的前后多少行
    NSInteger count = 3;
    if (labs(cip.row-ip.row)>skipCount) {
        NSArray *temp = [self.tableView indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, self.tableView.bm_width, self.tableView.bm_height)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
        if (velocity.y<0) {
            NSIndexPath *indexPath = [temp lastObject];
            if (indexPath.row+count<self.dataArray.count) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+3 inSection:0]];
            }
        } else {
            NSIndexPath *indexPath = [temp firstObject];
            if (indexPath.row>count) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-3 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row-1 inSection:0]];
            }
        }
        [needLoadArr addObjectsFromArray:arr];
    }
}

- (void)drawCell:(BMCell *)cell withIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.dataArray[indexPath.row];
    if (needLoadArr.count > 0
        && [needLoadArr indexOfObject:indexPath] == NSNotFound) {
        [cell clear];
        return;
    }
    [cell draw];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [needLoadArr removeAllObjects];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self loadContent];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    CGPoint p = CGPointZero;
    [self scrollViewWillEndDragging:scrollView withVelocity:scrollView.contentOffset targetContentOffset:&p];
    return YES;
}

- (void)loadContent{
    if (self.tableView.indexPathsForVisibleRows.count<=0) {
        return;
    }
    if (self.tableView.visibleCells&&self.tableView.visibleCells.count>0) {
        for (id temp in [self.tableView.visibleCells copy]) {
            [(BMCell *)temp draw];
        }
    }
}

#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应
@end
