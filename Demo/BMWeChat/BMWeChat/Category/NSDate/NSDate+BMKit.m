//
//  NSDate+BMKit.m
//  BMOnlineManagement
//
//  Created by ___liangdahong on 2017/9/26.
//  Copyright © 2017年 月亮小屋（中国）有限公司. All rights reserved.
//

#import "NSDate+BMKit.h"

@implementation NSDate (BMKit)

- (BOOL)bm_isToday {
    return [self _isDameDateWithFormatType:BMDateFormat_YYYYMMDD otherDate:[NSDate date]];
}

- (BOOL)bm_isDameYearWithDate:(NSDate *)date {
    return [self _isDameDateWithFormatType:BMDateFormat_YYYY otherDate:date];
}

- (BOOL)bm_isDameMonthWithDate:(NSDate *)date {
    return [self _isDameDateWithFormatType:BMDateFormat_YYYYMM otherDate:date];
}

- (BOOL)bm_isDameDayWithDate:(NSDate *)date {
    return [self _isDameDateWithFormatType:BMDateFormat_YYYYMMDD otherDate:date];
}

- (BOOL)bm_isDameHoursWithDate:(NSDate *)date {
    return [self _isDameDateWithFormatType:BMDateFormat_YYYYMMDDHH otherDate:date];
}

- (BOOL)bm_isDameMinutesWithDate:(NSDate *)date {
    return [self _isDameDateWithFormatType:BMDateFormat_YYYYMMDDHHmm otherDate:date];
}

- (BOOL)bm_isDameSecondsWithDate:(NSDate *)date {
    return [self _isDameDateWithFormatType:BMDateFormat_YYYYMMDDHHmmss otherDate:date];
}

- (NSString *)bm_formattingWithFormatType:(BMDateFormatType)formatType {
    NSArray *formats = @[@"yyyy-MM-dd HH:mm:ss",
                         @"yyyy-MM-dd HH:mm",
                         @"yyyy-MM-dd HH",
                         @"yyyy-MM-dd",
                         @"yyyy-MM",
                         @"yyyy"];
    if (formatType >= BMDateFormat_YYYY) {
        formatType = BMDateFormat_YYYY;
    }
    return [self bm_formattingWithFormat:formats[formatType]];
}

- (NSString *)bm_formattingWithFormat:(NSString *)format {
    NSDateFormatter *customDateFormatter = [[NSDateFormatter alloc] init];
    [customDateFormatter setDateFormat:format];
    return [customDateFormatter stringFromDate:self];
}

+ (NSDate *)bm_dateWith13TimeStamp:(NSTimeInterval)time {
    return [self bm_dateWith10TimeStamp:time / 1000.0];
}

+ (NSString *)bm_formattingWith13TimeStamp:(NSTimeInterval)time formatType:(BMDateFormatType)formatType {
    return [[self bm_dateWith13TimeStamp:time] bm_formattingWithFormatType:formatType];
}

+ (NSString *)bm_formattingWith13TimeStamp:(NSTimeInterval)time format:(NSString *)format {
    return [[self bm_dateWith13TimeStamp:time] bm_formattingWithFormat:format];
}

+ (NSDate *)bm_dateWith10TimeStamp:(NSTimeInterval)time {
    return [NSDate dateWithTimeIntervalSince1970:time];
}

+ (NSString *)bm_formattingWith10TimeStamp:(NSTimeInterval)time formatType:(BMDateFormatType)formatType {
    return [[self bm_dateWith10TimeStamp:time] bm_formattingWithFormatType:formatType];
}

+ (NSString *)bm_formattingWith10TimeStamp:(NSTimeInterval)time format:(NSString *)format {
    return [[self bm_dateWith10TimeStamp:time] bm_formattingWithFormat:format];
}

- (BOOL)_isDameDateWithFormatType:(BMDateFormatType)formatType otherDate:(NSDate *)date {
    return [[self bm_formattingWithFormatType:formatType] isEqualToString:[date bm_formattingWithFormatType:formatType]];
}

@end
