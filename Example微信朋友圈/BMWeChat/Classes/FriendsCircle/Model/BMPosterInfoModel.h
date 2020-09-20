//
//  BMPosterInfoModel.h
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMIconModel.h"

@interface BMPosterInfoModel : NSObject

@property (strong, nonatomic) BMIconModel *icon; ///< 头像
@property (copy, nonatomic) NSString *nickName;  ///< 昵称
@property (copy, nonatomic) NSString *userId;    ///< 用户id

@end
