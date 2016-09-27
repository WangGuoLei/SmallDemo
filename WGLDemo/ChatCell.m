//
//  ChatCell.m
//  WGLDemo
//
//  Created by 无线动力 on 16/5/6.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "ChatCell.h"

@implementation ChatCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGSize winSize = [[UIScreen mainScreen] bounds].size;
    
    //气泡素材
    UIImage* leftImage = [UIImage imageNamed:@"ReceiverTextNodeBkg.png"];
    UIImage* rightImage = [UIImage imageNamed:@"SenderTextNodeBkg.png"];
    leftImage = [leftImage stretchableImageWithLeftCapWidth:30 topCapHeight:35];
    rightImage = [rightImage stretchableImageWithLeftCapWidth:30 topCapHeight:35];
    
    //左边气泡
    self.leftBubble = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 10, 10)];
    self.leftBubble.image = leftImage;
    [self.contentView addSubview:self.leftBubble];
    
    //右边气泡
    self.rightBubble = [[UIImageView alloc] initWithFrame:CGRectMake(winSize.width - 20, 5, 10, 10)];
    self.rightBubble.image = rightImage;
    [self.contentView addSubview:self.rightBubble];
    
    //左边label
    self.leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 10, 10)];
    self.leftLabel.numberOfLines = 0;
    self.leftLabel.font = [UIFont systemFontOfSize:15.0];
    [self.leftBubble addSubview:self.leftLabel];
    
    //右边label
    self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 10, 10)];
    self.rightLabel.numberOfLines = 0;
    self.rightLabel.font = [UIFont systemFontOfSize:15.0];
    [self.rightBubble addSubview:self.rightLabel];
}

@end
