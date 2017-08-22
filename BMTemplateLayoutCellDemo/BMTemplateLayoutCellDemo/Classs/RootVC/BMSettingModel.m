//
//  BMSettingModel.m
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/22.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMSettingModel.h"

@implementation BMSettingModel

+ (instancetype)modelWithTitle:(NSString *)title selector:(SEL)selector {
    BMSettingModel *model = [self new];
    model.title = title;
    model.selector = selector;
    return model;
}
@end
