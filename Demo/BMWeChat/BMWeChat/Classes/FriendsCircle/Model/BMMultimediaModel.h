//
//  BMMultimediaModel.h
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMVideoModel.h"
#import "BMPicListModel.h"

@interface BMMultimediaModel : NSObject

@property (assign, nonatomic) NSInteger picListSize;
@property (strong, nonatomic) BMVideoModel * video;
@property (copy, nonatomic) NSArray <BMPicListModel *> *picList;
@property (copy, nonatomic) NSString *type;

@end
