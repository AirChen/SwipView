//
//  ACTopBarView.h
//  ACSwipView
//
//  Created by AirChen on 2017/2/6.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TopBarItmesClicked)(NSUInteger index);

@interface ACTopBarView : UIView

@property (nonatomic, strong)NSMutableArray *itemsArray;
@property (nonatomic, strong)UIImage *themeImage;
@property (nonatomic, readwrite, assign) NSInteger idealItemsCount;
@property (nonatomic, readwrite, assign) CGFloat itemBarHeight;

@property (nonatomic, copy)TopBarItmesClicked itemsClicked;

- (void)selectedButtonIndex:(NSUInteger)index;

@end

@interface ACTopBarView (ACTopBarViewSubClassHooks)

- (void)ac_prepareOriganProperty;
- (void)ac_layoutSubViews;

//自定义按键
- (UIButton *)ac_modifyButtonTextInButton:(UIButton *)btn withText:(NSString *)str;

@end
