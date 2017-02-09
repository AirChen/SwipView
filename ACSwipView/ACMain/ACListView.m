//
//  ACListView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/9.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACListView.h"
#import "Masonry.h"
#import "GoldHeader.h"

#import "ACListTableView.h"
#import "ACListItemView.h"

@interface ACListView()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIView *contentView;
@property(nonatomic, strong)UIView *lastView;// -> just pointer!

@end

@implementation ACListView

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
    [self.scrollView addSubview:self.contentView];
    [self addSubview:self.scrollView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self addSubViews];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
    }];
    
    for (ACListItemView *view in self.itemViewsArray) {
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (!self.lastView) {
                make.top.equalTo(self.contentView).mas_offset(0);
            }else
                make.top.equalTo(self.lastView.mas_bottom).mas_offset(0);
            
            make.left.equalTo(self.contentView);
            make.right.equalTo(self.contentView);

            if ([view isKindOfClass:[ACListTableView class]]) {
                ACListTableView *tableView = (ACListTableView *)view;
                make.height.mas_offset(tableView.itemsArray.count * tableView.visibleCells[0].bounds.size.height);
            }else
                make.height.mas_offset(kHeightScale(80));
            
        }];
        
        self.lastView = view;
    }
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lastView.mas_bottom);
    }];
}

- (void)addSubViews
{
    if (!self.itemViewsArray || self.itemViewsArray.count == 0) {
        return;
    }
    
    for (ACListItemView *view in self.itemViewsArray) {
        [self.contentView addSubview:view];
    }
}

#pragma mark - lazy load
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        
        _scrollView.delegate = self;
        
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    NSLog(@"top!!!!");
}

@end
