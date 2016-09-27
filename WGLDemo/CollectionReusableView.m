//
//  CollectionReusableView.m
//  WGLDemo
//
//  Created by 无线动力 on 16/7/1.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _title = [[UILabel alloc]initWithFrame:CGRectMake(15.0, 0, frame.size.width - 15.0, frame.size.height)];
        _title.font = [UIFont boldSystemFontOfSize:17.0];
        _title.textAlignment = NSTextAlignmentLeft;
        _title.textColor = [UIColor orangeColor];
        [self addSubview:_title];
    }
    return self;
}

@end
