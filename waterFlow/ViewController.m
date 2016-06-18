//
//  ViewController.m
//  waterFlow
//
//  Created by roctian on 16/6/17.
//  Copyright © 2016年 roctian. All rights reserved.
//

#import "ViewController.h"
#import "YTSSCollectionView.h"
#import "YTSSCollectionBView.h"

@interface ViewController ()<YTSSCollectionViewDelegate>

@property(strong,nonatomic)YTSSCollectionView *collectionView;
@property(strong,nonatomic)YTSSCollectionBView *collectionBView;

@property(strong,nonnull)UIScrollView *scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor grayColor];
    
     _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,  self.view.frame.size.height-64)];
    
    _collectionView = [[YTSSCollectionView alloc] initWithFrame:CGRectMake(0,0, self.view.frame.size.width,  self.view.frame.size.height-64)];
    _collectionView.ytssCollectionViewDelegate = self;
    
    [_scrollView addSubview:_collectionView];
    
    _collectionBView = [[YTSSCollectionBView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(_collectionView.frame)+10, self.view.frame.size.width,  self.view.frame.size.height-64)];
    
    [_scrollView addSubview:_collectionBView];
    
    [self.view addSubview:_scrollView];
}
-(void)returnYTSSCollectionViewHeight:(float)height{

    [UIView animateWithDuration:0.5 animations:^(){
    
         _collectionView.frame = CGRectMake(0,0, self.view.frame.size.width, height +1);
        
        _collectionBView.frame = CGRectMake(0,CGRectGetMinY(_collectionView.frame)+10+height, self.view.frame.size.width,  self.view.frame.size.height-64);
    
    
    } completion:^(BOOL finished){
    
        _scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(_collectionBView.frame));
    
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
