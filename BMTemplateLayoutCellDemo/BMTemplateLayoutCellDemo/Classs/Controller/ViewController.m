//
//  ViewController.m
//  IMTableViewDemo
//
//  Created by http://idhong.com/ on 2017/8/14.
//  Copyright © 2017年 https://github.com/asiosldh/UITableView-BMTemplateLayoutCell All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "BMChatInputView.h"
#import "UIView+BMExtension.h"
#import "TableViewCell.h"
#import "UITableView+BMTemplateLayoutCell.h"
#import "UIScrollView+BMExtension.h"
#import "BMOneCell.h"
#import "BMTwoCell.h"
#import "BMImageViewCell.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) BMChatInputView *chatInputView;
@property (strong, nonatomic) NSMutableArray <NSString *> *dataArray;

@end

@implementation ViewController

#pragma mark -
#pragma mark - init
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(TableViewCell.class) bundle:nil] forCellReuseIdentifier:@"TableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(BMOneCell.class) bundle:nil] forCellReuseIdentifier:@"BMOneCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(BMTwoCell.class) bundle:nil] forCellReuseIdentifier:@"BMTwoCell"];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(BMImageViewCell.class) bundle:nil] forCellReuseIdentifier:@"BMImageViewCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-40);
        make.right.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
    }];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panpanpan)];
    [self.view addGestureRecognizer:pan];

    UITapGestureRecognizer *TapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(panpanpan)];
    [self.view addGestureRecognizer:TapGestureRecognizer];
    
    [self.view addSubview:self.chatInputView];
    [self.chatInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view endEditing:YES];
}

#pragma mark - getters setters

- (NSMutableArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}

- (BMChatInputView *)chatInputView {
    if (!_chatInputView) {
        _chatInputView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BMChatInputView.class) owner:nil options:nil] firstObject];
        __weak typeof(self) weakSelf = self;
        _chatInputView.chatInputViewBlock = ^(NSString *string){
            __strong typeof(weakSelf) self = weakSelf;
            [self.dataArray addObject:string];
            [self.tableView reloadData];
            [self.tableView bm_scrollToBottomAnimated:YES];
        };
        _chatInputView.inputTextField.returnKeyType = UIReturnKeyDone;
    }
    return _chatInputView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:0];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _tableView;
}

#pragma mark - 系统delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 4 == 0) {
        TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCell" forIndexPath:indexPath];
        cell.LABEEE.text = self.dataArray[indexPath.row];
        NSLog(@"%p", cell);
        return cell;
    } else if(indexPath.row % 4 == 1) {
        BMOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMOneCell" forIndexPath:indexPath];
        cell.descLabel.text = self.dataArray[indexPath.row];
        NSLog(@"%p", cell);
        return cell;
    } else  if(indexPath.row % 4 == 2) {
        BMTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMTwoCell" forIndexPath:indexPath];
        cell.label1.text = self.dataArray[indexPath.row];
        cell.label2.text = self.dataArray[indexPath.row];
        return cell;
    } else {
        BMImageViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BMImageViewCell" forIndexPath:indexPath];
        cell.labelLabel.text = self.dataArray[indexPath.row];
        if (indexPath.row % 3 == 0) {
            cell.iconImageView.image = [UIImage imageNamed:@"001"];
        } else if (indexPath.row % 3 == 1){
            cell.iconImageView.image = [UIImage imageNamed:@"002"];
        } else {
            cell.iconImageView.image = [UIImage imageNamed:@"003"];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 4 == 0) {
        return [tableView bm_heightForCellWithIdentifier:@"TableViewCell" cacheByIndexPath:indexPath configuration:^(__kindof TableViewCell *layoutCell) {
            layoutCell.LABEEE.text = self.dataArray[indexPath.row];
        }];
    } else if(indexPath.row % 4 == 1){
        return [tableView bm_heightForCellWithIdentifier:@"BMOneCell" cacheByIndexPath:indexPath configuration:^(__kindof BMOneCell *layoutCell) {
            layoutCell.descLabel.text = self.dataArray[indexPath.row];
        }];
    } else if(indexPath.row % 4 == 2){
        return [tableView bm_heightForCellWithIdentifier:@"BMTwoCell" cacheByIndexPath:indexPath configuration:^(__kindof BMTwoCell *layoutCell) {
            layoutCell.label1.text = self.dataArray[indexPath.row];
            layoutCell.label2.text = self.dataArray[indexPath.row];
        }];
    }
    else {
        return [tableView bm_heightForCellWithIdentifier:@"BMImageViewCell" cacheByIndexPath:indexPath configuration:^(__kindof BMImageViewCell *layoutCell) {
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

#pragma mark - 自定义delegate
#pragma mark - 公有方法
#pragma mark - 私有方法
#pragma mark - 事件响应
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect endFrame   = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.25 animations:^{
        [self.chatInputView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-endFrame.size.height);
        }];
        
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-40-endFrame.size.height);
        }];
        [self.view layoutIfNeeded];
        [self.tableView bm_scrollToBottomAnimated:YES];
    }];
    self.tableView.userInteractionEnabled = NO;
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [UIView animateWithDuration:0.25 animations:^{
        [self.chatInputView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(0);
        }];
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-40);
        }];
        [self.view layoutIfNeeded];
        [self.tableView bm_scrollToBottomAnimated:YES];
    } completion:^(BOOL finished) {
        self.tableView.userInteractionEnabled = YES;
    }];
}

- (void)panpanpan{
    [self.view endEditing:YES];
}

- (IBAction)add:(id)sender {
    if (arc4random_uniform(3)) {
        if (arc4random_uniform(2)) {
            [self.dataArray addObject:@"随机的一条消随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊息啊啊啊啊啊"];
        } else {
            [self.dataArray addObject:@"随机的一条消息啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊啊啊啊啊"];
        }
    } else {
        if (arc4random_uniform(2)) {
            [self.dataArray addObject:@"随机的一条消息啊啊啊啊随机的一条消息啊啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊随机的一条消息啊啊啊啊啊"];
        } else {
            [self.dataArray addObject:@"随机的一条消息啊啊啊啊啊"];
        }
    }
    [self.tableView reloadData];
    [self.tableView bm_scrollToBottomAnimated:YES];
}

@end
