
//
//  BMChatInputView.m
//  IMDEMO
//
//  Created by ___liangdahong on 2017/8/11.
//  Copyright © 2017年 https://github.com/asiosldh/UITableView-BMTemplateLayoutCell All rights reserved.
//

#import "BMChatInputView.h"

@interface BMChatInputView () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation BMChatInputView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.sendButton.layer.cornerRadius = 2;
    self.sendButton.layer.masksToBounds = YES;
    self.inputTextField.layer.cornerRadius = 2;
    self.inputTextField.layer.masksToBounds = YES;
    self.inputTextField.layer.borderColor = [UIColor clearColor].CGColor;
    self.inputTextField.layer.borderWidth = 0;
    self.sendButton.backgroundColor = [UIColor grayColor];
}

- (IBAction)sendButtonClick {
    if (self.chatInputViewBlock) {
        self.chatInputViewBlock(self.inputTextField.text);
    }
    self.inputTextField.text = nil;
    [self editingChangedClick:self.inputView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self endEditing:YES];
    return YES;
}

- (IBAction)editingChangedClick:(UITextField *)sender {
    self.sendButton.backgroundColor = sender.text.length ? [UIColor blueColor] : [UIColor grayColor];
}

@end
