//
//  NSObject+BMExtension.m
//  BMOnlineManagement
//
//  Created by ___liangdahong on 2017/9/19.
//  Copyright © 2017年 月亮小屋（中国）有限公司. All rights reserved.
//

#import "NSObject+BMExtension.h"
#import <MJExtension/MJExtension.h>

@implementation NSObject (BMExtension)

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (NSMutableArray <__kindof NSObject *> *)bm_modelArrayWithKeyValuesArray:(id)keyValuesArray {
    return [self mj_objectArrayWithKeyValuesArray:keyValuesArray];
}

+ (instancetype)bm_modelWithKeyValues:(id)keyValues {
    return [self mj_objectWithKeyValues:keyValues];
}

- (NSDictionary *)bm_keyValuesAuto {
    return [self mj_keyValues];
}

- (NSString *)bm_JSONString {
    return [self mj_JSONString];
}

@end
