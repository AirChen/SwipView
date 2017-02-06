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

@property (nonatomic, copy)TopBarItmesClicked itemsClicked;

- (void)selectedButtonIndex:(NSUInteger)index;

@end
