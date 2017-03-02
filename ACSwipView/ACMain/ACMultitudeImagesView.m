//
//  ACMultitudeImagesView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/15.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACMultitudeImagesView.h"

@interface ACMultitudeImagesView()

@property(nonatomic, assign)BOOL hasLine;
@property (nonatomic, strong)NSMutableArray *imageViewsArray;

@end


@implementation ACMultitudeImagesView

- (NSMutableArray *)imageViewsArray
{
    if (!_imageViewsArray) {
        _imageViewsArray = [NSMutableArray array];
    }
    return _imageViewsArray;
}

- (void)prepareSubViews
{
    
}

@end
