#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "UITableView+BMPrivate.h"
#import "UITableViewCell+BMPrivate.h"
#import "UITableViewDynamicLayoutMacro.h"
#import "UITableViewHeaderFooterView+BMPrivate.h"
#import "UITableView+BMDynamicLayout.h"
#import "UITableViewCell+BMDynamicLayout.h"
#import "UITableViewHeaderFooterView+BMDynamicLayout.h"

FOUNDATION_EXPORT double UITableView_BMDynamicLayoutVersionNumber;
FOUNDATION_EXPORT const unsigned char UITableView_BMDynamicLayoutVersionString[];

