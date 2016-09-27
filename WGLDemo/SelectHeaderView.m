//
//  SelectHeaderView.m
//  WGLDemo
//
//  Created by 无线动力 on 16/7/5.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "SelectHeaderView.h"

@implementation SelectHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _nameLabel = [UILabel new];
        _nameLabel.numberOfLines = 0;
        _nameLabel.userInteractionEnabled = YES;
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.frame = CGRectMake(10, 5, self.frame.size.width - 20, 30);
        
        [self addSubview:_nameLabel];
    }
    return self;
}

@end
