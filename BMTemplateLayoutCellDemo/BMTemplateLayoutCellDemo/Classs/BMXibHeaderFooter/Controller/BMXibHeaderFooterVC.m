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

@interface BMXibHeaderFooterVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BMXibHeaderFooterVC


#pragma mark -

#pragma mark - 生命周期

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setUI];
}

#pragma mark - getters setters

#pragma mark - 系统delegate

#pragma mark - UITableViewDataSource UITableViewDelegate
#pragma mark - UITableViewDataSource UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.contentView.backgroundColor = [UIColor grayColor];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BMXibHeader *xibHeader = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BMXibHeader"];
    if (!xibHeader) {
        NSLog(@"xibHeader alloc");
        xibHeader = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BMXibHeader.class) owner:nil options:nil] firstObject];
    }
    return xibHeader;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [tableView bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:BMXibHeader.class cacheByKey:@"BMXibHeader" configuration:^(__kindof BMXibHeader *headerFooterView) {
        
    }];
}

#pragma mark - UITableViewDelegate



#pragma mark - 自定义delegate

#pragma mark - 公有方法

#pragma mark - 私有方法

- (void)setUI {
    
}

#pragma mark - 事件响应

@end
