//
//  BMSettingModel.h
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/22.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMSettingModel : NSObject

@property (copy, nonatomic) NSString *title; ///< 标题
@property (assign, nonatomic) SEL selector;  ///< selector

+ (instancetype)modelWithTitle:(NSString *)title selector:(SEL)selector;

@end
