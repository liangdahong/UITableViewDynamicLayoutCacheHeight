//    996 License https://github.com/996icu/996.ICU/blob/master/LICENSE
//
//    Copyright (c) https://github.com/liangdahong/UITableView-BMTemplateLayoutCell
//

#import "UICollectionView+BMTemplateLayoutCell.h"
#import <objc/runtime.h>

#define maxHeightWidth 88888.0f

@implementation UICollectionView (BMTemplateLayoutCell)

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration {
    return [self bm_sizeForCellWithCellClass:clas
                                     maxSize:CGSizeMake(maxHeightWidth, maxHeightWidth)
                                         key:key configuration:configuration];
}

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                             maxWidth:(CGFloat)maxWidth
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration {
    return [self bm_sizeForCellWithCellClass:clas
                                     maxSize:CGSizeMake(maxWidth, maxHeightWidth)
                                         key:key
                               configuration:configuration];
}

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                            maxHeight:(CGFloat)maxHeight
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration {
    return [self bm_sizeForCellWithCellClass:clas
                                     maxSize:CGSizeMake(maxHeightWidth, maxHeight)
                                         key:key
                               configuration:configuration];
}

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                              maxSize:(CGSize)maxSize
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration {

    NSMutableDictionary <NSString *, NSNumber *> *dict = objc_getAssociatedObject(self, &clas);
    if (!dict) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, &clas, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    if (key && dict[key]) {
        NSLog(@"取缓存 %@ size %@", key, dict[key]);
        return dict[key].CGSizeValue;
    }

    UICollectionViewCell *cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas) owner:nil options:nil].firstObject;

    UIView *sview = [UIView new];
    sview.frame = CGRectMake(0, 0, maxSize.width, maxSize.height);

    [sview addSubview:cell];
    cell.frame = CGRectMake(0, 0, maxSize.width, maxSize.height);

    !configuration ? :configuration(cell);

    [sview layoutIfNeeded];

    __block CGFloat maxX  = 0.0f;
    __block CGFloat maxY  = 0.0f;
    [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat tempX = CGRectGetMaxX(obj.frame);
        CGFloat tempY = CGRectGetMaxY(obj.frame);
        if (tempX > maxX) {
            maxX = tempX;
        }
        if (tempY > maxY) {
            maxY = tempY;
        }
    }];
    if (key) {
        NSLog(@"保存 %@ size %@", key, [NSNumber valueWithCGSize:CGSizeMake(maxX, maxY)]);
        dict[key] = (NSNumber *)[NSNumber valueWithCGSize:CGSizeMake(maxX, maxY)];
    }
    return CGSizeMake(maxX, maxY);
}

@end

