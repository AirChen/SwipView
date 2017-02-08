//
//  ACZoomImageView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/8.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACZoomImageView.h"
#import "GoldHeader.h"

@interface ACZoomImageView()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIImageView *imageView;

@end

@implementation ACZoomImageView

#pragma mark - lazyload
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        
    }
    return _imageView;
}

#pragma mark - openslots
- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    // 更新 imageView 的大小时，imageView 可能已经被缩放过，所以要应用当前的缩放
    self.imageView.frame = CGRectApplyAffineTransform(CGRectMakeWithSize(image.size), self.imageView.transform);
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
    [self addSubview:self.scrollView];
    [self addSubview:self.imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (CGRectIsEmpty(self.bounds)) {
        return;
    }
    
    self.scrollView.frame = self.bounds;
}

@end
