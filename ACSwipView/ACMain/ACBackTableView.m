//
//  ACBackTableView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/4.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACBackTableView.h"

@interface ACBackTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy)NSArray *testArray;

@end

@implementation ACBackTableView

- (NSArray *)testArray
{
    if (!_testArray) {
        _testArray = [NSArray arrayWithObjects:@"One land",@"Two land",@"Three land",@"Four land",@"Five land", nil];
    }
    return _testArray;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareOriganProps];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareOriganProps];
    }
    return self;
}

- (void)prepareOriganProps {
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.testArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.testArray[indexPath.row];
    
    return cell;
}

@end
