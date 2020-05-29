//
//  BMReplyListModel.h
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMPosterInfoModel.h"

@interface BMReplyListModel : NSObject

@property (copy, nonatomic) NSString * content;
@property (copy, nonatomic) NSString * replyId;
@property (assign, nonatomic) BOOL isOwn;
@property (assign, nonatomic) NSInteger replyTime;
@property (strong, nonatomic) BMPosterInfoModel *previousInfo;
@property (strong, nonatomic) BMPosterInfoModel *replierInfo;
@property (strong, nonatomic, readonly) NSMutableAttributedString *contentAtt; ///< <#Description#>

@end
