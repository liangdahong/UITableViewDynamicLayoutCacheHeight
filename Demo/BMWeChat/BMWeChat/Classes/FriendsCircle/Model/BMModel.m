//
//  BMModel.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMModel.h"
#import "NSDate+BMKit.h"
#import "BMMessageView.h"


@implementation BMModel
{
    NSString *_timeStr;
    CGSize _SIZE;
    NSArray *likeListNames;
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"replyList": BMReplyListModel.class,
             @"likeList": BMLikeListModel.class,
             };
}

- (NSString *)timeStr {
    if (!_timeStr) {
        _timeStr = [NSDate bm_formattingWith13TimeStamp:self.commitTime formatType:BMDateFormat_YYYYMMDDHHmm];
    }
    return _timeStr;
}

- (CGSize)size {
    if (CGSizeEqualToSize(_SIZE, CGSizeZero)) {
        CGFloat width  = self.multimedia.picList[0].thumbnail.width;
        CGFloat height = self.multimedia.picList[0].thumbnail.height;
        if (height >0 && width >0) {
            if (height > width) {
                _SIZE = CGSizeMake((width*180*SCREEN_SCALE) / height, 180 * SCREEN_SCALE);
            } else {
                _SIZE = CGSizeMake(180 * SCREEN_SCALE, (height*180*SCREEN_SCALE) / width);
            }
        } else{
            _SIZE = CGSizeMake(180 * SCREEN_SCALE, 180 * SCREEN_SCALE);
        }
    }
    return _SIZE;
}

- (NSArray<NSString *> *)likeListNames {
    if (!likeListNames) {
        NSMutableArray *arr = @[].mutableCopy;
        if (self.likeList.count) {
            [arr addObject:@"💙"];
        }
        [self.likeList enumerateObjectsUsingBlock:^(BMLikeListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [arr addObject:obj.likerInfo.nickName];
        }];
        likeListNames = arr.copy;
    }
    return likeListNames;
}

@end
