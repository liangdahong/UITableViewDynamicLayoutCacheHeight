//
//  BMHomeVC.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMHomeVC.h"
#import "BMFriendsCircleVC.h"

@implementation BMHomeVC

- (IBAction)friendsCircleButtonClick {
    [self.navigationController pushViewController:[BMFriendsCircleVC new] animated:YES];
}

@end
