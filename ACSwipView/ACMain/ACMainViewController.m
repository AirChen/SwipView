//
//  ACMainViewController.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/4.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACMainViewController.h"
#import "GoldHeader.h"

#import "ACZoomImageView.h"

#import "ACMainScrollView.h"
#import "ACTools.h"
#import "ACCommonTableView.h"
#import "ACCommonCollectionView.h"

#import "ACCollectionViewFlowRegularLayout.h"

@interface ACMainViewController ()

@end

@implementation ACMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ACZoomImageView *zoomImageView = [[ACZoomImageView alloc] initWithFrame:self.view.bounds];
    zoomImageView.image = [UIImage imageNamed:@"Unknown"];
    
    [self.view addSubview:zoomImageView];
}

- (void)setupScrollMainView
{
    ACMainScrollView *scrollView = [[ACMainScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    
    NSMutableArray *viewsArray = [NSMutableArray array];
    
    NSMutableArray *cellDataArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < 20; i++) {
        [cellDataArray addObject:[NSString stringWithFormat:@"cellData[%lu]",i]];
    }
    
    for (NSUInteger i = 0; i < 4; i++) {
        ACCommonTableView *subView = [[ACCommonTableView alloc] initWithFrame:scrollView.bounds];
        subView.cellsArray = [cellDataArray mutableCopy];
        subView.backgroundColor = [ACTools randomThemeColor];
        
        [viewsArray addObject:subView];
    }
    
    ACCollectionViewFlowRegularLayout *layout = [[ACCollectionViewFlowRegularLayout alloc] init];
    ACCommonCollectionView *subView1 = [[ACCommonCollectionView alloc] initWithFrame:scrollView.bounds collectionViewLayout:layout];
    subView1.itemsArray = [cellDataArray mutableCopy];
    [viewsArray addObject:subView1];
    
    scrollView.viewsArray = viewsArray;
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
