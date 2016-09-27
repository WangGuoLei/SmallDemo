//
//  TextModel.h
//  WGLDemo
//
//  Created by 王国磊 on 16/1/27.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextModel : NSObject

@property (nonatomic, assign)int textId;
@property (nonatomic, copy)NSString *textName;
@property (nonatomic, copy)NSString *textContent;

// 判断是否展开
@property (nonatomic, assign)BOOL isShowMoreText;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
