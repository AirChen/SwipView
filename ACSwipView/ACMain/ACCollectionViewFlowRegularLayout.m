//
//  ACCollectionViewFlowRegularLayout.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/8.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACCollectionViewFlowRegularLayout.h"

@implementation ACCollectionViewFlowRegularLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(60, 40);
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.minimumInteritemSpacing = 10.0f;
        self.minimumLineSpacing = 10.0f;
    }
    return self;
}

@end
