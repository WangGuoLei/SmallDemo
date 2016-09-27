//
//  PellTableViewSelect.h
//  WGLDemo
//
//  Created by 无线动力 on 16/4/28.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PellTableViewSelect : UIView

/**
 *  弹出下拉列表
 *
 *  @param frame      尺寸
 *  @param selectData   文字数据源
 *  @param images     对应图片数据源
 *  @param action     点击回调方法
 *  @param animate    是否动画弹出
 */
+ (void)addPellTableViewSelectWithFrame:(CGRect)frame SelectData:(NSArray *)selectData Images:(NSArray *)images Action:(void(^)(NSInteger index))action Animated:(BOOL)animate;

/**
 *  隐藏
 */
+ (void)hiden;

@end
