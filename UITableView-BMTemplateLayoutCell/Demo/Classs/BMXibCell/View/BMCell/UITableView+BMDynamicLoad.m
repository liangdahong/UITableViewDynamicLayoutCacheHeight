//
//  UITableView+BMDynamicLoad.m
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/11/28.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "UITableView+BMDynamicLoad.h"
#import <objc/runtime.h>

@interface BMDynamicLoadTableView : UITableView

@end

@implementation BMDynamicLoadTableView

// 用户触摸时第一时间加载内容
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    !self.hitTestBlock ? : self.hitTestBlock();
    return [super hitTest:point withEvent:event];
}

@end

@implementation UITableView (BMDynamicLoad)

- (dispatch_block_t)hitTestBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHitTestBlock:(dispatch_block_t)hitTestBlock {
    objc_setAssociatedObject(self, @selector(hitTestBlock), hitTestBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    object_setClass(self, BMDynamicLoadTableView.class);
}

@end
