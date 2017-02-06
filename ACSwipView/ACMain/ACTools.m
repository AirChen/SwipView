//
//  ACTools.m
//  ACSwipView
//
//  Created by AirChen on 2017/2/6.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import "ACTools.h"
#import "GoldHeader.h"
#import <Foundation/Foundation.h>

@implementation ACTools

+ (UIColor *)randomThemeColor
{
    NSArray *themeColors = @[UIColorTheme1,
                        UIColorTheme2,
                        UIColorTheme3,
                        UIColorTheme4,
                        UIColorTheme5,
                        UIColorTheme6,
                        UIColorTheme7,
                        UIColorTheme8,
                        UIColorTheme9];
    return themeColors[arc4random() % 9];
}

@end
