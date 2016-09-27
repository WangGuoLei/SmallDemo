//
//  WaterFallCell.m
//  WGLDemo
//
//  Created by 无线动力 on 16/4/28.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "WaterFallCell.h"

@implementation WaterFallCell

#pragma mark - 懒加载

- (UILabel *)label {
    
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:30];
        _label.textColor = [UIColor whiteColor];
    }
    return _label;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.contentView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.label];
    }
    return self;
}

@end
