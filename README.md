# UITableView-BMTemplateLayoutCell
> 对UITableViewCell高度自适应并缓存

# 写在前面
> 由于最近需要做一个类似微信聊天窗口的功能,牵涉到`UITableViewCell`的高度自适应，同时需要准确获取`UITableView`的`contentSize`并做相应的滚动和动画，在反复尝试使用系统自适应和[FDTemplateLayoutCell](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)均有一些小问题待处理，代码计算又太麻烦，故尝试自己实现。

1. 系统自动计算无法满足准确获取`contentSize`。
2. [FDTemplateLayoutCell](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)计算不准且似乎在`iOS10.2.1`会崩溃。
3. 代码主动计算太繁琐而且容易错。

# 存在的问题
1. 部分代码暂未优化，以后会优化。
2. 准备让代码稳定后弄Cocoapods。

# 效果
##  gif效果图

<p align="center">
<img src="1.gif" width="100%">
</p>

## Xib约束图
<p align="center">
<img src="1.png" width="80%">
</p>

<p align="center">
<img src="2.png" width="80%">
</p>

<p align="center">
<img src="3.png" width="80%">
</p>

<p align="center">
<img src="4.png" width="80%">
</p>

## 获取高度的代理方法
> 获取高度的方法如下即可，而且这里有`4种Cell`同时做了一些测试操作，真实项目中一种`Cell`只需一行代码搞定一切问题。

```c
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 4 == 0) {
        return [tableView bm_heightForCellWithCellClass:TableViewCell.class cacheByIndexPath:indexPath configuration:^(__kindof TableViewCell *layoutCell) {
            layoutCell.LABEEE.text = self.dataArray[indexPath.row];
        }];
        
    } else if(indexPath.row % 4 == 1){
        return [tableView bm_heightForCellWithCellClass:BMOneCell.class cacheByIndexPath:indexPath configuration:^(__kindof BMOneCell *layoutCell) {
            layoutCell.descLabel.text = self.dataArray[indexPath.row];
        }];
    } else if(indexPath.row % 4 == 2){
        return [tableView bm_heightForCellWithCellClass:BMTwoCell.class cacheByIndexPath:indexPath configuration:^(__kindof BMTwoCell *layoutCell) {
            layoutCell.label1.text = self.dataArray[indexPath.row];
            layoutCell.label2.text = self.dataArray[indexPath.row];
        }];
    } else {
        return [tableView bm_heightForCellWithCellClass:BMImageViewCell.class cacheByIndexPath:indexPath configuration:^(__kindof BMImageViewCell *layoutCell) {
            layoutCell.labelLabel.text = self.dataArray[indexPath.row];
            if (indexPath.row % 3 == 0) {
                layoutCell.iconImageView.image = [UIImage imageNamed:@"001"];
            } else if (indexPath.row % 3 == 1){
                layoutCell.iconImageView.image = [UIImage imageNamed:@"002"];
            } else {
                layoutCell.iconImageView.image = [UIImage imageNamed:@"003"];
            }
        }];
    }
}
```
