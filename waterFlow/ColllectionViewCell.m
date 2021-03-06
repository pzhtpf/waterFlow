//
//  ColllectionViewCell.m
//  WaterFlowDisplay
//
//  Created by B.H.Liu on 12-8-22.
//  Copyright (c) 2012年 Appublisher. All rights reserved.
//

/*color */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "ColllectionViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface ColllectionViewCell ()

@property(strong,nonatomic)UILabel *bottomLine;
@property(strong,nonatomic)UILabel *rightLine;

@end

@implementation ColllectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _frame = frame;
        
    
        _bottomLine = [[UILabel alloc] init];
        _bottomLine.backgroundColor = UIColorFromRGB(0xE0E0E8);
    
        [self.contentView addSubview:_bottomLine];
        
        _rightLine = [[UILabel alloc] init];
        _rightLine.backgroundColor = UIColorFromRGB(0xE0E0E8);
        
        [self.contentView addSubview:_rightLine];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 23, frame.size.width-20, 12)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfScaleSize:12.0f];
        _titleLabel.textColor = UIColorFromRGB(0x606073);
        [self.contentView addSubview:_titleLabel];
        
        
        _details = [[UITextView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(_titleLabel.frame)+10, frame.size.width-30, frame.size.height-CGRectGetMaxY(_titleLabel.frame)-20)];

        _details.textColor = UIColorFromRGB(0x302F37);
        _details.font = [UIFont systemFontOfScaleSize:15.0f];
        
        _details.contentInset = UIEdgeInsetsMake(-8,-5,-8, -5);
        _details.editable = NO;
        _details.userInteractionEnabled = NO;
        
//        [_details setBackgroundColor:[UIColor greenColor]];
        
        [self.contentView addSubview:_details];

    }
    return self;
}
-(void)setLayout:(NSDictionary *)data{

    float height = [[data valueForKey:@"height"] floatValue];
    
    _titleLabel.frame = CGRectMake(15, 23, _frame.size.width-30, 12);
    
    int tempHeight = height-CGRectGetMaxY(_titleLabel.frame)-20;
    
    _details.frame = CGRectMake(15, CGRectGetMaxY(_titleLabel.frame)+10, _frame.size.width-20,tempHeight);

    int positionType = [[data valueForKey:@"positionType"] intValue];
    
    int fromX = 0;
    
    if(positionType==0){
        
        _bottomLine.frame = CGRectMake(15,height-0.5, _frame.size.width-15,0.5);
        _rightLine.frame = CGRectMake(_frame.size.width-0.5,23, 0.5,height-46);
        
        _rightLine.hidden = NO;
        
       fromX =  -self.contentView.frame.size.width;
    }
    else{
    
        _bottomLine.frame = CGRectMake(0,height-0.5, _frame.size.width-15,0.5);
        _rightLine.hidden = YES;

        fromX  =  self.contentView.frame.size.width;
    }

//    CATransform3D transform = CATransform3DIdentity;
//    transform = CATransform3DTranslate(transform,fromX, 0.0f, 0.0f);
//    self.contentView.layer.transform = transform;
    
    self.contentView.frame = CGRectMake(fromX, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
        [UIView animateWithDuration:0.5
                         animations:^{
//                             self.contentView.layer.transform = CATransform3DIdentity;
//                             self.contentView.alpha = 1;
//                             self.contentView.layer.shadowOffset = CGSizeMake(0, 0);
                             
                              self.contentView.frame = CGRectMake(0, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height);
                             
                         } completion:^(BOOL finished) {
                         }];

}

@end
