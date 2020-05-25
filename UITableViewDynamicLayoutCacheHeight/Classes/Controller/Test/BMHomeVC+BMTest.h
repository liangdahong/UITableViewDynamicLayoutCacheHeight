//
//  BMHomeVC+BMTest.h
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by mac on 2020/4/5.
//  Copyright © 2020 liangdahong. All rights reserved.
//

#import "BMHomeVC.h"

@interface BMHomeVC (BMTest)

- (void)rightItemDidClick;

/// 1、reloadData
- (void)test_reloadData;

- (void)insertSections_One_first;
- (void)insertSections_One_last;
- (void)insertSections_One_arc;


//    @selector(insertSections:withRowAnimation:),
//    @selector(deleteSections:withRowAnimation:),
//    @selector(reloadSections:withRowAnimation:),
//    @selector(moveSection:toSection:),
//
//    @selector(insertRowsAtIndexPaths:withRowAnimation:),
//    @selector(deleteRowsAtIndexPaths:withRowAnimation:),
//    @selector(reloadRowsAtIndexPaths:withRowAnimation:),
//    @selector(moveRowAtIndexPath:toIndexPath:)


@end
