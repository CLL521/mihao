//
//  loginViewController.m
//  login
//
//  Created by chenliliang on 15/11/12.
//  Copyright (c) 2015年 chenliliang. All rights reserved.
//

#import "loginViewController.h"
#import "backGroundView.h"

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:(211)/255.0 green:(211)/255.0 blue:(211)/255.0 alpha:(255)/255.0];
    self.view = [[backGroundView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    

}



@end
