
# UITableView-BMDynamicLayout

## Demonstration

<p align="center">
    <img  width="100%" src="./Images/001.gif"/>
<p/>


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
    <img width="60%" src="./Images/100.png"/>
<p/>


### Cell height

```objective-c
- (CGFloat)bm_heightWithCellClass:(Class)clas
                    configuration:(BMLayoutCellConfigurationBlock)configuration;

- (CGFloat)bm_heightWithCellClass:(Class)clas
                 cacheByIndexPath:(NSIndexPath *)indexPath
                    configuration:(BMLayoutCellConfigurationBlock)configuration;

- (CGFloat)bm_heightWithCellClass:(Class)clas
                       cacheByKey:(NSString *)key
                    configuration:(BMLayoutCellConfigurationBlock)configuration;
```
### UITableViewHeaderFooterView height

```objective-c
- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                      section:(NSInteger)section
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;

- (CGFloat)bm_heightWithHeaderFooterViewClass:(Class)clas
                                         type:(BMHeaderFooterViewDynamicLayoutType)type
                                   cacheByKey:(NSString *)key
                                configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration;
```

## License    

UITableView-BMDynamicLayout is released under the [MIT license](LICENSE). See LICENSE for details.
