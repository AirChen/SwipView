//
//  ACMainViewController.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/4.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACMainViewController.h"
#import "GoldHeader.h"

#import "ACMainScrollView.h"
#import "ACTools.h"

@interface ACMainViewController ()

@end

@implementation ACMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    ACMainScrollView *scrollView = [[ACMainScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    NSMutableArray *viewsArray = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 5; i++) {
        UIView *subView = [[UIView alloc] initWithFrame:scrollView.bounds];
        subView.backgroundColor = [ACTools randomThemeColor];
        
        [viewsArray addObject:subView];
    }
    
    scrollView.viewsArray = viewsArray;
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
