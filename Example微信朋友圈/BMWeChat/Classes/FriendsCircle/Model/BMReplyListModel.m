//
//  BMReplyListModel.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMReplyListModel.h"
#import "NSMutableAttributedString+BMExtension.h"

@implementation BMReplyListModel
{
    NSMutableAttributedString *contentAtt;
}

- (NSMutableAttributedString *)contentAtt {
    if (!contentAtt) {
        NSString *str = [NSString stringWithFormat:@"%@: %@", self.replierInfo.nickName, self.content];
        contentAtt = [NSMutableAttributedString bm_attributedStringWithString:str font:[UIFont systemFontOfSize:13]];
        [contentAtt bm_setForegroundColorAttribute:[UIColor orangeColor] range:NSMakeRange(0, self.replierInfo.nickName.length + 1)];
        [contentAtt bm_setForegroundColorAttribute:[UIColor grayColor] range:NSMakeRange(self.replierInfo.nickName.length + 1, str.length - self.replierInfo.nickName.length - 1)];
    }
    return contentAtt;
}

@end
