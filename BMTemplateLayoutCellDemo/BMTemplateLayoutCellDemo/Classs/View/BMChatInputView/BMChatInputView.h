//
//  BMChatInputView.h
//  IMDEMO
//
//  Created by ___liangdahong on 2017/8/11.
//  Copyright © 2017年 https://github.com/asiosldh/UITableView-BMTemplateLayoutCell All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXNibBridge.h"

typedef void(^BMChatInputViewBlock)(NSString *string);

@interface BMChatInputView : UIView <XXNibBridge>

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (copy, nonatomic) BMChatInputViewBlock chatInputViewBlock;

@end
