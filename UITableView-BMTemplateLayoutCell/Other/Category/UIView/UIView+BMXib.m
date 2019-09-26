//
//  UIView+BMXib.m
//  UITableView-BMTemplateLayoutCell
//
//  Created by liangdahong on 2019/9/5.
//  Copyright © 2019 ( https://liangdahong.com ). All rights reserved.
//

#import "UIView+BMXib.h"

@implementation UIView (BMXib)

- (CGFloat)bm_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setBm_cornerRadius:(CGFloat)bm_cornerRadius {
    self.layer.cornerRadius = bm_cornerRadius;
    self.layer.masksToBounds = YES;
}

@end
