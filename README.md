
# UITableView-BMDynamicLayout

## Demonstration

<p align="center">
    <img  width="40%" src="1.gif"/>
<p/>

<p align="center">

<a href="#">
​        <img src="https://img.shields.io/badge/platform-iOS-red.svg">
​    </a>

<a href="#">
​        <img src="https://img.shields.io/badge/language-Objective--C-orange.svg">
​    </a>
​    
<a href="#">
​        <img src="https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat">
​    </a>

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
#import "UITableView-BMDynamicLayout.h"
```

## Usage

if your cell use autolayout , all you need just to do like this:

<p align="center">
    <img width="60%" src="1-1.png"/>
<p/>

### Cell height

```objective-c
- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
configuration:(BMLayoutCellConfigurationBlock)configuration;

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
cacheByIndexPath:(NSIndexPath *)indexPath
configuration:(BMLayoutCellConfigurationBlock)configuration;

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
cacheByKey:(NSString *)key
configuration:(BMLayoutCellConfigurationBlock)configuration;
```
### UITableViewHeaderFooterView height

```objective-c
- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
type:(BMDynamicLayoutType)type
configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
type:(BMDynamicLayoutType)type
section:(NSInteger)section
configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas
type:(BMDynamicLayoutType)type
cacheByKey:(NSString *)key
configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
```

## License    

UITableView-BMDynamicLayout is released under the [MIT license](LICENSE). See LICENSE for details.
