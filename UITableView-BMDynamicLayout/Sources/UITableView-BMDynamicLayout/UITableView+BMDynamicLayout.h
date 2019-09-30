////
////  UITableView+BMDynamicLayout.h
////  UITableView-BMTemplateLayoutCell
////
////  Created by Mac on 2019/9/27.
////  Copyright © 2019年 ( https://liangdahong.com ). All rights reserved.
//// 
//
//#import <UIKit/UIKit.h>
//#import "UITableViewCell+BMAutomaticRegister.h"
//#import "UITableViewHeaderFooterView+BMAutomaticRegister.h"
//
//NS_ASSUME_NONNULL_BEGIN
//
//typedef void (^BMLayoutCellConfigurationBlock)(__kindof UITableViewCell *cell);
//typedef void (^BMLayoutHeaderFooterConfigurationBlock)(__kindof UITableViewHeaderFooterView *headerFooterView);
//
//IB_DESIGNABLE
//@interface UITableView (BMDynamicLayout)
//
//@property (assign, nonatomic, getter=isScreenRotating) IBInspectable BOOL screenRotating; ///< 是否支持屏幕旋转，默认 NO
//
///**
// cell clas configuration
// */
//- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
//                           configuration:(BMLayoutCellConfigurationBlock)configuration;
//
///**
// cell clas width configuration
// */
//- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
//                          tableViewWidth:(CGFloat)width
//                           configuration:(BMLayoutCellConfigurationBlock)configuration;
//
///**
// cell clas indexPath configuration
// */
//- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
//                        cacheByIndexPath:(NSIndexPath *)indexPath
//                           configuration:(BMLayoutCellConfigurationBlock)configuration;
//
///**
// cell clas indexPath width configuration
// */
//- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
//                        cacheByIndexPath:(NSIndexPath *)indexPath
//                          tableViewWidth:(CGFloat)width
//                           configuration:(BMLayoutCellConfigurationBlock)configuration;
//
///**
// cell clas key configuration
// */
//- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
//                              cacheByKey:(NSString *)key
//                           configuration:(BMLayoutCellConfigurationBlock)configuration;
//
///**
// cell clas key width configuration
// */
//- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
//                              cacheByKey:(NSString *)key
//                          tableViewWidth:(CGFloat)width
//                           configuration:(BMLayoutCellConfigurationBlock)configuration;
//
//@end
//
//@interface UITableView (BMTemplateLayoutHeaderFooterView)
//
///**
// HeaderFooterView clas configuration
// */
//- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
//                                                   configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
///**
// HeaderFooterView clas width configuration
// */
//- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
//                                                  tableViewWidth:(CGFloat)width
//                                                   configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
//
///**
// HeaderFooterView clas isHeaderView section configuration
// */
//- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
//                                                    isHeaderView:(BOOL)isHeaderView
//                                                         section:(NSInteger)section
//                                                   configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
///**
// HeaderFooterView clas isHeaderView section width configuration
// */
//- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
//                                                    isHeaderView:(BOOL)isHeaderView
//                                                         section:(NSInteger)section
//                                                  tableViewWidth:(CGFloat)width
//                                                   configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
//
///**
// HeaderFooterView clas key configuration
// */
//- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
//                                                      cacheByKey:(NSString *)key
//                                                   configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
///**
// HeaderFooterView clas key width configuration
// */
//- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
//                                                      cacheByKey:(NSString *)key
//                                                  tableViewWidth:(CGFloat)width
//                                                   configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
//
//@end
//
//#pragma mark - UITableViewCell BMTemplateLayoutCell
//
//IB_DESIGNABLE
//@interface UITableViewCell (BMTemplateLayoutCell)
//
///**
// 最大Y的View是否为变化的，默认:NO（固定）,如果Cell的最大Y的View是变化的请设置为YES,通常是在设置了2个最大View时使用。
// */
//@property (assign, nonatomic, getter=isDynamicCellBottomView) IBInspectable BOOL dynamicCellBottomView;
//
//@end
//
//#pragma mark - UITableViewHeaderFooterView BMTemplateLayoutCell
//
//IB_DESIGNABLE
//@interface UITableViewHeaderFooterView (BMTemplateLayoutCell)
//
///**
// 最大 Y 的 View 是否为变化的，默认:NO（固定）,如果 UITableViewHeaderFooterView 的最大 Y 的 View 是变化的请设置为 YES, 通常是在设置了 2 个（更多）最大 View 时使用。
// */
//@property (assign, nonatomic, getter=isDynamicHeaderFooterBottomView) IBInspectable BOOL dynamicHeaderFooterBottomView;
//
//@end
//
//NS_ASSUME_NONNULL_END
