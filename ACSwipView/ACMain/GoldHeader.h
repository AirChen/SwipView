//
//  GoldHeader.h
//  ACSwipView
//
//  Created by AirChen on 2017/2/4.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#ifndef GoldHeader_h
#define GoldHeader_h

#endif /* GoldHeader_h */

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

/* ACMainScrollView */
#define TopBarHeight 200.0

/* ACTopBarView */
#define ItemsBarHeight 40.0
#define ItemWidth ScreenWidth/4.0
#define ItemHeight ItemsBarHeight

/* ACTools */
#define UIColorMake(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define UIColorTheme1 UIColorMake(239, 83, 98) // Grapefruit
#define UIColorTheme2 UIColorMake(254, 109, 75) // Bittersweet
#define UIColorTheme3 UIColorMake(255, 207, 71) // Sunflower
#define UIColorTheme4 UIColorMake(159, 214, 97) // Grass
#define UIColorTheme5 UIColorMake(63, 208, 173) // Mint
#define UIColorTheme6 UIColorMake(49, 189, 243) // Aqua
#define UIColorTheme7 UIColorMake(90, 154, 239) // Blue Jeans
#define UIColorTheme8 UIColorMake(172, 143, 239) // Lavender
#define UIColorTheme9 UIColorMake(238, 133, 193) // Pink Rose

/* others */
#define Weakify(o) __weak typeof(o) o##Weak = o;

#define Strongify(o) __strong typeof(o) o = o##Weak;
