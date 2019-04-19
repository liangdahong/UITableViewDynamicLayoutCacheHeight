//    Copyright (c) ( https://github.com/liangdahong )

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^BMLayoutCellConfigurationBlock)(__kindof UITableViewCell *cell);

typedef void (^BMLayoutHeaderFooterViewConfigurationBlock)(__kindof UITableViewHeaderFooterView *headerFooterView);

#pragma mark - BMTemplateLayoutCell

IB_DESIGNABLE
@interface UITableView (BMTemplateLayoutCell)

@property (assign, nonatomic, getter=isScreenRotating) IBInspectable BOOL screenRotating;

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                           configuration:(BMLayoutCellConfigurationBlock)configuration;

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                        cacheByIndexPath:(NSIndexPath *)indexPath
                           configuration:(BMLayoutCellConfigurationBlock)configuration;

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                              cacheByKey:(NSString *)key
                           configuration:(BMLayoutCellConfigurationBlock)configuration;

@end

#pragma mark - BMTemplateLayoutHeaderFooterView

@interface UITableView (BMTemplateLayoutHeaderFooterView)

- (CGFloat)bm_heightForHeaderFooterViewWithWithHeaderFooterViewClass:(Class)clas
                                                       configuration:(BMLayoutHeaderFooterViewConfigurationBlock)configuration;

@end

#pragma mark - UITableViewCell BMTemplateLayoutCell

IB_DESIGNABLE
@interface UITableViewCell (BMTemplateLayoutCell)

@property (assign, nonatomic, getter=isDynamicCellBottomView) IBInspectable BOOL dynamicCellBottomView;
+ (instancetype)bm_tableViewCellWithTableView:(UITableView *)tableView;

@end

@interface UITableViewHeaderFooterView (BMTemplateLayoutCell)

+ (instancetype)bm_tableViewHeaderFooterViewWithTableView:(UITableView *)tableView;

@end
NS_ASSUME_NONNULL_END
