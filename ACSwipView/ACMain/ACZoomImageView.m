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
        
        _scrollView.minimumZoomScale = 0;
        _scrollView.maximumZoomScale = self.maximumZoomScale;
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
    
//    self.imageView.center = self.center;
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
    [self.scrollView addSubview:self.imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (CGRectIsEmpty(self.bounds)) {
        return;
    }
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTapGestureWithPoint:)];
    doubleTapGesture.numberOfTapsRequired = 2;
    doubleTapGesture.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:doubleTapGesture];
    
    self.scrollView.frame = self.bounds;
}

#pragma mark - gesture Events

- (void)handleDoubleTapGestureWithPoint:(UITapGestureRecognizer *)gestureRecognizer {
    CGPoint gesturePoint = [gestureRecognizer locationInView:gestureRecognizer.view];
    
    // 如果图片被压缩了，则第一次放大到原图大小，第二次放大到最大倍数
    if (self.scrollView.zoomScale >= self.scrollView.maximumZoomScale) {
        [self setZoomScale:self.scrollView.minimumZoomScale animated:YES];
    } else {
        CGFloat newZoomScale = 0;
        if (self.scrollView.zoomScale < 1) {
            // 如果目前显示的大小比原图小，则放大到原图
            newZoomScale = 1;
        } else {
            // 如果当前显示原图，则放大到最大的大小
            newZoomScale = self.scrollView.maximumZoomScale;
        }
        
        CGRect zoomRect = CGRectZero;
        CGPoint tapPoint = [self.imageView convertPoint:gesturePoint fromView:gestureRecognizer.view];
        zoomRect.size.width = CGRectGetWidth(self.bounds) / newZoomScale;
        zoomRect.size.height = CGRectGetHeight(self.bounds) / newZoomScale;
        zoomRect.origin.x = tapPoint.x - CGRectGetWidth(zoomRect) / 2;
        zoomRect.origin.y = tapPoint.y - CGRectGetHeight(zoomRect) / 2;
        
        [self zoomToRect:zoomRect animated:YES];
    }
}

- (void)zoomToRect:(CGRect)rect animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            [self.scrollView zoomToRect:rect animated:NO];
        }];
    } else {
        [self.scrollView zoomToRect:rect animated:NO];
    }
}
#pragma mark - others
- (void)setContentMode:(UIViewContentMode)contentMode {
    BOOL isContentModeChanged = self.contentMode != contentMode;
    [super setContentMode:contentMode];
    if (isContentModeChanged) {
        [self revertZooming];
    }
}

- (void)setFrame:(CGRect)frame {
    BOOL isBoundsChanged = !CGSizeEqualToSize(frame.size, self.frame.size);
    [super setFrame:frame];
    if (isBoundsChanged) {
        [self revertZooming];
    }
}

- (void)revertZooming {
    if (CGRectIsEmpty(self.bounds)) {
        return;
    }
    
    CGFloat minimumZoomScale = [self minimumZoomScale];
    CGFloat maximumZoomScale = self.maximumZoomScale;
    maximumZoomScale = fmaxf(minimumZoomScale, maximumZoomScale);// 可能外部通过 contentMode = UIViewContentModeScaleAspectFit 的方式来让小图片撑满当前的 zoomImageView，所以算出来 minimumZoomScale 会很大（至少比 maximumZoomScale 大），所以这里要做一个保护
    CGFloat zoomScale = minimumZoomScale;
    BOOL shouldFireDidZoomingManual = zoomScale == self.scrollView.zoomScale;
    self.scrollView.panGestureRecognizer.enabled = YES;
    self.scrollView.pinchGestureRecognizer.enabled = YES;
    self.scrollView.minimumZoomScale = minimumZoomScale;
    self.scrollView.maximumZoomScale = maximumZoomScale;
    [self setZoomScale:zoomScale animated:NO];
    
    // 只有前后的 zoomScale 不相等，才会触发 UIScrollViewDelegate scrollViewDidZoom:，因此对于相等的情况要自己手动触发
    if (shouldFireDidZoomingManual) {
        [self handleDidEndZooming];
    }
}

- (void)handleDidEndZooming {
    UIView *imageView = self.imageView;
    CGRect imageViewFrame = [self convertRect:imageView.frame fromView:imageView.superview];
    CGSize viewportSize = self.bounds.size;
    UIEdgeInsets contentInset = UIEdgeInsetsZero;
    if (!CGRectIsEmpty(imageViewFrame) && !CGSizeIsEmpty(viewportSize)) {
        if (CGRectGetWidth(imageViewFrame) < viewportSize.width) {
            // 用 floorf 而不是 flatf，是因为 flatf 本质上是向上取整，会导致 left + right 比实际的大，然后 scrollView 就认为可滚动了
            contentInset.left = contentInset.right = floorf((viewportSize.width - CGRectGetWidth(imageViewFrame)) / 2.0);
        }
        if (CGRectGetHeight(imageViewFrame) < viewportSize.height) {
            // 用 floorf 而不是 flatf，是因为 flatf 本质上是向上取整，会导致 top + bottom 比实际的大，然后 scrollView 就认为可滚动了
            contentInset.top = contentInset.bottom = floorf((viewportSize.height - CGRectGetHeight(imageViewFrame)) / 2.0);
        }
    }
    self.scrollView.contentInset = contentInset;
    self.scrollView.contentSize = imageView.frame.size;
    
    if (self.scrollView.contentInset.top > 0) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, -self.scrollView.contentInset.top);
    }
    
    if (self.scrollView.contentInset.left > 0) {
        self.scrollView.contentOffset = CGPointMake(-self.scrollView.contentInset.left, self.scrollView.contentOffset.y);
    }
}

- (CGFloat)minimumZoomScale {
    CGRect viewport = self.bounds;
    if (CGRectIsEmpty(viewport) || !self.image) {
        return 1;
    }
    
    CGSize imageSize = self.image.size;
    
    CGFloat minScale = 1;
    CGFloat scaleX = CGRectGetWidth(viewport) / imageSize.width;
    CGFloat scaleY = CGRectGetHeight(viewport) / imageSize.height;
    if (self.contentMode == UIViewContentModeScaleAspectFit) {
        minScale = fminf(scaleX, scaleY);
    } else if (self.contentMode == UIViewContentModeScaleAspectFill) {
        minScale = fmaxf(scaleX, scaleY);
    } else if (self.contentMode == UIViewContentModeCenter) {
        if (scaleX >= 1 && scaleY >= 1) {
            minScale = 1;
        } else {
            minScale = fminf(scaleX, scaleY);
        }
    }
    return minScale;
}

- (void)setZoomScale:(CGFloat)zoomScale animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.scrollView.zoomScale = zoomScale;
        }];
    } else {
        self.scrollView.zoomScale = zoomScale;
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self handleDidEndZooming];
}

@end
