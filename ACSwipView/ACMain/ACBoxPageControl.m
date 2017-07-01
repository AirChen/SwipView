//
//  ACBoxPageControlView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/15.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACBoxPageControl.h"

@interface ACBoxPageControl()

@property(nonatomic, strong)NSMutableArray *viewsArray;

@property (nonatomic, assign)NSUInteger prePage;

@end

@implementation ACBoxPageControl

@synthesize numberOfPages = _numberOfPages;

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareForOrigan];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareForOrigan];
    }
    return self;
}

- (void)prepareForOrigan
{
    self.prePage = 0;
}

- (NSMutableArray *)viewsArray
{
    if (!_viewsArray) {
        _viewsArray = [NSMutableArray array];
    }
    return _viewsArray;
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    //添加子视图
    for (NSUInteger i = 0; i < numberOfPages; i++) {
        UIView *view = [[UIView alloc] init];
        view.tag = i;
        [self.viewsArray addObject:view];
        [self addSubview:view];
    }
}

- (NSInteger)numberOfPages
{
    return self.viewsArray.count;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
//    对应的子视图变色
    if (self.prePage == currentPage) {
        return;
    }
    
    UIView *preView = self.viewsArray[self.prePage];
    UIView *curView = self.viewsArray[currentPage];
    
    [UIView animateWithDuration:0.25 animations:^{
        preView.backgroundColor = self.pageIndicatorTintColor;
        curView.backgroundColor = self.currentPageIndicatorTintColor;
    }];
    
    self.prePage = currentPage;
}

- (void)layoutSubviews
{
//    布局子视图 color frame
    
    CGFloat currentX = (self.frame.size.width - (self.viewsArray.count-1)*13.0+11.0)/2.0;
    for (UIView *view in self.viewsArray) {
        if (view.tag == 0) {
            view.backgroundColor = self.currentPageIndicatorTintColor;
        }else
            view.backgroundColor = self.pageIndicatorTintColor;
        
        view.frame = CGRectMake(currentX, 5.0, 11.0, 2.0);
        
        currentX += 13.0;
    }
}

@end
