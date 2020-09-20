//
//  BMHomeVC+BMTest.h
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by mac on 2020/4/5.
//  Copyright © 2020 liangdahong. All rights reserved.
//

#import "BMHomeVC.h"

@interface BMHomeVC (BMTest)

/// deleteIndexPaths，reloadRowsAtIndexPath
- (void)test_while_deleteIndexPaths_reloadRowsAtIndexPaths;
/// deleteSections，reloadRowsAtSections
- (void)test_while_deleteSections_reloadRowsAtSections;

// 暂时未完成此 insert 和 move 的测试
//- (void)test_while_insertSections_moveSection;
//- (void)test_while_insertRowsAtIndexPaths_moveRowAtIndexPath;

@end
