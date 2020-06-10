//    MIT License
//
//    Copyright (c) 2019 https://github.com/liangdahong
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

#import "UITableViewHeaderFooterView+BMDynamicLayout.h"
#import <objc/runtime.h>

@implementation UITableViewHeaderFooterView (BMDynamicLayout)

- (BOOL)bm_maxYViewFixed {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setBm_maxYViewFixed:(BOOL)bm_maxYViewFixed {
    objc_setAssociatedObject(self, @selector(bm_maxYViewFixed), @(bm_maxYViewFixed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (instancetype)bm_tableViewHeaderFooterViewFromNibWithTableView:(UITableView *)tableView {
    NSString *selfClassName = NSStringFromClass(self.class);
    NSString *reuseIdentifier = [selfClassName stringByAppendingString:@"BMDynamicLayoutReuseIdentifier"];
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (headerFooterView) {
        return headerFooterView;
    }
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSArray <UITableViewHeaderFooterView *> *arr = [bundle loadNibNamed:selfClassName owner:nil options:nil];
    for (UITableViewHeaderFooterView *obj in arr) {
        if ([obj isMemberOfClass:self.class]) {
            headerFooterView = obj;
            [headerFooterView setValue:reuseIdentifier forKey:@"reuseIdentifier"];
            return headerFooterView;
        }
    }
    NSAssert(NO, @"你的 UITableViewHeaderFooterView 不是 IB 创建的");
    return nil;
}

+ (instancetype)bm_tableViewHeaderFooterViewFromAllocWithTableView:(UITableView *)tableView {
    NSString *selfClassName = NSStringFromClass(self.class);
    NSString *reuseIdentifier = [selfClassName stringByAppendingString:@"BMDynamicLayoutReuseIdentifier"];
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (headerFooterView) {
        return headerFooterView;
    }
    return [[self alloc] initWithReuseIdentifier:reuseIdentifier];
}

@end
