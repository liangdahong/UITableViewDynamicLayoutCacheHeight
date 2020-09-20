//
//  BMFriendsCircleVC.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMFriendsCircleVC.h"
#import "BMModel.h"
#import "NSObject+BMExtension.h"
#import "UIView+BMExtension.h"
#import "BMMessage0ImageCell.h"
#import "BMMessage1ImageCell.h"
#import "BMMessage23ImageCell.h"
#import "BMMessage4ImageCell.h"
#import "BMMessage56ImageCell.h"
#import "BMMessage789ImageCell.h"
#import "BMEvaluationCell.h"
#import "BMBaseTableViewCell.h"
#import "UITableView+BMDynamicLoad.h"
#import <UITableViewDynamicLayoutCacheHeight/UITableViewDynamicLayoutCacheHeight.h>
#import <MJRefresh/MJRefresh.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface BMFriendsCircleVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray <BMModel *> *dataSourceArray; ///< dataSourceArray
@property (strong, nonatomic) NSMutableArray *needLoadArr;

@end

@implementation BMFriendsCircleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"BMEvaluationCell" bundle:nil] forCellReuseIdentifier:@"BMEvaluationCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BMMessage0ImageCell" bundle:nil] forCellReuseIdentifier:@"BMMessage0ImageCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BMMessage1ImageCell" bundle:nil] forCellReuseIdentifier:@"BMMessage1ImageCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BMMessage23ImageCell" bundle:nil] forCellReuseIdentifier:@"BMMessage23ImageCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BMMessage4ImageCell" bundle:nil] forCellReuseIdentifier:@"BMMessage4ImageCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BMMessage56ImageCell" bundle:nil] forCellReuseIdentifier:@"BMMessage56ImageCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"BMMessage789ImageCell" bundle:nil] forCellReuseIdentifier:@"BMMessage789ImageCell"];
    
    self.needLoadArr = [@[] mutableCopy];
    __weak typeof(self) weakSelf = self;
    _tableView.hitTestBlock = ^{
        __strong typeof(self) self = weakSelf;
        [self.needLoadArr removeAllObjects];
        [self loadContent];
    };
    
    // load data
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(0, 0), ^(void) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"a" ofType:@"txt"];
          NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
          NSData *JSONData = [content dataUsingEncoding:NSUTF8StringEncoding];
          NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableContainers error:nil];
        self.dataSourceArray = [BMModel bm_modelArrayWithKeyValuesArray:responseJSON[@"postList"]];
          int arc = 3;
          NSMutableArray *muarray = [@[] mutableCopy];
          while (arc--) {
              [muarray addObject:self.dataSourceArray[arc4random_uniform(10)]];
          }
          arc = 100;
          [muarray addObjectsFromArray:self.dataSourceArray];
          while (arc--) {
              [muarray addObject:self.dataSourceArray[arc4random_uniform(10)]];
          }
          self.dataSourceArray = [muarray copy];

          [self.dataSourceArray enumerateObjectsUsingBlock:^(BMModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
              obj.postId = [NSString stringWithFormat:@"%ld_%u", idx, arc4random()];
              [obj.replyList enumerateObjectsUsingBlock:^(BMReplyListModel * _Nonnull obj, NSUInteger idx1, BOOL * _Nonnull stop) {
                  obj.replyId = [NSString stringWithFormat:@"%ld_%ld_%u", idx, idx1, arc4random()];
                  NSMutableString *str = @"".mutableCopy;
                  int a = arc4random_uniform(20)+1;
                  while (a--) {
                      if (arc4random_uniform(2)) {
                          [str appendString:@"评价"];
                      } else {
                          [str appendString:@"信息"];
                      }
                  }
                  obj.content = str.copy;
              }];
              [obj.likeList enumerateObjectsUsingBlock:^(BMLikeListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                  NSMutableString *str = @"".mutableCopy;
                  int a = arc4random_uniform(6)+1;
                  while (a--) {
                      if (arc4random_uniform(2)) {
                          [str appendString:@"梁"];
                      } else {
                          [str appendString:@"德"];
                      }
                  }
                  obj.likerInfo.nickName = str.copy;
              }];
          }];
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
        });
    });
}

// 按需加载 - 如果目标行与当前行相差超过指定行数，只在目标滚动范围的前后指定3行加载。
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    NSIndexPath *ip = [self.tableView indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
    NSIndexPath *cip = [[self.tableView indexPathsForVisibleRows] firstObject];
    NSInteger skipCount = 6;
    if (labs(cip.row-ip.row) > skipCount) {
        NSArray *temp = [self.tableView indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, self.tableView.bm_width, self.tableView.bm_height)];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:temp];
        if (velocity.y<0) {
            NSIndexPath *indexPath = [temp lastObject];
            if (indexPath.row +3 < self.dataSourceArray.count) {
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
        [self.needLoadArr addObjectsFromArray:arr];
    }
}

- (void)drawCell:(UITableViewCell *)cell1 withIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        BMBaseTableViewCell *cell = (BMBaseTableViewCell *)cell1;
        cell.model = self.dataSourceArray[indexPath.section];
        if (self.needLoadArr.count > 0
            && [self.needLoadArr indexOfObject:indexPath] == NSNotFound) {
            [cell clear];
            return;
        }
        [cell draw];
        return;
    }

    BMEvaluationCell *cell = (BMEvaluationCell *)cell1;
    cell.model = self.dataSourceArray[indexPath.section].replyList[indexPath.row - 1];
    if (self.needLoadArr.count > 0
        && [self.needLoadArr indexOfObject:indexPath] == NSNotFound) {
        [cell clear];
        return;
    }    
    [cell draw];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.needLoadArr removeAllObjects];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self loadContent];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    CGPoint p = CGPointZero;
    [self scrollViewWillEndDragging:scrollView withVelocity:scrollView.contentOffset targetContentOffset:&p];
    return YES;
}

- (void)loadContent {
    if (self.tableView.indexPathsForVisibleRows.count<=0) {
        return;
    }
    if (self.tableView.visibleCells&&self.tableView.visibleCells.count>0) {
        for (id temp in [self.tableView.visibleCells copy]) {
            [(BMEvaluationCell *)temp draw];
        }
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray[section].replyList.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 0) {
        BMEvaluationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMEvaluationCell" forIndexPath:indexPath];
        [self drawCell:cell withIndexPath:indexPath];
        return cell;
    }
    BMModel *model = _dataSourceArray[indexPath.section];
    NSInteger count = model.multimedia.picList.count;
    if (count == 0) {
        BMMessage0ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMMessage0ImageCell" forIndexPath:indexPath];
        [self drawCell:cell withIndexPath:indexPath];
        return cell;
    } else if (count == 1) {
        BMMessage1ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMMessage1ImageCell" forIndexPath:indexPath];
        [self drawCell:cell withIndexPath:indexPath];
        return cell;
    } else if (count == 2 || count == 3) {
        BMMessage23ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMMessage23ImageCell" forIndexPath:indexPath];
        [self drawCell:cell withIndexPath:indexPath];
        return cell;
    } else if (count == 4) {
        BMMessage4ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMMessage4ImageCell" forIndexPath:indexPath];
        [self drawCell:cell withIndexPath:indexPath];
        return cell;
    } else if (count == 5 || count == 6) {
        BMMessage56ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMMessage56ImageCell" forIndexPath:indexPath];
        [self drawCell:cell withIndexPath:indexPath];
        return cell;
    } else {
        BMMessage789ImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMMessage789ImageCell" forIndexPath:indexPath];
        [self drawCell:cell withIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMModel *model = _dataSourceArray[indexPath.section];
    if (indexPath.row) {
        return [tableView bm_heightWithCellClass:BMEvaluationCell.class
                                cacheByIndexPath:indexPath
                                   configuration:^(__kindof BMEvaluationCell *cell) {
            cell.model = model.replyList[indexPath.row - 1];
            [cell draw];
        }];
    }
    NSInteger count = model.multimedia.picList.count;
    if (count == 0) {
        return [tableView bm_heightWithCellClass:BMMessage0ImageCell.class
                                cacheByIndexPath:indexPath
                                   configuration:^(__kindof BMMessage0ImageCell *cell) {
            cell.model = model;
            [cell draw];
        }];
    } else if (count == 1) {
        return [tableView bm_heightWithCellClass:BMMessage1ImageCell.class
                                cacheByIndexPath:indexPath
                                   configuration:^(__kindof BMMessage1ImageCell *cell) {
            cell.model = model;
            [cell draw];
        }];
    } else if (count == 2 || count == 3) {
        return [tableView bm_heightWithCellClass:BMMessage23ImageCell.class
                                cacheByIndexPath:indexPath
                                   configuration:^(__kindof BMMessage23ImageCell *cell) {
            cell.model = model;
            [cell draw];
        }];
    } else if (count == 4) {
        return [tableView bm_heightWithCellClass:BMMessage4ImageCell.class
                                cacheByIndexPath:indexPath
                                   configuration:^(__kindof BMMessage4ImageCell *cell) {
            cell.model = model;
            [cell draw];
        }];
    } else if (count == 5 || count == 6) {
        return [tableView bm_heightWithCellClass:BMMessage56ImageCell.class
                                cacheByIndexPath:indexPath
                                   configuration:^(__kindof BMMessage56ImageCell *cell) {
            cell.model = model;
            [cell draw];
        }];
    } else {
        return [tableView bm_heightWithCellClass:BMMessage789ImageCell.class
                                cacheByIndexPath:indexPath
                                   configuration:^(__kindof BMMessage789ImageCell *cell) {
            cell.model = model;
            [cell draw];
        }];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
