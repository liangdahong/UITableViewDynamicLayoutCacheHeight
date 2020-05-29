//
//  BMEvaluationCell.h
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMReplyListModel.h"

@interface BMEvaluationCell : UITableViewCell

@property (strong, nonatomic) BMReplyListModel *model; ///< model
- (void)draw;
- (void)clear;
@end

