//
//  TextListCell.m
//  WGLDemo
//
//  Created by 王国磊 on 16/1/27.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "TextListCell.h"

#define Width [UIScreen mainScreen].bounds.size.width

@implementation TextListCell
{
    UILabel *_textTitle;
    UILabel *_textContent;
    UIButton *_moreButton;
}

+ (CGFloat)cellDefaultHeught:(TextModel *)model {
    // 默认高度
    return 85.0;
}

+ (CGFloat)cellMoreTextHeight:(TextModel *)model {
    // 展开后高度(文本的高度+固件高度)
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin);
    CGSize size = [model.textContent boundingRectWithSize:CGSizeMake(Width - 30, 100000) options:option attributes:attribute context:nil].size;
    return size.height + 50;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textTitle = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 240, 20)];
        _textTitle.textColor = [UIColor blackColor];
        _textTitle.font = [UIFont systemFontOfSize:18];
        [self.contentView addSubview:_textTitle];
        
        _textContent = [[UILabel alloc]initWithFrame:CGRectMake(15, 30,Width - 30 , 20)];
        _textContent.textColor = [UIColor blackColor];
        _textContent.font = [UIFont systemFontOfSize:16];
        _textContent.numberOfLines = 0;
        [self.contentView addSubview:_textContent];
        
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _moreButton.frame = CGRectMake(Width - 50, 5, 40, 20);
        [self.contentView addSubview:_moreButton];
        [_moreButton addTarget:self action:@selector(showMoreText) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textTitle.text = self.model.textName;
    _textContent.text = self.model.textContent;
    if (self.model.isShowMoreText) {
        [_textContent setFrame:CGRectMake(15, 30, Width - 30, [TextListCell cellMoreTextHeight:_model] - 50)];
        [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
    } else {
        [_moreButton setTitle:@"展开" forState:UIControlStateNormal];
        [_textContent setFrame:CGRectMake(15, 30, Width - 30, 35)];
    }
}

- (void)showMoreText {
    //将当前对象的isShowMoreText属性设为相反值
    self.model.isShowMoreText = !self.model.isShowMoreText;
    if (self.showMoreTextBlock) {
        self.showMoreTextBlock(self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
