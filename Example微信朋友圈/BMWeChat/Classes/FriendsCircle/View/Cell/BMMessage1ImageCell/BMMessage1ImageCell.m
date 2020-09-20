//
//  BMMessage1ImageCell.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/10.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMMessage1ImageCell.h"
#import "BMMessageView.h"
#import "BMFriendPraiseListLabel.h"

@interface BMMessage1ImageCell ()

@property (weak, nonatomic) IBOutlet BMMessageView *messageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthCons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightCons;
@property (weak, nonatomic) IBOutlet BMFriendPraiseListLabel *friendPraiseListLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end

@implementation BMMessage1ImageCell

- (void)draw {
    _messageView.model   = self.model;
    _widthCons.constant  = self.model.size.width;
    _heightCons.constant = self.model.size.height;
    [_friendPraiseListLabel setFriendArray:self.model.likeListNames segmentationString:@"、"];
    _iconImageView.image = [UIImage imageNamed:@"default_app_version.png"];
    self.imageView.userInteractionEnabled = YES;
}

- (void)clear {
    _messageView.model   = nil;
    [_friendPraiseListLabel setFriendArray:nil segmentationString:nil];
    _iconImageView.image = nil;
}

@end
