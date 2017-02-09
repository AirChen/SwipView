//
//  ACListTableView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/9.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACListTableView.h"
#import "ACTools.h"

@interface ACListTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ACListTableView

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
    
    self.scrollEnabled = NO;
    self.showsVerticalScrollIndicator = NO;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = self.itemsArray[indexPath.row];
    
    cell.backgroundColor = [ACTools randomThemeColor];
    
    return cell;
}

@end
