//
//  ACMainScrollView.h
//  ACSwipView
//
//  Created by AirChen on 2017/2/4.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACMainScrollView : UIScrollView

@property (nonatomic, strong)UIView *backView;
@property (nonatomic, strong)UIView *mainView;

- (instancetype)initWithFrame:(CGRect)frame WithBackView:(UIView *)backView AndMainView:(UIView *)mainView;

@end
