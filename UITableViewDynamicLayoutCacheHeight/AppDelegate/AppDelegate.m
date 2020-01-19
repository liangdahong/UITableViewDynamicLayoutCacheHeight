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

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    BMXibCellVC *vc = BMXibCellVC.new;
    vc.dataArray = self.dataArray;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent = NO;
    nav.navigationBar.hidden = NO;
    self.window.rootViewController = nav;

    YYFPSLabel *label = [YYFPSLabel new];
    label.frame = CGRectMake(10, 20, 60, 20);
    [self.window addSubview:label];

    return YES;
}

- (NSMutableArray<BMGroupModel *> *)dataArray {

    NSMutableArray<BMGroupModel *> * _dataArray = [@[] mutableCopy];
    int arc = arc4random_uniform(10)+4;
    while (arc--) {
        NSMutableArray *arr1 = @[].mutableCopy;
        int arc1 = arc4random_uniform(3)+10;
        while (arc1--) {
            BMModel *model = [BMModel new];
            int arci = arc4random_uniform(20) + 1;
            NSMutableString *string = [NSMutableString string];
            while (arci--) {
                [string appendString:@"消息消息消息消息消息"];
            }
            [string appendString:@"详情完~"];
            model.desc = string;

            int arcd = arc4random_uniform(5)+1;
            NSMutableString *string1 = [NSMutableString string];
            while (arcd--) {
                [string1 appendString:@"标题"];
            }
            [string1 appendString:@"标题完~"];
            model.name = string1;
            model.icon = [NSString stringWithFormat:@"%d.png", arc4random_uniform(30) + 1];
            UIImage *img = [UIImage imageNamed:model.icon];

            {
                CGFloat width = img.size.width;
                CGFloat height = img.size.height;

                CGFloat swidth = UIScreen.mainScreen.bounds.size.width-20;

                CGFloat imgwidth = 0;
                CGFloat imgheight = 0;

                if (width <= swidth) {
                    imgwidth = width;
                    imgheight = height;
                } else {
                    imgwidth = swidth;
                    imgheight = height * (swidth/width);
                }
                model.vsize = CGSizeMake(imgwidth, imgheight);
            }

            {
                CGFloat width = img.size.width;
                CGFloat height = img.size.height;

                CGFloat swidth = UIScreen.mainScreen.bounds.size.height-20;

                CGFloat imgwidth = 0;
                CGFloat imgheight = 0;

                if (width <= swidth) {
                    imgwidth = width;
                    imgheight = height;
                } else {
                    imgwidth = swidth;
                    imgheight = height * (swidth/width);
                }
                model.hsize = CGSizeMake(imgwidth, imgheight);
            }

            [arr1 addObject:model];
        }

        BMGroupModel *obj = BMGroupModel.new;
        obj.modelArray = arr1.mutableCopy;
        [_dataArray addObject:obj];
    }

    [_dataArray enumerateObjectsUsingBlock:^(BMGroupModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        int arci = arc4random_uniform(20) + 1;
        NSMutableString *string = [NSMutableString string];
        while (arci--) {
            [string appendString:@"头部头部头部"];
        }
        [string appendString:@"~"];
        obj.headerTitle = string;

        {
            int arci = arc4random_uniform(30) + 1;
            NSMutableString *string = [NSMutableString string];
            while (arci--) {
                [string appendString:@"尾部尾部尾部尾部尾"];
            }
            [string appendString:@"~"];
            obj.footerTitle = string;
        }

        [obj.modelArray enumerateObjectsUsingBlock:^(BMModel * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            obj1.ID = [NSString stringWithFormat:@"%lu-%lu", (unsigned long)idx, (unsigned long)idx1];
        }];
    }];

    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"text"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSArray <NSDictionary *> *arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:NULL];

    __block NSInteger count = 0;
    [_dataArray enumerateObjectsUsingBlock:^(BMGroupModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.headerTitle = arr[(unsigned long)arc4random_uniform((unsigned int)arr.count)][@"title"];;
        obj.footerTitle = arr[(unsigned long)arc4random_uniform((unsigned int)arr.count)][@"artist"];;
        [obj.modelArray enumerateObjectsUsingBlock:^(BMModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (count > arr.count) {
                obj.name =  arr[(unsigned long)arc4random_uniform((unsigned int)arr.count)][@"title"];
                obj.desc =  arr[(unsigned long)arc4random_uniform((unsigned int)arr.count)][@"summary"];
            } else {
                obj.name =  arr[(unsigned long)arc4random_uniform((unsigned int)count)][@"title"];
                obj.desc =  arr[(unsigned long)arc4random_uniform((unsigned int)arr.count)][@"summary"];
            }
            count++;
        }];
    }];

    return _dataArray;
}


@end
