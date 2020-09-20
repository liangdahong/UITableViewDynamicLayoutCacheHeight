//
//  BMMessage789ImageCell.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/10.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMMessage789ImageCell.h"
#import "BMMessageView.h"

@interface BMMessage789ImageCell ()

@property (weak, nonatomic) IBOutlet BMMessageView *messageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (weak, nonatomic) IBOutlet UIImageView *imageView6;
@property (weak, nonatomic) IBOutlet UIImageView *imageView7;
@property (weak, nonatomic) IBOutlet UIImageView *imageView8;
@property (weak, nonatomic) IBOutlet UIImageView *imageView9;
@property (weak, nonatomic) IBOutlet BMFriendPraiseListLabel *friendPraiseListLabel;

@end

@implementation BMMessage789ImageCell

- (void)draw {
    _messageView.model   = self.model;
    NSInteger count = self.model.multimedia.picList.count;
    _imageView1.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView2.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView3.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView4.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView5.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView6.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView7.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView8.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView9.image = [UIImage imageNamed:@"default_app_version.png"];
    if (count == 7) {
        _imageView8.hidden = YES;
        _imageView9.hidden = YES;
    } else if (count == 8) {
        _imageView8.hidden = NO;
        _imageView9.hidden = YES;
    } else if (count == 9) {
        _imageView8.hidden = NO;
        _imageView9.hidden = NO;
    }
    [_friendPraiseListLabel setFriendArray:self.model.likeListNames segmentationString:@"、"];
}

- (void)clear {
    _messageView.model   = nil;
    _imageView1.image = nil;
    _imageView2.image = nil;
    _imageView3.image = nil;
    _imageView4.image = nil;
    _imageView5.image = nil;
    _imageView6.image = nil;
    _imageView7.image = nil;
    _imageView8.image = nil;
    _imageView9.image = nil;
    [_friendPraiseListLabel setFriendArray:nil segmentationString:nil];
}

@end
