//
//  UIView+BMExtension.h
//  CharmingWoman
//
//  Created by c on 15-1-26.
//  Copyright © 2017年 https://github.com/asiosldh/UITableView-BMTemplateLayoutCell All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BMExtension)

// 快速获取及设置 view frame
@property (assign, nonatomic, setter=bm_setX:)        CGFloat bm_x;
@property (assign, nonatomic, setter=bm_setY:)        CGFloat bm_y;
@property (assign, nonatomic, setter=bm_setWidth:)    CGFloat bm_width;
@property (assign, nonatomic, setter=bm_setHeight:)   CGFloat bm_height;
@property (assign, nonatomic, setter=bm_setSize:)     CGSize  bm_size;
@property (assign, nonatomic, setter=bm_setOrigin:)   CGPoint bm_origin;
@property (assign, nonatomic, setter=bm_setCenterX:)  CGFloat bm_centerX;
@property (assign, nonatomic, setter=bm_setCenterY:)  CGFloat bm_centerY;

@end
