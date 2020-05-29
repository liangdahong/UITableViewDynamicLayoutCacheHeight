//
//  BMModel.h
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMReplyListModel.h"
#import "BMLikeListModel.h"
#import "BMMultimediaModel.h"
#import "BMPosterInfoModel.h"
#import <UIKit/UIKit.h>

/**
 帖子
 */
@interface BMModel : NSObject

@property (assign, nonatomic) NSInteger commitTime;                    ///< 发帖时间
@property (copy, nonatomic) NSString * content;                        ///< 文字内容
@property (assign, nonatomic) BOOL isCollected;                        ///< 是否已收藏
@property (assign, nonatomic) BOOL isLiked;                            ///< 是否已点赞
@property (assign, nonatomic) BOOL isOwn;                              ///< 是否本人帖子
@property (assign, nonatomic) BOOL isStickie;                          ///< 是否置顶
@property (assign, nonatomic) NSInteger likeNum;                       ///< 点赞数量
@property (copy, nonatomic) NSString * postId;                         ///< 帖子ID
@property (assign, nonatomic) NSInteger replyNum;                      ///< 评论数量
@property (assign, nonatomic) NSInteger star;                          ///< 总星级评分(大于0为晒单贴)
@property (strong, nonatomic) BMMultimediaModel *multimedia;           ///< 多媒体内容
@property (strong, nonatomic) BMPosterInfoModel *posterInfo;           ///< 发帖人信息
@property (strong, nonatomic) NSArray <BMReplyListModel *> *replyList; ///< 评论列表
@property (strong, nonatomic) NSArray <BMLikeListModel *> *likeList;   ///< 点赞列表

@property (copy, nonatomic, readonly) NSString *timeStr; ///< <#Description#>
@property (assign, nonatomic, readonly) CGSize size; ///< <#Description#>
@property (strong, nonatomic, readonly) NSArray <NSString *> *likeListNames; ///< <#Description#>

@end
