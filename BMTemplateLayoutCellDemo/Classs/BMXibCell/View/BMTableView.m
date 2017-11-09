//
//  BMTableView.m
//  tableview
//
//  Created by __liangdahong on 2017/11/9.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import "BMTableView.h"

@implementation BMTableView

//用户触摸时第一时间加载内容
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.block) {
        self.block();
    }
    return [super hitTest:point withEvent:event];
}

@end
