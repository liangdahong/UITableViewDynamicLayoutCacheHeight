
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

if your cell use autolayout , all you need just to do like this:

<p align="center">
    <img width="60%" src="./Images/100.png"/>
<p/>


### Cell 的高度计算

```objective-c
/**
 get cell height with class configuration
 */
- (CGFloat)bm_heightWithCellClass:(Class)clas
                    configuration:(BMLayoutCellConfigurationBlock)configuration;

/**
 get cell height with class indexPath configuration
 */
- (CGFloat)bm_heightWithCellClass:(Class)clas
                 cacheByIndexPath:(NSIndexPath *)indexPath
                    configuration:(BMLayoutCellConfigurationBlock)configuration;

/**
 get cell height with class key configuration
 */
- (CGFloat)bm_heightWithCellClass:(Class)clas
                       cacheByKey:(NSString *)key
                    configuration:(BMLayoutCellConfigurationBlock)configuration;
```
### UITableViewHeaderFooterView 的高度计算

```objective-c
/**
 get headerFooterView height with class type configuration
 */
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

/**
 get headerFooterView height with class type section configuration
 */
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                               cacheBySection:(NSInteger)section
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

/**
 get headerFooterView height with class type key configuration
 */
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                   cacheByKey:(NSString *)key
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
```

### 优化配置项

#### UITableView

```objective-c
// 如果你的应用是不支持屏幕旋转的
// 建议设置此值为 TableView 的宽度（通常是屏幕宽度），可提升一定的性能。
@property (nonatomic, assign) IBInspectable CGFloat fixedWidth; ///< fixedWidth
```

#### Cell

```objective-c
// 如果你的 Cell 中用来确定 Cell 所需高度的 View 是唯一的
// 请把此值设置为 YES，可提升一定的性能。
@property (nonatomic, assign) IBInspectable BOOL bm_maxYViewFixed; ///< maxY view whether fixed, default NO.
```


#### HeaderFooterView

```objective-c
// 如果你的 HeaderFooterView 中用来确定 HeaderFooterView 所需高度的 View 是唯一的
// 请把此值设置为 YES，可提升一定的性能。
@property (nonatomic, assign) IBInspectable CGFloat fixedWidth; ///< fixedWidth
```




## License    

UITableView-BMDynamicLayout is released under the [MIT license](LICENSE). See LICENSE for details.
