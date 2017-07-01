//
//  ACTopBarView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/6.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACTopBarView.h"
#import "GoldHeader.h"

@interface ACTopBarView()

@property(nonatomic, strong)UIImageView *themeImageView;
@property(nonatomic, strong)UIScrollView *itemsScrollView;

@property (nonatomic, strong)NSMutableArray *buttonsArray;

@end

@implementation ACTopBarView{
    
    CGFloat itemHeight;
    CGFloat itemWidth;
    
}

#pragma mark - lazyload
- (UIImageView *)themeImageView
{
    if (!_themeImageView) {
        _themeImageView = [[UIImageView alloc] init];
    }
    return _themeImageView;
}

- (UIScrollView *)itemsScrollView
{
    if (!_itemsScrollView) {
        _itemsScrollView = [[UIScrollView alloc] init];
        
        _itemsScrollView.showsHorizontalScrollIndicator = NO;
        _itemsScrollView.bounces = NO;
    }
    return _itemsScrollView;
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
    self.backgroundColor = [UIColor orangeColor];
    
    [self addSubview:self.itemsScrollView];
    [self addSubview:self.themeImageView];
    
    self.idealItemsCount = self.idealItemsCount == 0 ? IdealItemsCount : self.idealItemsCount;
    self.itemBarHeight = self.itemBarHeight * 1 == 0 ? ItemsBarHeight : self.itemBarHeight;
    itemWidth = ScreenWidth / self.idealItemsCount * 1.0;
    itemHeight = self.itemBarHeight;
    
    [self ac_prepareOriganProperty];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageViewHeight = self.frame.size.height - self.itemBarHeight;
    self.themeImageView.frame = CGRectMake(0, 0, ScreenWidth, imageViewHeight);
    self.itemsScrollView.frame = CGRectMake(0, imageViewHeight, ScreenWidth, self.itemBarHeight);
    
    [self ac_layoutSubViews];
}

#pragma mark - openSlots
- (void)setItemsArray:(NSMutableArray *)itemsArray
{
    _itemsArray = itemsArray;
    /*
     itemsScrollView的contentSize
     添加button
     */
    
    NSUInteger itemsCount = itemsArray.count;
    self.itemsScrollView.contentSize = CGSizeMake(itemsCount*itemWidth, itemHeight);
    
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    for (NSUInteger i = 0; i < itemsCount; i++) {
        UIButton *subButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [self ac_modifyButtonTextInButton:subButton withText:self.itemsArray[i]];
        
        [subButton addTarget:self action:@selector(touchButtonEvents:) forControlEvents:UIControlEventTouchDown];
        subButton.tag = i;
        subButton.frame = CGRectMake(i*itemWidth, 0, itemWidth, itemHeight);
        [self.buttonsArray addObject:subButton];
        [self.itemsScrollView addSubview:subButton];
    }
}

- (void)setThemeImage:(UIImage *)themeImage
{
    _themeImage = themeImage;
    
    self.themeImageView.image = themeImage;
}

- (void)touchButtonEvents:(UIButton *)button
{
    [self selectedButtonIndex:button.tag];
    if (self.itemsClicked) {
        self.itemsClicked(button.tag);
    }
}

- (void)selectedButtonIndex:(NSUInteger)index
{
    for (UIButton *btn in self.buttonsArray) {
        if (btn.tag != index) {
            [btn setBackgroundColor:[UIColor clearColor]];
        }else
            [btn setBackgroundColor:[UIColor redColor]];
    }
    
    /*
     控制scrollbar的位置
     1.计算出理想的位置
     1.1 当前的index，总共的count
     1.2 index在count中的位置
     2.滑动
     */
    
    NSUInteger itemsCount = self.buttonsArray.count;
    if (itemsCount <= self.idealItemsCount) {
        return;
    }
    
    NSInteger compareCount = itemsCount - self.idealItemsCount;
    NSInteger adviceIndex = index - 2;
    
    if (adviceIndex <= compareCount) {
        //可以调整
        [UIView animateWithDuration:0.25 animations:^{
            self.itemsScrollView.contentOffset = CGPointMake((adviceIndex*itemWidth >= 0.0? adviceIndex*itemWidth:0.0), 0);
        }];
    }
}

@end

@implementation ACTopBarView (ACTopBarViewSubClassHooks)

- (void)ac_prepareOriganProperty{

}

- (void)ac_layoutSubViews{
    
}

- (UIButton *)ac_modifyButtonTextInButton:(UIButton *)btn withText:(NSString *)str{

    [btn setTitle:str forState:UIControlStateNormal];
    
    return btn;
}

@end

