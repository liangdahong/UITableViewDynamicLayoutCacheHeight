//
//  BMBaseTableViewCell.h
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/10.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMModel.h"
#import "BMFriendPraiseListLabel.h"

@interface BMBaseTableViewCell : UITableViewCell

@property (strong, nonatomic) BMModel *model; ///< model

- (void)draw;
- (void)clear;

@end
