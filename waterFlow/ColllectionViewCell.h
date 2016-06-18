//
//  ColllectionViewCell.h
//  WaterFlowDisplay
//
//  Created by B.H.Liu on 12-8-22.
//  Copyright (c) 2012年 Appublisher. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIFont+Scale.h"

@interface ColllectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UILabel* titleLabel;
@property(strong,nonatomic) UITextView *details;

-(void)setLayout:(NSDictionary *)data;

@property(nonatomic)CGRect frame;
@end
