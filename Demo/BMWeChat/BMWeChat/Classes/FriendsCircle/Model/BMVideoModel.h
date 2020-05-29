//
//  BMVideoModel.h
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMIconModel.h"

@interface BMVideoModel : NSObject

@property (strong, nonatomic) BMIconModel *firstFrame;
@property (copy, nonatomic) NSString * videoUrl;

@end
