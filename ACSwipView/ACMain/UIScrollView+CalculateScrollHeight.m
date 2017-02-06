//
//  UIScrollView+CalculateScrollHeight.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/6.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "UIScrollView+CalculateScrollHeight.h"
#import "GoldHeader.h"

@implementation UIScrollView (CalculateScrollHeight)

//+ (void)load
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        ReplaceMethod([self class], @selector(layoutSubviews), @selector(ac_layoutSubviews));
//        //ReplaceMethod([self class], @selector(dealloc), @selector(ac_dealloc));
//    });
//}

- (void)ac_layoutSubviews
{
    [self ac_layoutSubviews];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollOffsetYChange:) name:ScrollHeightChange object:nil];
}

- (void)scrollOffsetYChange:(NSNotification *)noti
{
    NSNumber *yNumber = noti.userInfo[ScrollHeightKey];
    CGFloat offsetY = [yNumber floatValue];
    
    self.contentOffset = CGPointMake(0, offsetY);
}

- (void)ac_dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:ScrollHeightChange];
    
    [self ac_dealloc];
}

@end
