//
//  CollectionViewCell.m
//  WGLDemo
//
//  Created by 无线动力 on 16/7/5.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = 3.0f;
    self.layer.masksToBounds = YES;
    [self setTintColor:[UIColor orangeColor]];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor redColor].CGColor;
    
    _nameLabel = [UILabel new];
    _nameLabel.numberOfLines = 0;
    _nameLabel.userInteractionEnabled = YES;
    _nameLabel.textColor = [UIColor yellowColor];
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.frame = CGRectMake(0, 0, (375 - 60)/4, 30);
    
    [self.contentView addSubview:_nameLabel];
}

- (void)setName:(NSString *)name
{
    _nameLabel.text = name;
    _nameLabel.backgroundColor = [UIColor orangeColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
