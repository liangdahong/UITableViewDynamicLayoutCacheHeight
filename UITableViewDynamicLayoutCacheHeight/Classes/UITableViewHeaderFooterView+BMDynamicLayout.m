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

#pragma mark - 最大 Y 的 view 的固定的

- (BOOL)bm_maxYViewFixed {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setBm_maxYViewFixed:(BOOL)bm_maxYViewFixed {
    objc_setAssociatedObject(self, @selector(bm_maxYViewFixed), @(bm_maxYViewFixed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - 免注册获取 UITableViewHeaderFooterView

+ (instancetype)bm_tableViewHeaderFooterViewFromNibWithTableView:(UITableView *)tableView {
    NSString *selfClassName = NSStringFromClass(self.class);
    NSString *reuseIdentifier = [selfClassName stringByAppendingString:@"BMNibDynamicLayoutReuseIdentifier"];
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (headerFooterView) {
        return headerFooterView;
    }
    // 获取 UINib
    UINib *nib = [UINib nibWithNibName:([selfClassName rangeOfString:@"."].location != NSNotFound ? [selfClassName componentsSeparatedByString:@"."].lastObject : selfClassName) bundle:[NSBundle bundleForClass:self.class]];
    NSArray <id> *arr = [nib instantiateWithOwner:nil options:nil];
    for (id obj in arr) {
        if ([obj isMemberOfClass:self.class]) {
            headerFooterView = (UITableViewHeaderFooterView *)obj;
            [headerFooterView setValue:reuseIdentifier forKey:@"reuseIdentifier"];
            return headerFooterView;
        }
    }
    // 你的 UITableViewHeaderFooterView 不是使用 xib 创建的！
    NSAssert(NO, @"你的 UITableViewHeaderFooterView 不是使用 xib 创建的！");
    return UITableViewHeaderFooterView.new;
}

+ (instancetype)bm_tableViewHeaderFooterViewFromAllocWithTableView:(UITableView *)tableView {
    NSString *selfClassName = NSStringFromClass(self.class);
    NSString *reuseIdentifier = [selfClassName stringByAppendingString:@"BMAllocDynamicLayoutReuseIdentifier"];
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    if (headerFooterView) {
        return headerFooterView;
    }
    return [[self alloc] initWithReuseIdentifier:reuseIdentifier];
}

@end
