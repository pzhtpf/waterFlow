//
//  UIFont+Scale.m
//  waterFlow
//
//  Created by tianpengfei on 16/6/18.
//  Copyright © 2016年 roctian. All rights reserved.
//

#import "UIFont+Scale.h"

@implementation UIFont (Scale)

+ (UIFont *)systemFontOfScaleSize:(float)size{

    if(IS_IPHONE_4_OR_LESS)
        size = size - 3;
    
    else if(IS_IPHONE_5)
        size = size - 2;
    
    return [self systemFontOfSize:size];
}

@end
