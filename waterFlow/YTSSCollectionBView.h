//
//  YTSSCollectionView.h
//  waterFlow
//
//  Created by roctian on 16/6/17.
//  Copyright © 2016年 roctian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BWaterflowLayout.h"

@protocol YTSSCollectionBViewDelegate <NSObject>

@optional
-(void)returnYTSSCollectionViewHeight:(float)height;

@end

@interface YTSSCollectionBView : UICollectionView <UICollectionViewDataSource,UICollectionViewDelegate,BWaterflowLayoutDelegate>

@property(strong,nonatomic)NSArray *data;

@property(nonatomic)CGFloat maxHeight;

@property(strong,nonatomic) id<YTSSCollectionBViewDelegate> ytssCollectionViewDelegate;
@end
