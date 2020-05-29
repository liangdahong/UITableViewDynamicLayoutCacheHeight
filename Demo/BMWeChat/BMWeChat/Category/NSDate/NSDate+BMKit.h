//
//  NSDate+BMKit.h
//  BMOnlineManagement
//
//  Created by ___liangdahong on 2017/9/26.
//  Copyright © 2017年 月亮小屋（中国）有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 输出格式
 
 - BMDateFormat_YYYYMMDDHHmmss: @"yyyy-MM-dd HH:mm:ss"
 - BMDateFormat_YYYYMMDDHHmm:   @"yyyy-MM-dd HH:mm"
 - BMDateFormat_YYYYMMDDHH:     @"yyyy-MM-dd HH"
 - BMDateFormat_YYYYMMDD:       @"yyyy-MM-dd"
 - BMDateFormat_YYYYMM:         @"yyyy-MM"
 - BMDateFormat_YYYY:           @"yyyy"
 */
typedef NS_ENUM(NSInteger, BMDateFormatType) {
    BMDateFormat_YYYYMMDDHHmmss = 0,
    BMDateFormat_YYYYMMDDHHmm,
    BMDateFormat_YYYYMMDDHH,
    BMDateFormat_YYYYMMDD,
    BMDateFormat_YYYYMM,
    BMDateFormat_YYYY,
};

/**
 NSDate 的工具类
 */
@interface NSDate (BMKit)

@property (assign, nonatomic, readonly) BOOL bm_isToday; ///< 是否是今天

- (BOOL)bm_isDameYearWithDate:(NSDate *)date;    ///< 是否为同一年
- (BOOL)bm_isDameMonthWithDate:(NSDate *)date;   ///< 是否为同一月
- (BOOL)bm_isDameDayWithDate:(NSDate *)date;     ///< 是否为同一天
- (BOOL)bm_isDameHoursWithDate:(NSDate *)date;   ///< 是否为同一小时
- (BOOL)bm_isDameMinutesWithDate:(NSDate *)date; ///< 是否为同一分钟
- (BOOL)bm_isDameSecondsWithDate:(NSDate *)date; ///< 是否为同一秒钟

- (NSString *)bm_formattingWithFormatType:(BMDateFormatType)formatType; ///< 格式化self
- (NSString *)bm_formattingWithFormat:(NSString *)format; ///< 格式化self 格式类型为自定义

+ (NSDate   *)bm_dateWith13TimeStamp:(NSTimeInterval)time; ///< 13位的时间戳转化为 NSDate
+ (NSString *)bm_formattingWith13TimeStamp:(NSTimeInterval)time formatType:(BMDateFormatType)formatType; ///< 13位的时间戳格式化
+ (NSString *)bm_formattingWith13TimeStamp:(NSTimeInterval)time format:(NSString *)format; ///< 13位的时间戳格式化 格式类型为自定义

+ (NSDate   *)bm_dateWith10TimeStamp:(NSTimeInterval)time; ///< 10位的时间戳转化为 NSDate
+ (NSString *)bm_formattingWith10TimeStamp:(NSTimeInterval)time formatType:(BMDateFormatType)formatType; ///< 10位的时间戳格式化
+ (NSString *)bm_formattingWith10TimeStamp:(NSTimeInterval)time format:(NSString *)format; ///< 10位的时间戳格式化 格式类型为自定义

@end
