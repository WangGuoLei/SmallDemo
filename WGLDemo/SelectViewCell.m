//
//  SelectViewCell.m
//  WGLDemo
//
//  Created by 无线动力 on 16/7/5.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "SelectViewCell.h"
#import "CollectionViewCell.h"

@interface SelectViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *indexArray;
    NSInteger kk;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation SelectViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        kk = 100000;
        indexArray = [NSArray arrayWithObjects:@{@"num":@[@"问题1", @"问题2", @"问题3", @"问题4", @"问题5", @"问题6", @"问题7", @"问题8", @"请点击复合你的)"]}, nil];
        
        [self setCollectionView];
    }
    return self;
}

- (void)setCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,60) collectionViewLayout:layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_collectionView];
    
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"Four"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[[indexArray objectAtIndex:0] objectForKey:@"num"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *myBig = nil;
    if (!myBig) {
        myBig = [collectionView dequeueReusableCellWithReuseIdentifier:@"Four" forIndexPath:indexPath];
    }
    
    [myBig setName:[[[indexArray objectAtIndex:0]objectForKey:@"num"]objectAtIndex:indexPath.row]];
    _collectionView.frame = CGRectMake(0, 0, self.frame.size.width, ([[[indexArray objectAtIndex:0]objectForKey:@"num"] count]/4 + [[[indexArray objectAtIndex:0]objectForKey:@"num"] count]%4) * 40);
    
    if (kk == indexPath.row) {
        myBig.nameLabel.backgroundColor = [UIColor redColor];
    }
    return myBig;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.frame.size.width - 60)/4, 30);
}

// 设置每个cell上下左右相距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    kk = indexPath.row;
    [_collectionView reloadData];
}

// 返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 设置是否允许取消选中
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 取消选中操作
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
