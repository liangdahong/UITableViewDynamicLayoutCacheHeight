//
//  BMGroupModel.h
//  UITableView-BMDynamicLayout
//
//  Created by Mac on 2019/9/30.
//  Copyright © 2019年 liangdahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMGroupModel : NSObject

@property (nonatomic, copy) NSString *headerTitle; ///< headerTitle
@property (nonatomic, strong) NSMutableArray <BMModel *> *modelArray; ///< modelArryy
@property (nonatomic, copy) NSString *footerTitle; ///< footerTitle

@end

NS_ASSUME_NONNULL_END
