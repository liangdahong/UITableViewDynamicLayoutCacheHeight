//
//  BMMessageView.h
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMModel.h"
#import <XXNibBridge/XXNibBridge.h>

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_SCALE            (SCREEN_WIDTH/320.f)

@interface BMMessageView : UIView <XXNibBridge>

@property (strong, nonatomic) BMModel *model; ///< model

@end
