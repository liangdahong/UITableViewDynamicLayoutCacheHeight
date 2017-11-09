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
#import "BMTableView.h"

@interface BMXibCellVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *needLoadArr;
    BOOL scrollToToping;
}

@property (weak, nonatomic) IBOutlet BMTableView *tableView;
@property (strong, nonatomic) NSMutableArray <BMModel *> *dataArray;

@end

@implementation BMXibCellVC
#pragma mark -
#pragma mark - init
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    needLoadArr = [@[] mutableCopy];
    _tableView.block = ^{
        if (!scrollToToping) {
            [needLoadArr removeAllObjects];
            [self loadContent];
        }
    };
    _tableView.scrollsToTop = NO;
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

//按需加载 - 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载。
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    NSIndexPath *ip = [self.tableView indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
    
    NSIndexPath *cip = [[self.tableView indexPathsForVisibleRows] firstObject];
    
    NSInteger skipCount = 8;
    if (labs(cip.row-ip.row)>skipCount) {
        NSArray *temp = [self.tableView indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, self.tableView.bm_width, self.tableView.bm_height)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
        if (velocity.y<0) {
            NSIndexPath *indexPath = [temp lastObject];
            if (indexPath.row+3<self.dataArray.count) {
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+1 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+2 inSection:0]];
                [arr addObject:[NSIndexPath indexPathForRow:indexPath.row+3 inSection:0]];
            }
        } else {
            NSIndexPath *indexPath = [temp firstObject];
            if (indexPath.row>3) {
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
    // clear
//    cell.TESTLABEL.text = nil;
    // 如果没有加载的有 而且不包含当前
    if (needLoadArr.count > 0
        && [needLoadArr indexOfObject:indexPath] == NSNotFound) {
//        cell.model = self.dataArray[indexPath.row];
        [cell clear];
        return;
    }
    if (scrollToToping) {
        [cell clear];
        return;
    } 
    [cell draw];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [needLoadArr removeAllObjects];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    scrollToToping = NO;
    [self loadContent];
}

- (void)loadContent{
    if (scrollToToping) {
        return;
    }
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

- (void)addModelClock {
    static NSInteger count = 0;
    int arc = 20;
    NSMutableArray *mua = [@[] mutableCopy];
    while (arc--) {
        
        BMModel *model = [BMModel new];
        int arci = arc4random_uniform(60)+10;
        NSMutableString *string = [NSMutableString string];
        while (arci--) {
            if (arc4random_uniform(2)) {
                [string appendString:@"消称称称称"];
            } else {
                [string appendString:@"息称称称称称"];
            }
        }
        [string appendString:@"。[我的的的的]"];

        model.desc = string;
        int arcd = arc4random_uniform(20)+10;
        NSMutableString *string1 = [NSMutableString string];
        while (arcd--) {
            if (arc4random_uniform(2)) {
                [string1 appendString:@"名称称称称"];
            } else {
                [string1 appendString:@"称称称"];
            }
        }
        
        [string1 appendString:@"。[我的的的的]"];
        
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
