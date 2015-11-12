//
//  AppDelegate.m
//  login
//
//  Created by chenliliang on 15/11/12.
//  Copyright (c) 2015年 chenliliang. All rights reserved.
//

#import "AppDelegate.h"
#import "loginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置窗口控制器
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[loginViewController alloc]init];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
