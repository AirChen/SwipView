//
//  ACDemoTableView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/6.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACCommonTableView.h"
#import "GoldHeader.h"
#import "ACTopBarView.h"

@interface ACCommonTableView()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, assign)CGFloat beginOffsetY;

@end

@implementation ACCommonTableView

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

- (void)prepareOriganProperty
{
    self.delegate = self;
    self.dataSource = self;
    
    self.topBarHeight = self.topBarHeight * 1 == 0 ? TopBarHeight : self.topBarHeight;
    self.contentInset = UIEdgeInsetsMake(self.topBarHeight, 0, 0, 0);
    self.beginOffsetY = -self.topBarHeight;
    
    [self ac_prepareOriganProperty];
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

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self ac_tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self ac_tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSNumber *yNumber = [NSNumber numberWithFloat:scrollView.contentOffset.y];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:yNumber,ScrollHeightKey, nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ScrollHeightChange object:self userInfo:dic];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.beginOffsetY = self.contentOffset.y;
}

@end

@implementation ACCommonTableView(ACCommonTableViewSubClassHooks)

- (void)ac_prepareOriganProperty
{
    
}

- (NSInteger)ac_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!_cellsArray) {
        _cellsArray = [NSArray array];
    }
    
    return self.cellsArray.count;
}

- (UITableViewCell *)ac_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = self.cellsArray[indexPath.row];
    
    return cell;
}

@end
