//
//  Photos.h
//  WGLDemo
//
//  Created by 无线动力 on 16/4/29.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PhotoState) {
    PhotoStateNormal,
    PhotoStateBig,
    PhotoStateDraw,
    PhotoStateTogether
};

@interface Photos : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *drawView;
@property (nonatomic, assign) float speed;
@property (nonatomic, assign) CGRect oldFrame;
@property (nonatomic, assign) float oldSpeed;
@property (nonatomic, assign) float oldAlpha;
@property (nonatomic, assign) int state;

- (void)updateImage:(UIImage *)image;
- (void)setImageAlphaAndSpeedAndSize:(float)alpha;

@end
