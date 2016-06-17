//
//  YTSSCollectionView.h
//  waterFlow
//
//  Created by roctian on 16/6/17.
//  Copyright © 2016年 roctian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaterFlowLayout.h"

@protocol YTSSCollectionViewDelegate <NSObject>

@optional
-(void)returnYTSSCollectionViewHeight:(float)height;

@end

@interface YTSSCollectionView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate,UICollecitonViewDelegateWaterFlowLayout,UICollectionViewDataSourceWaterFlowLayout>

@property(strong,nonatomic)NSArray *data;

@property(nonatomic)CGFloat maxHeight;

@property(strong,nonatomic) id<YTSSCollectionViewDelegate> ytssCollectionViewDelegate;
@end
