//
//  AppDelegate.m
//  BMDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/17.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import "AppDelegate.h"
#import "BMXibCellVC.h"
#import "YYFPSLabel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[BMXibCellVC new]];
    nav.navigationBar.translucent = NO;
    nav.navigationBar.hidden = NO;
    self.window.rootViewController = nav;
    YYFPSLabel *label = [YYFPSLabel new];
    label.frame = CGRectMake(10, 20, 60, 20);
//    [self.window addSubview:label];
    return YES;
}

@end
