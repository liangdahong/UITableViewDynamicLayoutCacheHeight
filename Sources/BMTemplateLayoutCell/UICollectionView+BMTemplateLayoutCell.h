//    996 License https://github.com/996icu/996.ICU/blob/master/LICENSE
//
//    Copyright (c) https://github.com/liangdahong/UITableView-BMTemplateLayoutCell
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^UICollectionViewLayoutCellConfigurationBlock)(__kindof UICollectionViewCell *cell);

@interface UICollectionView (BMTemplateLayoutCell)

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration;

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                             maxWidth:(CGFloat)maxWidth
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration;

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                            maxHeight:(CGFloat)maxHeight
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration;

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                              maxSize:(CGSize)maxSize
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration;

@end

NS_ASSUME_NONNULL_END
