//
//  TextModel.m
//  WGLDemo
//
//  Created by 王国磊 on 16/1/27.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "TextModel.h"

@implementation TextModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        self.isShowMoreText = NO;
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

@end
