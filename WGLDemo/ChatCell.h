//
//  ChatCell.h
//  WGLDemo
//
//  Created by 无线动力 on 16/5/6.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatCell : UITableViewCell

@property (nonatomic, strong) UIImageView *leftBubble;
@property (nonatomic, strong) UIImageView *rightBubble;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end
