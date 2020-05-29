//
//  BMMessage56ImageCell.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/10.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMMessage56ImageCell.h"
#import "BMMessageView.h"

@interface BMMessage56ImageCell ()

@property (weak, nonatomic) IBOutlet BMMessageView *messageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (weak, nonatomic) IBOutlet UIImageView *imageView6;
@property (weak, nonatomic) IBOutlet BMFriendPraiseListLabel *friendPraiseListLabel;

@end

@implementation BMMessage56ImageCell

- (void)draw {
    _messageView.model   = self.model;
    _imageView6.hidden = (self.model.multimedia.picList.count == 5);
    [_friendPraiseListLabel setFriendArray:self.model.likeListNames segmentationString:@"、"];
    _imageView1.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView2.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView3.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView4.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView5.image = [UIImage imageNamed:@"default_app_version.png"];
    _imageView6.image = [UIImage imageNamed:@"default_app_version.png"];
}
- (void)clear {
    _messageView.model   = nil;
    _imageView1.image = nil;
    _imageView2.image = nil;
    _imageView3.image = nil;
    _imageView4.image = nil;
    _imageView5.image = nil;
    _imageView6.image = nil;
    [_friendPraiseListLabel setFriendArray:nil segmentationString:nil];
}

@end
