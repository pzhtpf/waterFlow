//
//  UICollectionView+ReloadDataFinished.m
//  waterFlow
//
//  Created by tianpengfei on 16/6/18.
//  Copyright © 2016年 roctian. All rights reserved.
//

#import "UICollectionView+ReloadDataFinished.h"

@implementation UICollectionView (ReloadDataFinished)

-(void)reloadDataAndWait:(void(^)(void))waitBlock {
    [self reloadData];
    if(waitBlock){
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            waitBlock();
            
        });
        
        
    }
}

@end
