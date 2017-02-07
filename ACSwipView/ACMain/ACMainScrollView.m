//
//  ACMainScrollView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/6.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACMainScrollView.h"
#import "GoldHeader.h"
#import "ACTopBarView.h"

@interface ACMainScrollView()<UIScrollViewDelegate>

@property(nonatomic, strong)ACTopBarView *topBarView;

@end

@implementation ACMainScrollView
#pragma mark - lazy load
- (ACTopBarView *)topBarView
{
    if (!_topBarView) {
        _topBarView = [[ACTopBarView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, TopBarHeight)];
        
        Weakify(self)
        _topBarView.itemsClicked = ^(NSUInteger index){
            Strongify(self);
            self.contentOffset = CGPointMake(index*ScreenWidth, 0);
        };
    }
    return _topBarView;
}

#pragma mark - open slots
- (void)setViewsArray:(NSMutableArray *)viewsArray
{
    _viewsArray = viewsArray;
    /*
     初始化scrollview，contentSize
     修改每个view的frame，添加到scrollview
     
     创建topBar并添加
     */
    
    if (!viewsArray || viewsArray.count == 0) {
        return;
    }
    
    NSUInteger viewsCount = viewsArray.count;
    self.contentSize = CGSizeMake(viewsCount*ScreenWidth, ScreenHeight);
    
    NSMutableArray *itemsTitleArray = [NSMutableArray array];
    for (NSUInteger i = 0; i < viewsCount; i++) {
        UIView *subView = viewsArray[i];
        subView.frame = CGRectMake(i*ScreenWidth, 0, ScreenWidth, ScreenHeight);
        [self addSubview:subView];
        
        [itemsTitleArray addObject:[NSString stringWithFormat:@"item[%lu]",(unsigned long)i]];
    }
    
    self.topBarView.themeImage = [UIImage imageNamed:@"Unknown"];
    self.topBarView.itemsArray = itemsTitleArray;
    [self addSubview:self.topBarView];
    
    [self.topBarView selectedButtonIndex:0];
}

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
    self.bounces = NO;
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
}

#pragma mark - notification
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentViewHeightChange:) name:ScrollHeightChange object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:ScrollHeightChange];
}

- (void)contentViewHeightChange:(NSNotification *)noti
{
    NSNumber *yNumber = noti.userInfo[ScrollHeightKey];
    CGFloat offsetY = [yNumber floatValue];
        
    if (offsetY <= -ItemsBarHeight) {
        CGSize topViewSize = self.topBarView.frame.size;
        CGPoint topViewPoint = self.topBarView.frame.origin;
        self.topBarView.frame = CGRectMake(topViewPoint.x, -(TopBarHeight+offsetY), topViewSize.width, topViewSize.height);
    }else{
        NSLog(@"----->%f",offsetY);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    CGSize topViewSize = self.topBarView.frame.size;
    CGPoint topViewPoint = self.topBarView.frame.origin;
    self.topBarView.frame = CGRectMake(contentOffsetX, topViewPoint.y, topViewSize.width, topViewSize.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat contentOffsetX = scrollView.contentOffset.x;

    NSUInteger buttonIndex = contentOffsetX/ScreenWidth;
    [self.topBarView selectedButtonIndex:buttonIndex];
}

@end
