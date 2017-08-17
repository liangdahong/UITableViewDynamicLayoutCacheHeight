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
#import "UITableViewCell+BMReusable.h"
#import "BMHeaderView.h"
#import "BMModel.h"
#import "BMCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) BMChatInputView *chatInputView;
@property (strong, nonatomic) NSMutableArray <BMModel *> *dataArray;

@end

@implementation ViewController

#pragma mark -
#pragma mark - init
#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
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

- (NSMutableArray<BMModel *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[] mutableCopy];
    }
    return _dataArray;
}

- (BMChatInputView *)chatInputView {
    if (!_chatInputView) {
        _chatInputView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BMChatInputView.class) owner:nil options:nil] firstObject];
        _chatInputView.chatInputViewBlock = ^(NSString *string) {
        };
        _chatInputView.inputTextField.returnKeyType = UIReturnKeyDone;
    }
    return _chatInputView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:1];
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
    return [BMCell bm_cellWithTableView:tableView];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(BMCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.dataArray[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BMModel *model = self.dataArray[indexPath.row];
    return [tableView bm_heightForCellWithCellClass:BMCell.class cacheByKey:model.ID configuration:^(__kindof BMCell *cell) {
        cell.model = model;
    }];
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
    static NSInteger count = 0;
    BMModel *model = [BMModel new];
    if (arc4random_uniform(2)) {
        if (arc4random_uniform(2)) {
            model.name = @"名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称";
        } else {
            model.name = @"名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称名称";
        }
    } else {
        model.name = @"名称名称名称名称名啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊称名称名称名称名称名称名称名称";
    }
    if (arc4random_uniform(2)) {
        if (arc4random_uniform(2)) {
            model.desc = @"详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊情啊详情啊详情啊";
        } else {
            model.desc = @"详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情啊";
        }
    } else {
        model.desc = @"详情啊详情啊详情啊详情啊详情啊详情啊详情啊详情";
    }
    
    if (arc4random_uniform(2)) {
        if (arc4random_uniform(2)) {
            model.icon = @"001";
        } else {
            if (arc4random_uniform(2)) {
                model.icon = @"002";
            } else {
                model.icon = @"003";
            }
        }
    } else {
        if (arc4random_uniform(2)) {
            model.icon = @"010";
        } else {
            if (arc4random_uniform(2)) {
                model.icon = @"011";
            } else {
                model.icon = @"012";
            }
        }
    }
    
    model.ID = [NSString stringWithFormat:@"%ld", count++];
    [self.dataArray addObject:model];
    [self.tableView reloadData];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView bm_scrollToBottomAnimated:YES];
    });
}

@end
