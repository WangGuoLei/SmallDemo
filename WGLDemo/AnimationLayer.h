//
//  AnimationLayer.h
//  WGLDemo
//
//  Created by 无线动力 on 16/5/17.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

@interface AnimationLayer : CALayer

@property (nonatomic, retain) CAShapeLayer *pathLayer;
@property (nonatomic, retain) CALayer *penLayer;

/**
 *  字符串画线
 *
 *  @param string    要画的字符串
 *  @param rect      动画位置
 *  @param view      动画所在视图
 *  @param ui_font   动画字体
 *  @param color     字体颜色
 */
+ (void)createAnimationLayerWithString:(NSString *)string Rect:(CGRect)rect View:(UIView *)view Font:(UIFont *)font andStrokeColor:(UIColor *)color;

@end
