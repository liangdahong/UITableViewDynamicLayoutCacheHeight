//
//  BMPicListModel.h
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMIconModel.h"

@interface BMPicListModel : NSObject

@property (strong, nonatomic) BMIconModel * original;
@property (strong, nonatomic) BMIconModel * thumbnail;

@end
