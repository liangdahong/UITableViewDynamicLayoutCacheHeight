//
//  BMCollectionViewVC.m
//  UITableView-BMTemplateLayoutCell
//
//  Created by Mac on 2019/8/29.
//  Copyright © 2019年 ( https://liangdahong.com ). All rights reserved.
//

#import "BMCollectionViewVC.h"
#import "BMCollectionCell.h"
#import "UITableView+BMTemplateLayoutCell.h"

@interface BMCollectionViewVC () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray <NSString *> *histroyArray; ///< histroyArray

@end

@implementation BMCollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.collectionViewLayout = BMLeftCollectionViewFlowLayout.new;
    int arc = arc4random_uniform(100)+40;
    self.histroyArray = @[].mutableCopy;
    while (arc--) {
        int arc1 = arc4random_uniform(3);
        NSMutableString *str = @"我".mutableCopy;
        while (arc1--) {
            [str appendString:@"我"];
        }
        if (arc4random_uniform(5) == 0) {
            arc1 = arc4random_uniform(60);
            while (arc1--) {
                [str appendString:@"我"];
            }
        }
        [ self.histroyArray addObject:str];
    }
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.histroyArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BMCollectionCell *cell = [BMCollectionCell bm_collectionViewCellWithCollectionView:collectionView forIndexPath:indexPath];
    cell.titleLabel1.text = [NSString stringWithFormat:@"%ld-%@", (long)indexPath.item, self.histroyArray[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView bm_sizeForCellWithCellClass:BMCollectionCell.class
                                              maxWidth:([UIScreen mainScreen].bounds.size.width-10)
                                                   key:[NSString stringWithFormat:@"%ld-%@", (long)indexPath.item, self.histroyArray[indexPath.row]]
                                         configuration:^(__kindof BMCollectionCell *cell) {
                                             cell.titleLabel1.text = [NSString stringWithFormat:@"%ld-%@", (long)indexPath.item, self.histroyArray[indexPath.row]];
                                         }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // 临时保存
    NSString *key = self.histroyArray[indexPath.item];
    if (indexPath.item) {
        // 删除指定位置的元素
        [self.histroyArray removeObjectAtIndex:indexPath.item];
        // 插入元素
        [self.histroyArray insertObject:key atIndex:0];
        // 刷新
        [collectionView reloadData];
    }
    // 开始搜索
}

@end
