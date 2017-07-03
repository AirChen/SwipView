//
//  ACMainScrollView.h
//  ACSwipView
//
//  Created by AirChen on 2017/2/6.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ACTopBarView;

@interface ACMainScrollView : UIScrollView

@property (nonatomic, strong)NSMutableArray *viewsArray;
@property(nonatomic, strong)ACTopBarView *topBarView;//对外可以修改这个视图
@property (nonatomic, readwrite, assign) CGFloat topBarHeight;

@end
