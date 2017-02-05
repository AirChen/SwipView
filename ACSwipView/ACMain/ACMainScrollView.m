//
//  ACMainScrollView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/4.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACMainScrollView.h"
#import "GoldHeader.h"

@interface ACMainScrollView()<UIScrollViewDelegate>

@end

@implementation ACMainScrollView

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        _backView.backgroundColor = [UIColor yellowColor];
    }
    return _backView;
}

- (UIView *)mainView
{
    if (!_mainView) {
        _mainView = [[UIView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight)];
        
        _mainView.backgroundColor = [UIColor orangeColor];
    }
    return _mainView;
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

- (instancetype)initWithFrame:(CGRect)frame WithBackView:(UIView *)backView AndMainView:(UIView *)mainView {
    
    _mainView = mainView;
    _backView = backView;
    
    return [self initWithFrame:frame];
}

- (void)prepareOriganProps {
    self.contentSize = CGSizeMake(2.0*ScreenWidth, ScreenHeight);
    self.bounces = NO;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:self.backView];
    [self addSubview:self.mainView];
    
    self.delegate = self;
}

@end
