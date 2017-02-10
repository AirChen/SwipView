//
//  ACDemoTableView.h
//  ACSwipView
//
//  Created by AirChen on 2017/2/6.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACCommonTableView : UITableView

/**
 字符串数组
 */
@property (nonatomic, copy)NSArray *cellsArray;

@end

@interface ACCommonTableView(ACCommonTableViewSubClassHooks)

- (void)ac_prepareOriganProperty;
- (NSInteger)ac_tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)ac_tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
