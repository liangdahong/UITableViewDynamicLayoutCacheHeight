//
//  YYYTableView.m
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by mac on 2020/4/4.
//  Copyright © 2020 liangdahong. All rights reserved.
//

#import "YYYTableView.h"

@implementation YYYTableView

- (void)reloadData {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super reloadData];
}

- (NSInteger)numberOfSections {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    return super.numberOfSections;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    super.delegate = delegate;
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    super.dataSource = dataSource;
    NSLog(@"%@", NSStringFromSelector(_cmd));
}


@end
