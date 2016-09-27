//
//  TextListCell.h
//  WGLDemo
//
//  Created by 王国磊 on 16/1/27.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextModel.h"

@interface TextListCell : UITableViewCell

@property (nonatomic, strong)TextModel *model;

/**
 *  cell的展开和收回
 */
@property (nonatomic, copy)void (^showMoreTextBlock)(UITableViewCell *currentCell);

/**
 *  cell(默认/展开)高度
 */
+ (CGFloat)cellDefaultHeught:(TextModel *)model;
+ (CGFloat)cellMoreTextHeight:(TextModel *)model;

@end
