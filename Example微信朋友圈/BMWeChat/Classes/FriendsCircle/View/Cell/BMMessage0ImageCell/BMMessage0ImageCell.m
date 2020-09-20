//
//  BMMessage0ImageCell.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/10.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMMessage0ImageCell.h"
#import "BMMessageView.h"
#import "BMFriendPraiseListLabel.h"

@interface BMMessage0ImageCell ()

@property (weak, nonatomic) IBOutlet BMMessageView *messageView;
@property (weak, nonatomic) IBOutlet BMFriendPraiseListLabel *friendPraiseListLabel;

@end

@implementation BMMessage0ImageCell

- (void)draw {
    _messageView.model   = self.model;
    [_friendPraiseListLabel setFriendArray:self.model.likeListNames segmentationString:@"、"];
}

- (void)clear {
    _messageView.model   = nil;
    [_friendPraiseListLabel setFriendArray:nil segmentationString:nil];
}

@end
