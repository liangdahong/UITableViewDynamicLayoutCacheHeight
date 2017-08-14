
//
//  UIScrollView+BMExtension.m
//  BMTemplateLayoutCellDemo
//
//  Created by http://idhong.com/ on 2017/8/14.
//  Copyright © 2017年 https://github.com/asiosldh/UITableView-BMTemplateLayoutCell All rights reserved.
//

#import "UIScrollView+BMExtension.h"

@implementation UIScrollView (BMExtension)

- (void)bm_scrollToBottom {
    [self bm_scrollToBottomAnimated:YES];
}

- (void)bm_scrollToBottomAnimated:(BOOL)animated {
    if (self.contentSize.height <=  CGRectGetHeight(self.bounds)) {
        return;
    }
    CGPoint off = self.contentOffset;
    off.y = self.contentSize.height - self.bounds.size.height;
    [self setContentOffset:off animated:animated];
}

@end
