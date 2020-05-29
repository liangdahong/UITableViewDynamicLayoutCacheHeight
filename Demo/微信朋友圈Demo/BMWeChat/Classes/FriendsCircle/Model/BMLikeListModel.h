//
//  BMLikeListModel.h
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMPosterInfoModel.h"

@interface BMLikeListModel : NSObject

@property (assign, nonatomic) BOOL    isOwn; ///< 是否本人点赞
@property (copy, nonatomic) NSString * likeId; ///< 点赞id
@property (assign, nonatomic) NSInteger likeTime; ///< 点赞时间
@property (strong, nonatomic) BMPosterInfoModel * likerInfo; ///< 点赞人信息
@end
