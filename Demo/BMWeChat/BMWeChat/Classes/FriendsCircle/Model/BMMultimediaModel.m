//
//  BMMultimediaModel.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMMultimediaModel.h"

@implementation BMMultimediaModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"picList": BMPicListModel.class,
             };
}

@end
