//
//  UITableView+BMPrivate.h
//  UITableView-BMDynamicLayout
//
//  Created by liangdahong on 2019/9/30.
//  Copyright © 2019 liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (BMPrivate)

@property (nonatomic, assign) BOOL isSectionHeaderHeightCache;
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSNumber *> *headerHeightDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSNumber *> *headerVerticalDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSNumber *> *headerHorizontalDictionary;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *headerHeightArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *headerVerticalArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *headerHorizontalArray;


@property (nonatomic, assign) BOOL isIndexPathHeightCache;
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSNumber *> *heightDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSNumber *> *verticalDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSNumber *> *horizontalDictionary;
@property (nonatomic, strong, readonly) NSMutableArray <NSMutableArray <NSNumber *> *> *heightArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSMutableArray <NSNumber *> *> *verticalArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSMutableArray <NSNumber *> *> *horizontalArray;


@property (nonatomic, assign) BOOL isSectionFooterHeightCache;
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSNumber *> *footerHeightDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSNumber *> *footerVerticalDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary <NSString *, NSNumber *> *footerHorizontalDictionary;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *footerHeightArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *footerVerticalArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSNumber *> *footerHorizontalArray;

@end

NS_ASSUME_NONNULL_END
