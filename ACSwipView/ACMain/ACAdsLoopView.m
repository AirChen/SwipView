//
//  ACAdsLoopView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/15.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACAdsLoopView.h"
#import "ACBoxPageControl.h"

@interface ACAdsLoopView()<UIScrollViewDelegate>

/** 数据源 */
@property(nonatomic, strong)NSMutableArray * items;

@property(nonatomic, strong)NSMutableArray * imageSubViews;
/** 是否自动滚动 */
@property(nonatomic, getter = isAutoRoll)BOOL autoRoll;

@property (nonatomic, strong)ACBoxPageControl *pageControl;
@property (nonatomic, strong)UIScrollView *scrollView;

@property (nonatomic, strong)UIImage *placImage;
@property (nonatomic, strong)UIImageView *remindView;

@property(nonatomic, strong)NSTimer * timer;

@end

@implementation ACAdsLoopView

#pragma mark - lazy load
- (ACBoxPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[ACBoxPageControl alloc] init];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        
        _scrollView.scrollsToTop = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIImageView *)remindView
{
    if (!_remindView) {
        _remindView = [[UIImageView alloc] init];
        
        _remindView.backgroundColor = [UIColor whiteColor];
        UIImage * placImage = self.placImage?self.placImage:nil;
        _remindView.image = placImage;
        _remindView.contentMode = UIViewContentModeCenter;
    }
    return _remindView;
}

#pragma mark - life methods
- (instancetype)init{
    if (self = [super init]) {
        
        // 初始化控件
        [self initControl];
        
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 初始化控件
        [self initControl];
        
    }
    return self;
}

- (void)initControl
{
    [self addSubview:self.scrollView];
    [self addSubview:self.pageControl];
    [self.scrollView addSubview:self.remindView];
}

- (void)handleItems:(NSArray *)items
{
    if (items.count == 0) {return;}
    
    NSMutableArray * tempItem = [items mutableCopy];
    
    self.items = tempItem;
    
    id fristItem = [items firstObject];
    id lastItem  = [items lastObject];
    
    [tempItem addObject:fristItem];
    [tempItem insertObject:lastItem atIndex:0];
    
    self.pageControl.numberOfPages = self.items.count - 2;
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    [self setControlFrame];
    
}

- (void)setControlFrame{
    
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.frame = self.bounds;
    self.remindView.frame = self.bounds;
    
    
    CGFloat pageW = self.frame.size.width;
    CGFloat pageY = self.frame.size.height - 12;
    self.pageControl.frame = CGRectMake(0, pageY, pageW, 12);
    
}

/**
 *  添加展示Items
 */
- (void)addItems{
    
    for (int i = 0; i < self.items.count; i++) {
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width + self.scrollView.frame.size.width,0);
        // 添加子视图 - 赋值
        NSDictionary * dic = [self.items objectAtIndex:i];
        UIImageView * imageView = [[UIImageView alloc]init];
        
        imageView.backgroundColor = [UIColor whiteColor];
        imageView.image = [UIImage imageNamed:dic[@"image_url"]];
        imageView.frame = CGRectMake(self.scrollView.frame.size.width*i, 0, self.scrollView.frame.size.width,self.scrollView.frame.size.height);
        
        [self.scrollView  addSubview:imageView];
        [self.imageSubViews addObject:imageView];
    }
    // 移动到起始位置
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width, 0) animated:NO];
    // 添加点击手势
//    [self addTapGestureRecognizer];
    // 判断是否是自动模式
    if (self.isAutoRoll) {
        [self startTimer];
    }
}



- (void)startTimer
{
    if ( !self.timer && self.pageControl.numberOfPages>1) {
        NSTimeInterval pageScrollTime_Normal = 2.0;
        if (self.pageScrollTime) {
            pageScrollTime_Normal = self.pageScrollTime;
        }
        self.timer = [NSTimer timerWithTimeInterval:pageScrollTime_Normal target:self selector:@selector(autoRollAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}


/**
 *  添加手势
 */
//- (void)addTapGestureRecognizer{
//    
//    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCilckAD:)];
//    
//    tapGestureRecognizer.numberOfTapsRequired = 1;
//    tapGestureRecognizer.numberOfTouchesRequired = 1;
//    
//    [self.scrollView addGestureRecognizer:tapGestureRecognizer];
//}

/**
 *  手势响应方法
 */
//- (void)tapCilckAD:(UITapGestureRecognizer *)tapGR{
//    if (self.clickItem) {
//        if (self.models.count>0) {
//            NSDictionary * dic = self.models[self.pageControl.currentPage];
//            self.clickItem(dic,self.pageControl.currentPage);
//        }
//    }
//}

/**
 *  自动滚动方法
 */
- (void)autoRollAction{
    
    
    CGFloat moveItemX = self.scrollView.contentOffset.x + self.scrollView.frame.size.width;
    
    moveItemX = ((NSInteger)moveItemX / (NSInteger)self.scrollView.frame.size.width) * (NSInteger)self.scrollView.frame.size.width;
    
    [self moveItem:moveItemX];
    
}

/**
 *  移动条目
 */
- (void)moveItem:(CGFloat)itemX{
    
    [self.scrollView setContentOffset:CGPointMake(itemX, 0) animated:YES];
}


#pragma mark - ScrollView 代理

/**
 *  滚动调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /**
     *  循环展示
     */
    
    // 偏移量
    CGFloat targetX = scrollView.contentOffset.x;
    
    // 如果偏移量 大于 倒数第二页
    if (targetX >= self.scrollView.frame.size.width * ([self.items count] - 1)) {
        
        // 偏移量设置成第二页
        targetX = self.scrollView.frame.size.width;
        
        // 设置偏移量
        [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
    }
    // 如果小于第一页
    else if(targetX <= 0)
    {
        // 调整到第四页
        targetX = self.scrollView.frame.size.width *([self.items count]-2);
        
        // 设置偏移量
        [_scrollView setContentOffset:CGPointMake(targetX, 0) animated:NO];
    }
    
    
    /**
     *  计算页标
     */
    
    // 偏移量 + item的一半 / item宽
    NSInteger page = (_scrollView.contentOffset.x + self.scrollView.frame.size.width / 2.0) / self.scrollView.frame.size.width;
    
    // 如果移动到第四页 把页标设置为起始位置页标
    page --;
    
    if (page >= self.pageControl.numberOfPages){
        page = 0;
    }
    // 如果移动到了第一页 页标设置成最大页标
    else if(page < 0){
        page = self.pageControl.numberOfPages -1;
    }
    
    // 设置当前页标
    _pageControl.currentPage = page;    
}
/**
 *  开始拖拽
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    if (self.autoRoll) {
        [self stopTimer];
    }
}

/**
 *  停止拖拽
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    if (self.autoRoll) {
        [self startTimer];
    }
    
}

- (void)setModels:(NSArray *)models{
    
    if (models.count>0) {
        self.remindView.hidden = YES;
        _models = models;
        
        for (UIView * view in self.imageSubViews) {
            
            [view removeFromSuperview];
        }
        if (_models.count==1) {
            self.scrollView.scrollEnabled = NO;
            self.pageControl.hidden = YES;
        }
        [self.imageSubViews removeAllObjects];
        
        self.imageSubViews = nil;
        [self.items removeAllObjects];
        self.items = nil;
        
        self.scrollView.contentSize = CGSizeMake(0, 0);
        
        [self stopTimer];
        
        self.autoRoll = YES;
        
        [self setControlFrame];
        
        // 处理items
        [self handleItems:models];
        
        // 添加items
        [self addItems];
    }else{
    }
    
}

- (NSMutableArray *)imageSubViews{
    
    if (_imageSubViews == nil) {
        _imageSubViews = [NSMutableArray array];
        
    }
    return _imageSubViews;
}

@end
