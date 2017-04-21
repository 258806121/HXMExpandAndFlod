//
//  ViewController.m
//  展开与收起
//
//  Created by HXM on 2017/4/21.
//  Copyright © 2017年 HXM. All rights reserved.
//

#import "ViewController.h"

#import "DemoVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)push:(id)sender
{
    DemoVC *vc = [[DemoVC alloc] initWithNibName:NSStringFromClass([DemoVC class]) bundle:nil];
    vc.title = @"详情";
    // 隐藏tabbar
//    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    // 取消隐藏tabbar
//    self.hidesBottomBarWhenPushed = NO;
}


@end
