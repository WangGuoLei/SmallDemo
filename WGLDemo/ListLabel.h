//
//  ListLabel.h
//  WGLDemo
//
//  Created by 无线动力 on 16/5/6.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListLabel : UIView
{
    CGRect previousFrame;
    int totalHeight;
}

/**
 * 整个view的背景色
 */
@property(nonatomic, retain) UIColor *GBbackgroundColor;

/**
 *  设置单一颜色
 */
@property(nonatomic, retain) UIColor *signalTagColor;

/**
 *  标签文本赋值
 */
- (void)setTagWithTagArray:(NSArray *)arr;

@end
