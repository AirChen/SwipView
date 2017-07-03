//
//  ACScrollViewGenerator.h
//  ACSwipView
//
//  Created by Air_chen on 2017/7/3.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ACMainScrollView;

@interface ACScrollViewInfo : NSObject



@end

//工厂类
@interface ACScrollViewGenerator : NSObject

- (ACMainScrollView *)generateScrollViewWithInfo:(ACScrollViewInfo *)info;

@end
