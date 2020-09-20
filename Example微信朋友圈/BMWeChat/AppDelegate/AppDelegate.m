//
//  AppDelegate.m
//  BMWeChat
//
//  Created by ___liangdahong on 2017/11/9.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "AppDelegate.h"
#import "BMHomeVC.h"
#import "BMWeChat-Swift.h"
#import <FSPagerView/FSPagerView-Swift.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController *vc     = [[UINavigationController alloc] initWithRootViewController:[BMHomeVC new]];;
    vc.navigationBar.translucent   = NO;
    vc.navigationBar.hidden        = NO;
    self.window.rootViewController = vc;

    // cpu
    [GDP start];
    
    FSPagerView *obj = FSPagerView.new;
    NSLog(@"%@", obj);

    return YES;
}

@end
