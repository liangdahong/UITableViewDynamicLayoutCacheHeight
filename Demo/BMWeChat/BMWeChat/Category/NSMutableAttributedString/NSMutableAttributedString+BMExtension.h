//
//  NSMutableAttributedString+BMExtension.h
//  BlueMoonHouse
//
//  Created by elvin on 15/12/5.
//  Copyright © 2015年 bluemoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^BMGetAttributedStringSizeBlock)(NSMutableAttributedString *attributedString, CGSize maxSize);

@interface NSMutableAttributedString (BMExtension)

/**
 *  @author elvin
 *
 *  价格样式的转换：小数点后两位变小，按颜色显示
 *
 *  @param price     价格
 *  @param textColor 显示价格颜色
 *  @param intSize   整数部分的字号
 *
 *  @return 带有特定要是的价格
 */
+ (instancetype)bm_stringWithPriceFormatBM:(float)price textColor:(NSString *)textColor withSize:(CGFloat)size;

/**
 *  创建一个可变字符串
 *
 *  @param str         string
 *  @param font        整体的字体
 *  @param LineSpacing 行间距
 *
 *  !!卡劵详情使用
 *
 *  @return 可变字符串
 */
+ (instancetype)bm_attributedStringWithString:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)LineSpacing;

+ (instancetype)bm_attributedStringWithString:(NSString *)str font:(UIFont *)font;
/**
 *  获取属性字符串需要的尺寸
 *
 *  @param maxSize 最大size
 *
 *  @return 需要的size
 */
- (CGSize)bm_sizeWithMaxSize:(CGSize )maxSize;

/**
 *  为属性字符串设置设置颜色
 *
 *  @param color 颜色
 *  @param range 位置
 */
- (void)bm_setForegroundColorAttribute:(UIColor *)color range:(NSRange)range;

@end
