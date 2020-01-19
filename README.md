
# UITableView-BMDynamicLayout

## Demonstration

<p align="center">
    <img  width="100%" src="./Images/001.gif"/>
<p/>

<p align="center">
<a href="#"><img src="https://img.shields.io/cocoapods/v/UITableView-BMDynamicLayout.svg"></a>
<a href="#"><img src="https://img.shields.io/badge/platform-iOS-red.svg"></a>
<a href="#"><img src="https://img.shields.io/badge/language-Objective--C-orange.svg"></a>
<a href="#"><img src="https://img.shields.io/badge/licenses-MIT-red.svg"></a>
</p>


## Introduction

- This is a Template auto layout cell for automatically UITableViewCell UITableViewHeaderFooterView calculating and cache height
   framework.
- 本框架是一个便捷的，高性能的自动计算采用 Autolayout 布局的 UITableViewCell 和 UITableViewHeaderFooterView 的高度，同时支持横竖屏，Masonry等采用系统Autolayout布局的框架，同时自动处理高度缓存，
- 最简单的使用说明 https://juejin.im/post/5e231e9a51882536cc0cc975
- [最简单的使用说明](./使用说明.md)

##  CocoaPods

```ruby
pod 'UITableView-BMDynamicLayout'
```

```ruby
pod install
```

```objective-c
#import "BMTableViewDynamicLayout.h"
```

## Usage

如果你想使用此框架，你的 Cell 或 UITableViewHeaderFooterView 必须使用 Autolayout 布局，且保证其中一个 View 的最大 Y 刚好是 Cell 或 UITableViewHeaderFooterView 需要的高度。



- 下面的 Cell 布局中，箭头指向的 View 的最大 Y 刚好就是这个 Cell 所需的高度。

<p align="center">
    <img width="60%" src="./Images/100.png"/>
<p/>


### Cell 的高度计算

```objective-c
/// 获取 Cell 需要的高度 ，内部无缓存操作
/// @param clas cell class
/// @param configuration 布局 cell
- (CGFloat)bm_heightWithCellClass:(Class)clas
                    configuration:(void (^)(__kindof UITableViewCell *cell))configuration;

/// 获取 Cell 需要的高度 ，内部自动处理缓存，缓存标识 indexPath
/// @param clas cell class
/// @param indexPath 使用 indexPath 做缓存标识
/// @param configuration 布局 cell
- (CGFloat)bm_heightWithCellClass:(Class)clas
                 cacheByIndexPath:(NSIndexPath *)indexPath
                    configuration:(void (^)(__kindof UITableViewCell *cell))configuration;

/// 获取 Cell 需要的高度 ，内部自动处理缓存，缓存标识 key
/// @param clas cell class
/// @param key 使用 key 做缓存标识
/// @param configuration 布局 cell
- (CGFloat)bm_heightWithCellClass:(Class)clas
                       cacheByKey:(NSString *)key
                    configuration:(void (^)(__kindof UITableViewCell *cell))configuration;
```
### UITableViewHeaderFooterView 的高度计算

```objective-c
/// 获取 HeaderFooter 需要的高度 ，内部无缓存操作
/// @param clas HeaderFooter class
/// @param type HeaderFooter类型，Header 或者 Footer
/// @param configuration 布局 HeaderFooter
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                configuration:(void (^)(__kindof UITableViewHeaderFooterView *headerFooterView))configuration;

/// 获取 HeaderFooter 需要的高度 ， 内部自动处理缓存，缓存标识 section
/// @param clas HeaderFooter class
/// @param type HeaderFooter类型，Header 或者 Footer
/// @param section 使用 section 做缓存标识
/// @param configuration 布局 HeaderFooter
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                               cacheBySection:(NSInteger)section
                                configuration:(void (^)(__kindof UITableViewHeaderFooterView *headerFooterView))configuration;

/// 获取 HeaderFooter 需要的高度 ， 内部自动处理缓存，缓存标识 key
/// @param clas HeaderFooter class
/// @param type HeaderFooter类型，Header 或者 Footer
/// @param key 使用 key 做缓存标识
/// @param configuration 布局 HeaderFooter
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                   cacheByKey:(NSString *)key
                                configuration:(void (^)(__kindof UITableViewHeaderFooterView *headerFooterView))configuration;
```

### 优化配置项

#### Cell

```objective-c
/// 如果你的 Cell 中用来确定 Cell 所需高度的 View 是唯一的,
/// 请把此值设置为 YES，可提升一定的性能。
@property (nonatomic, assign) IBInspectable BOOL bm_maxYViewFixed;
```

#### HeaderFooterView

```objective-c
/// 如果你的 HeaderFooterView 中用来确定 HeaderFooterView 所需高度的 View 是唯一的,
/// 请把此值设置为 YES，可提升一定的性能。
@property (nonatomic, assign) IBInspectable BOOL bm_maxYViewFixed;
```

## License    

UITableView-BMDynamicLayout is released under the [MIT license](LICENSE). See LICENSE for details.
