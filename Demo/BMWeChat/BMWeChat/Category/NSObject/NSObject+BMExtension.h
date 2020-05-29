//
//  NSObject+BMExtension.h
//  BMOnlineManagement
//
//  Created by ___liangdahong on 2017/9/19.
//  Copyright © 2017年 月亮小屋（中国）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BMExtension)

/**
 通过字典来创建一个模型
 */
+ (instancetype)bm_modelWithKeyValues:(id)keyValues;

/**
 通过字典数组来创建一个模型数组
 */
+ (NSMutableArray <__kindof NSObject *> *)bm_modelArrayWithKeyValuesArray:(id)keyValuesArray;

/**
 将模型转成字典
 */
- (NSDictionary *)bm_keyValuesAuto;

/**
 将模型转换为JSON 字符串 @"["a"]"
 */
- (NSString *)bm_JSONString;

@end
