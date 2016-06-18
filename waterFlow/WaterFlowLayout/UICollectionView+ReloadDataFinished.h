//
//  UICollectionView+ReloadDataFinished.h
//  waterFlow
//
//  Created by tianpengfei on 16/6/18.
//  Copyright © 2016年 roctian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (ReloadDataFinished)

-(void)reloadDataAndWait:(void(^)(void))waitBlock;

@end
