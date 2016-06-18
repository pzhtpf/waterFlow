//
//  YTSSCollectionView.m
//  waterFlow
//
//  Created by roctian on 16/6/17.
//  Copyright © 2016年 roctian. All rights reserved.
//

#import "YTSSCollectionBView.h"
#import "ColllectionViewCell.h"
#import "UICollectionView+ReloadDataFinished.h"
#import "UIFont+Scale.h"

@interface YTSSCollectionBView ()

@property(strong,nonatomic)NSMutableArray *heightData;
@property(strong,nonatomic)NSArray *detailsData;
@property(strong,nonatomic)BWaterflowLayout * layout;

@end

@implementation YTSSCollectionBView

-(id)initWithFrame:(CGRect)frame{
    
    _layout = [[BWaterflowLayout alloc]init];
    
    _layout.delegate = self;
    
    self = [super initWithFrame:frame collectionViewLayout:_layout];
    
    if(self){
    
        [self registerClass:[ColllectionViewCell class] forCellWithReuseIdentifier:@"CELL_ID_LEFT_B"];
        [self registerClass:[ColllectionViewCell class] forCellWithReuseIdentifier:@"CELL_ID_RIGHT_B"];
        
         self.allowsSelection = YES;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        self.delegate = self;
        self.dataSource = self;
    
        [self initData];
    }

    return self;
}
-(void)initData{

    _data = @[@"数量",@"生产日期",@"可售区域",@"货源地",@"手续",@"发票类型"];
//    _detailsData = @[@"The WaterflowView(New) is based on a new layout pattern i.e. whenever to place a new cell, find the shortest column and insert the cell into the column, rather than layout by rows in column in the old one. To imply the new one in project, just change the name of file... note that only one file, WaterflowView or WaterflowView(new), should exist in a project Yet if the images for display are mostly of normal size (not super long), the WaterflowView(old) is still recommended.",@"WaterFlowLayout is UICollectionViewLayout specially for the UICollectionView in iOS6. Note that this is not a subclass of UICollectionViewFlowLayout.",@"The WaterflowView(New) is based on a new layout pattern i.e. whenever to place a new cell, find the shortest column and insert the cell into the column, rather than layout by rows in column in the old one. To imply the new one in project, just change the name of file... note that only one file, WaterflowView or WaterflowView(new), should exist in a project Yet if the images for display are mostly of normal size (not super long), the WaterflowView(old) is still recommended.",@"WaterFlowLayout is UICollectionViewLayout specially for the UICollectionView in iOS6. Note that this is not a subclass of UICollectionViewFlowLayout.",@"The WaterflowView(New) is based on a new layout pattern i.e. whenever to place a new cell, find the shortest column and insert the cell into the column, rather than layout by rows in column in the old one. To imply the new one in project, just change the name of file... note that only one file, WaterflowView or WaterflowView(new), should exist in a project Yet if the images for display are mostly of normal size (not super long), the WaterflowView(old) is still recommended.",@"WaterFlowLayout is UICollectionViewLayout specially for the UICollectionView in iOS6. Note that this is not a subclass of UICollectionViewFlowLayout."];
    
    _detailsData =  @[@"1",@"6个月以内",@"售上海",@"售除双江拉祜族,售除双江拉祜族",@"3天内寄出",@"店票"];
    
    
    NSMutableArray  *tempHeightData = [NSMutableArray new];
    
    int twoWidth = (self.frame.size.width/2)-30;

    
     UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, twoWidth, 1)];
     textView.contentInset = UIEdgeInsetsMake(-8,-5, -8,-5 );
     textView.font = [UIFont systemFontOfScaleSize:14.5f];
    
        for (NSString *string in _detailsData) {
            
            textView.frame = CGRectMake(0, 0, twoWidth, 1);
            
            textView.text = string;
            [textView sizeToFit];
            [textView layoutIfNeeded];
            
            CGFloat height = textView.frame.size.height-16;
            
//             NSLog(@"cellHeight:%f",height);
            
            int originHeight = 45;
            
            height = originHeight + height + 10;
            
            height = height<90?90:height;
            
            [tempHeightData addObject:@(height)];
            
           
        }


        _heightData = tempHeightData;
          
          
          [self reloadDataAndWait:^(){
          
//              [self getSelfHeight];
          
          }];
    
}


#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _heightData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColllectionViewCell *cell;
    
//    int  positionType = [self getPositionType:(int)indexPath.item];
    
    int  positionType = indexPath.item%2;
    
    if(positionType ==0)
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL_ID_LEFT_B" forIndexPath:indexPath];
    
    if(positionType ==1)
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL_ID_RIGHT_B" forIndexPath:indexPath];
    
    cell.titleLabel.text = _data[indexPath.item];
    cell.details.text = _detailsData[indexPath.item];
    
    [cell setLayout:@{@"height":_heightData[indexPath.item],@"positionType":@(positionType)}];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate methods
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld selected", indexPath.item);
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    int  positionType = [self getPositionType:(int)indexPath.item];
//
//    int fromX = 0;
//    
//    if(positionType==0){
//        
//        fromX =  -cell.contentView.frame.size.width;
//    }
//    else{
//        
//        fromX  =  cell.contentView.frame.size.width;
//    }
//    
//    CATransform3D transform = CATransform3DIdentity;
//    transform = CATransform3DTranslate(transform,fromX, 0.0f, 0.0f);
//    cell.contentView.layer.transform = transform;
//    
//    [UIView animateWithDuration:0.5
//                     animations:^{
//                         cell.contentView.layer.transform = CATransform3DIdentity;
//                         cell.contentView.alpha = 1;
//                         cell.contentView.layer.shadowOffset = CGSizeMake(0, 0);
//                     } completion:^(BOOL finished) {
//                     }];

}

#pragma mark-  UICollecitonViewDelegateWaterFlowLayout
#pragma mark - <BWaterflowLayoutDelegate>

-(CGFloat)waterflowLayout:(BWaterflowLayout *)waterflowLayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth {
    
    return [_heightData[index] floatValue];
}
//瀑布流列数
- (CGFloat)columnCountInWaterflowLayout:(BWaterflowLayout *)waterflowLayout {
    return 2;
}
- (CGFloat)columnMarginInWaterflowLayout:(BWaterflowLayout *)waterflowLayout {
    return 10;
    
}
- (CGFloat)rowMarginInWaterflowLayout:(BWaterflowLayout *)waterflowLayout {
    return 10;
    
}
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(BWaterflowLayout *)waterflowLayout {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

//-(void)getSelfHeight{
//    
//    NSMutableArray *allHeight = [NSMutableArray new];
//    
//    for (NSArray *items in _layout.cellHeight) {
//        
//        [allHeight addObjectsFromArray:items];
//    }
//    
//    for (NSNumber *number in allHeight) {
//        
//        float temp  = [number floatValue];
//        
//        if(temp>_maxHeight)
//            _maxHeight = temp;
//    }
//
//    [UIView animateWithDuration:0.5 animations:^(){
//    
//        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _maxHeight);
//
//    
//    }];
//    
//    if([_ytssCollectionViewDelegate respondsToSelector:@selector(returnYTSSCollectionViewHeight:)])
//        [_ytssCollectionViewDelegate returnYTSSCollectionViewHeight:_maxHeight];
//}
-(CGFloat)maxHeight{

    return _maxHeight;
}
@end
