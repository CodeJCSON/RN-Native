//
//  ViewController.m
//  myproject
//
//  Created by 云媒 on 2017/6/8.
//  Copyright © 2017年 yunmei. All rights reserved.
//

#import "ViewController.h"
#import "RCTRootView.h"
#import "RNViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeCustom];
    [bu setTitle:@"点击跳转" forState:UIControlStateNormal];
    [bu setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    bu.frame = CGRectMake([UIScreen mainScreen].bounds.origin.x/2.0, 100, 200, 50);
    
    [self.view addSubview:bu];
}

- (void)buttonClick{

    NSLog(@"High Score Button Pressed");
    NSURL *jsCodeLocation = [NSURL
                             URLWithString:@"http://192.168.199.206:8081/index.ios.bundle?platform=ios&dev=true"];
    RCTRootView *rootView =
    [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                         moduleName        : @"myproject"
                         initialProperties :nil
                          launchOptions    : nil];
    RNViewController *vc = [[RNViewController alloc] init];
    vc.view = rootView;
    [self presentViewController:vc animated:YES completion:nil];

}


@end
