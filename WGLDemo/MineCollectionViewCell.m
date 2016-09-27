//
//  MineCollectionViewCell.m
//  WGLDemo
//
//  Created by 无线动力 on 16/7/1.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "MineCollectionViewCell.h"

@implementation MineCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(5.0, 5.0, frame.size.width - 10.0, frame.size.height - 10.0)];
        [self.contentView addSubview:_cellImage];
    }
    return self;
}

@end
