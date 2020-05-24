//
//  BMHomeVC+BMSectionTest.h
//  UITableViewDynamicLayoutCacheHeight
//
//  Created by mac on 2020/4/5.
//  Copyright © 2020 liangdahong. All rights reserved.
//

#import "BMHomeVC.h"

@interface BMHomeVC (BMSectionTest)

- (void)insertSections;
- (void)deleteSections;
- (void)reloadSections;
- (void)moveSection;

@end
