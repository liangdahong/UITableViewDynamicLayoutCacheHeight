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

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UITableViewCell (BMDynamicLayout)

/// 如果你的 Cell 中用来确定 Cell 所需高度的 View 是唯一的,
/// 请把此值设置为 YES，可提升一定的性能。
@property (nonatomic, assign) IBInspectable BOOL bm_maxYViewFixed;

/// 免注册直接创建 Cell，内部自动处理取缓存池操作
/// @param tableView tableView
+ (instancetype)bm_tableViewCellWithTableView:(UITableView *)tableView;

/// 免注册直接创建 Cell，内部自动处理取缓存池操作
/// @param tableView tableView
/// @param style cell 类型
+ (instancetype)bm_tableViewCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style;

@end
