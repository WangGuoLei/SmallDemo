//
//  WaterFall.m
//  WGLDemo
//
//  Created by 无线动力 on 16/4/28.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "WaterFall.h"
#import "WaterFallFlow.h"
#import "WaterFallCell.h"

static CGFloat const kMargin = 10.f;
static NSString * const reuseIdentifier = @"WaterFallCell";

@interface WaterFall ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) WaterFallFlow *layout;

@end

@implementation WaterFall

- (UICollectionView *)collectionView {
    
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[WaterFallCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}

- (WaterFallFlow *)layout {
    
    if (!_layout) {
        _layout = [[WaterFallFlow alloc]init];
        _layout.minimumInteritemSpacing = kMargin;
        _layout.minimumLineSpacing = kMargin;
        _layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return _layout;
}

- (NSMutableArray *)dataList {

    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    CGFloat width = ([UIScreen mainScreen].bounds.size.width-2*kMargin)/3.f;
    for (NSUInteger idx=0; idx<100; idx++) {
        CGFloat height = 100+(arc4random()%100);
        NSValue *value = [NSValue valueWithCGSize:CGSizeMake(width, height)];
        
        [self.dataList addObject:value];
    }
    
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.label.text = [NSString stringWithFormat:@"%zi", indexPath.row];
    cell.label.frame = cell.bounds;
    
    return  cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[_dataList objectAtIndex:indexPath.row] CGSizeValue];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width-2*kMargin)/3.f;
    for (NSUInteger idx=0; idx<50; idx++) {
        CGFloat height = 100+(arc4random()%100);
        NSValue *value = [NSValue valueWithCGSize:CGSizeMake(width, height)];
        
        [_dataList addObject:value];
    }
    
    [self.collectionView reloadData];
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
