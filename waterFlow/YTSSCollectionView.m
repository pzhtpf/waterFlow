//
//  YTSSCollectionView.m
//  waterFlow
//
//  Created by roctian on 16/6/17.
//  Copyright © 2016年 roctian. All rights reserved.
//

#import "YTSSCollectionView.h"
#import "ColllectionViewCell.h"

@interface YTSSCollectionView ()

@property(strong,nonatomic)NSMutableArray *heightData;
@property(strong,nonatomic)NSArray *detailsData;
@property(strong,nonatomic)WaterFlowLayout *layout;

@end

@implementation YTSSCollectionView

-(id)initWithFrame:(CGRect)frame{

    _layout = [[WaterFlowLayout alloc] init];
    
    self = [super initWithFrame:frame collectionViewLayout:_layout];
    
    if(self){
    
        [self registerClass:[ColllectionViewCell class] forCellWithReuseIdentifier:@"CELL_ID_LEFT"];
        [self registerClass:[ColllectionViewCell class] forCellWithReuseIdentifier:@"CELL_ID_RIGHT"];
        
         self.allowsSelection = YES;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        
        [((WaterFlowLayout*)self.collectionViewLayout) setFlowdatasource:self];
        [((WaterFlowLayout*)self.collectionViewLayout) setFlowdelegate:self];
        
        self.delegate = self;
        self.dataSource = self;
    
        [self initData];
    }

    return self;
}
-(void)initData{

    _data = @[@"数量",@"生产日期",@"可售区域",@"货源地",@"手续",@"发票类型"];
//    _detailsData = @[@"The WaterflowView(New) is based on a new layout pattern i.e. whenever to place a new cell, find the shortest column and insert the cell into the column, rather than layout by rows in column in the old one. To imply the new one in project, just change the name of file... note that only one file, WaterflowView or WaterflowView(new), should exist in a project Yet if the images for display are mostly of normal size (not super long), the WaterflowView(old) is still recommended.",@"WaterFlowLayout is UICollectionViewLayout specially for the UICollectionView in iOS6. Note that this is not a subclass of UICollectionViewFlowLayout.",@"The WaterflowView(New) is based on a new layout pattern i.e. whenever to place a new cell, find the shortest column and insert the cell into the column, rather than layout by rows in column in the old one. To imply the new one in project, just change the name of file... note that only one file, WaterflowView or WaterflowView(new), should exist in a project Yet if the images for display are mostly of normal size (not super long), the WaterflowView(old) is still recommended.",@"WaterFlowLayout is UICollectionViewLayout specially for the UICollectionView in iOS6. Note that this is not a subclass of UICollectionViewFlowLayout.",@"The WaterflowView(New) is based on a new layout pattern i.e. whenever to place a new cell, find the shortest column and insert the cell into the column, rather than layout by rows in column in the old one. To imply the new one in project, just change the name of file... note that only one file, WaterflowView or WaterflowView(new), should exist in a project Yet if the images for display are mostly of normal size (not super long), the WaterflowView(old) is still recommended.",@"WaterFlowLayout is UICollectionViewLayout specially for the UICollectionView in iOS6. Note that this is not a subclass of UICollectionViewFlowLayout."];
    
    _detailsData =  @[@"1",@"6个月以内",@"售上海",@"售除双江拉祜族，售除双江拉祜族，售除双江拉祜族，售除双江拉祜族售除双江拉祜族售除双江拉祜族售除双江拉祜族售除双江拉祜族售除双江拉祜族",@"3天内寄出",@"店票"];
    
    _heightData = [NSMutableArray new];
    
    int twoWidth = (self.frame.size.width/2)-60;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
            
        for (NSString *string in _detailsData) {
            
            
            CGFloat height = [self getStringHeight:string width:twoWidth];
            [_heightData addObject:@(height)];
            
        }
    
      dispatch_async(dispatch_get_main_queue(), ^{
    
          [self reloadData];
    
          [self getSelfHeight];
          
        });
    });
}


#pragma mark - UICollectionViewDataSource methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ColllectionViewCell *cell;
    
    int  positionType = [self getPositionType:(int)indexPath.item];
    
    if(positionType ==0)
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL_ID_LEFT" forIndexPath:indexPath];
    
    if(positionType ==1)
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL_ID_RIGHT" forIndexPath:indexPath];
    
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

}

#pragma mark-  UICollecitonViewDelegateWaterFlowLayout
- (CGFloat)flowLayout:(WaterFlowLayout *)flowView heightForRowAtIndex:(int)index
{
    return [_heightData[index] floatValue];
}


#pragma mark- UICollectionViewDatasourceFlowLayout
- (NSInteger)numberOfColumnsInFlowLayout:(WaterFlowLayout*)flowlayout
{
    return 2;
}

-(CGFloat)getStringHeight:(NSString *)text width:(int)width{

    CGSize constrainedSize = CGSizeMake(width , MAXFLOAT);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont systemFontOfSize:15.0f], NSFontAttributeName,
                                          nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text attributes:attributesDictionary];
    
    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    int originHeight = 48;
    
    float height = originHeight + requiredHeight.size.height + 10;
    
    height = height<90?90:height;
    
    
    return height;
}

-(void)getSelfHeight{
    
    NSMutableArray *allHeight = [NSMutableArray new];
    
    for (NSArray *items in _layout.cellHeight) {
        
        [allHeight addObjectsFromArray:items];
    }
    
    for (NSNumber *number in allHeight) {
        
        float temp  = [number floatValue];
        
        if(temp>_maxHeight)
            _maxHeight = temp;
    }

    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _maxHeight);
    
    if([_ytssCollectionViewDelegate respondsToSelector:@selector(returnYTSSCollectionViewHeight:)])
        [_ytssCollectionViewDelegate returnYTSSCollectionViewHeight:_maxHeight];
}
-(CGFloat)maxHeight{

    return _maxHeight;
}

-(int)getPositionType:(int)item{

    if(_layout.cellIndex.count==0)
        return 0;
    
    for (int i =0; i<_layout.cellIndex.count; i++) {

    
        NSArray *leftArray = _layout.cellIndex[i];
        
        for (NSNumber *number in leftArray) {
            
            float temp  = [number floatValue];
            
            if(temp == item)
                return i;
        }
    }
    
    return 0;
}
@end
