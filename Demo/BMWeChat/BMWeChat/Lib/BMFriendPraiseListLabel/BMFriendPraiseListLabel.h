//
//  BMFriendPraiseListLabel.h
//  TTTAttributedLabelDemo
//
//  Created by ___liangdahong on 2017/5/19.
//  Copyright © 2017年 https://github.com/asiosldh/TTTAttributedLabelDemo All rights reserved
//

#import <UIKit/UIKit.h>

/**
 点击block

 @param index 点击的 index
 */
typedef void(^BMFriendPraiseClickBlock)(NSUInteger index);

/**
 内容微信朋友圈点赞列表label
 */
@interface BMFriendPraiseListLabel : UILabel

@property (copy, nonatomic) NSString           *text NS_UNAVAILABLE;
@property (copy, nonatomic) NSAttributedString *attributedText NS_UNAVAILABLE;

/**
 @{NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:15.0f]}
 */
@property (strong, nonatomic) NSDictionary <NSString *, id> *attributes;

/**
 @{NSForegroundColorAttributeName : [UIColor blueColor], NSFontAttributeName : [UIFont systemFontOfSize:15.0f]}
 */
@property (strong, nonatomic) NSDictionary <NSString *, id> *normalAttributes;

/**
@{NSBackgroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:15.0f]}
 */
@property (strong, nonatomic) NSDictionary <NSString *, id> *highlightedAttributes;

/**
 点击block
 */
@property (copy, nonatomic) BMFriendPraiseClickBlock friendPraiseClickBlock;

/**
 配置数据源

 @param friendArray 点赞数组
 @param segmentationString 分割字符串 “，、”
 */
- (void)setFriendArray:(NSArray <NSString *> *)friendArray segmentationString:(NSString *)segmentationString;

@end
