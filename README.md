# UITableView-BMTemplateLayoutCell
> 对UITableViewCell高度自定义及缓存

# 写在前面
1. 系统自动计算无法满足准确获取`contentSize`。
2. [FDTemplateLayoutCell](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)计算不准且似乎在`iOS10.2.1`会崩溃。
3. 代码主动计算太繁琐而且容易错。
4. 当快速增加而且布局比较复杂时`可能有bug`，以后修复。
5. 部分代码暂未优化，以后会优化。

# 效果
<p align="center">
<img src="1.gif" width="40%">
</p>