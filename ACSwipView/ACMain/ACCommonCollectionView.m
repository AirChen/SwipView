//
//  ACCommonCollectionView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/8.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACCommonCollectionView.h"
#import "GoldHeader.h"
#import "ACTools.h"

@interface ACCommonCollectionView()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation ACCommonCollectionView

#pragma mark - life methods
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareOriganProperty];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareOriganProperty];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self prepareOriganProperty];
    }
    return self;
}

- (void)prepareOriganProperty
{
    self.delegate = self;
    self.dataSource = self;
    
    self.contentInset = UIEdgeInsetsMake(TopBarHeight, 0, 0, 0);
    
    self.backgroundColor = [UIColor orangeColor];
    
    [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Item"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self ac_collectionView:collectionView numberOfItemsInSection:section];
}

- (NSInteger)ac_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self ac_collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

- (UICollectionViewCell *)ac_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Item";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [ACTools randomThemeColor];
    
    NSString *cellTitle = self.itemsArray[indexPath.row];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 40, 20)];
    label.text = cellTitle;
    
    [cell.contentView addSubview:label];
    
    return cell;
}

#pragma mark - notification
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollOffsetYChange:) name:ScrollHeightChange object:nil];
    
}

- (void)scrollOffsetYChange:(NSNotification *)noti
{
    NSNumber *yNumber = noti.userInfo[ScrollHeightKey];
    CGFloat offsetY = [yNumber floatValue];
    
    if (offsetY <= -ItemsBarHeight)
        self.contentOffset = CGPointMake(0, offsetY);
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:ScrollHeightChange];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSNumber *yNumber = [NSNumber numberWithFloat:scrollView.contentOffset.y];
    //    NSLog(@"<--------%@",yNumber);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:yNumber,ScrollHeightKey, nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ScrollHeightChange object:self userInfo:dic];
}


@end
