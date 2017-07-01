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

#import "ACListView.h"
#import "ACListItemView.h"
#import "ACListTableView.h"

#import "ACAdsLoopView.h"

@interface ACMainViewController ()

@end

@implementation ACMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupListView];
}

- (void)setupLoopView
{
    ACAdsLoopView *view = [[ACAdsLoopView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 300)];
    
    NSMutableArray *itemArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < 6; i++) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithObject:@"Unknown" forKey:@"image_url"];
        [itemArray addObject:dic];
    }
    
    view.models = itemArray;
    
    view.layer.cornerRadius = 20;
    view.layer.masksToBounds = YES;
    
    [self.view addSubview:view];

}

- (void)setupListView
{
    NSMutableArray *itemViewsArray = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 30; i++) {
        ACListItemView *itemView = [[ACListItemView alloc] init];
        itemView.backgroundColor = [ACTools randomThemeColor];
        
        [itemViewsArray addObject:itemView];
    }
    
    NSMutableArray *cellDataArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < 20; i++) {
        [cellDataArray addObject:[NSString stringWithFormat:@"cellData[%lu]",i]];
    }
    ACListTableView *listTableView = [[ACListTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    listTableView.itemsArray = cellDataArray;
    [itemViewsArray addObject:listTableView];
    
    for (NSUInteger i = 0; i < 30; i++) {
        ACListItemView *itemView = [[ACListItemView alloc] init];
        itemView.backgroundColor = [ACTools randomThemeColor];
        
        [itemViewsArray addObject:itemView];
    }
    
    ACListView *listView = [[ACListView alloc] initWithFrame:self.view.bounds];
    listView.itemViewsArray = itemViewsArray;
    
    [self.view addSubview:listView];
}

- (void)setupZoomView
{
    ACZoomImageView *zoomImageView = [[ACZoomImageView alloc] initWithFrame:self.view.bounds];
    zoomImageView.image = [UIImage imageNamed:@"Unknown"];
    zoomImageView.maximumZoomScale = 2.0;
    zoomImageView.contentMode = UIViewContentModeScaleAspectFit;
    
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
