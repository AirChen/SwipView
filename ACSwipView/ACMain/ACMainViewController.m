//
//  ACMainViewController.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/4.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACMainViewController.h"
#import "ACMainScrollView.h"
#import "ACMainView.h"
#import "ACBackTableView.h"
#import "GoldHeader.h"

@interface ACMainViewController ()

@end

@implementation ACMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ACMainView *mainView = [[ACMainView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight)];
    ACBackTableView *backTableView = [[ACBackTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    ACMainScrollView *mainScrollView = [[ACMainScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) WithBackView:backTableView AndMainView:mainView];
    
    [self.view addSubview:mainScrollView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
