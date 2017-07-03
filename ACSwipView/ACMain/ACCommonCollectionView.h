//
//  ACCommonCollectionView.h
//  ACSwipView
//
//  Created by AirChen on 2017/2/8.
//  Copyright © 2017年 AirChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ACCommonCollectionView : UICollectionView

/**
 字符串数组
 */
@property (nonatomic, copy)NSArray *itemsArray;
@property (nonatomic, readwrite, assign) CGFloat topBarHeight;

@end

@interface ACCommonCollectionView(ACCommonCollectionViewSubHooks)

- (void)ac_prepareOriganProperty;

- (NSInteger)ac_collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell *)ac_collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end
