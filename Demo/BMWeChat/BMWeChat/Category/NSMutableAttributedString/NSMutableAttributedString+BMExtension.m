//
//  NSMutableAttributedString+BMExtension.m
//  BlueMoonHouse
//
//  Created by elvin on 15/12/5.
//  Copyright © 2015年 bluemoon. All rights reserved.
//

#import "NSMutableAttributedString+BMExtension.h"

@implementation NSMutableAttributedString (BMExtension)

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
+ (instancetype)bm_stringWithPriceFormatBM:(float)price textColor:(NSString *)textColor withSize:(CGFloat)size {
    
    NSString *priceStr = [NSString stringWithFormat:@"￥%.2f",price/100];
    
    NSMutableAttributedString *priceAttributeStr = [[NSMutableAttributedString alloc] initWithString:priceStr];
    
    //把￥符号向下偏移2个像素，做到和价格底部对齐
    [priceAttributeStr addAttribute:NSBaselineOffsetAttributeName value:@(-2) range:NSMakeRange(0, 1)];
    //整数部分字体大小
    [priceAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size] range:NSMakeRange(0, priceStr.length-2)];
    //小数部分字体大小
    [priceAttributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:size-2] range:NSMakeRange(priceStr.length-2, 2)];
    
    //字体颜色
    [priceAttributeStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, priceAttributeStr.length)];
    return priceAttributeStr;
}

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
 */+ (instancetype)bm_attributedStringWithString:(NSString *)str font:(UIFont *)font lineSpacing:(CGFloat)LineSpacing
{
    if (!str) return nil;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    // 设置行间距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    
    // 设置字体
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}

+ (instancetype)bm_attributedStringWithString:(NSString *)str font:(UIFont *)font
{
    if (!str) return nil;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    // 设置字体
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}


/**
 *  获取属性字符串的尺寸
 *
 *  @param attributedString 属性字符串
 *  @param maxSize          最大size
 */
- (CGSize)bm_sizeWithMaxSize:(CGSize )maxSize
{
    CGRect frame =  [self boundingRectWithSize:maxSize
                                       options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                       context:nil];
    return frame.size;
}

- (void)bm_setForegroundColorAttribute:(UIColor *)color range:(NSRange)range
{
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}
@end
