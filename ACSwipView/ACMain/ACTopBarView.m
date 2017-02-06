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

@implementation ACTopBarView

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
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imageViewHeight = self.frame.size.height - ItemsBarHeight;
    self.themeImageView.frame = CGRectMake(0, 0, ScreenWidth, imageViewHeight);
    self.itemsScrollView.frame = CGRectMake(0, imageViewHeight, ScreenWidth, ItemsBarHeight);
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
    self.itemsScrollView.contentSize = CGSizeMake(itemsCount*ItemWidth, ItemHeight);
    
    if (!_buttonsArray) {
        _buttonsArray = [NSMutableArray array];
    }
    for (NSUInteger i = 0; i < itemsCount; i++) {
        UIButton *subButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [subButton setTitle:itemsArray[i] forState:UIControlStateNormal];
        [subButton addTarget:self action:@selector(touchButtonEvents:) forControlEvents:UIControlEventTouchDown];
        subButton.tag = i;
        subButton.frame = CGRectMake(i*ItemWidth, 0, ItemWidth, ItemHeight);
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
}

@end
