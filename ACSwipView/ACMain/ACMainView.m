//
//  ACMainView.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/4.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACMainView.h"

@implementation ACMainView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareOriganProps];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self prepareOriganProps];
    }
    return self;
}

- (void)prepareOriganProps {
    
    self.backgroundColor = [UIColor redColor];
    
}

@end
