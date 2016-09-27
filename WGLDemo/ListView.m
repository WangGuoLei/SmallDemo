//
//  ListView.m
//  WGLDemo
//
//  Created by 无线动力 on 16/5/6.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "ListView.h"
#import "ListLabel.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ListView ()
{
    NSArray *strArray;
}

@end

@implementation ListView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    strArray = @[@"二恶烷", @"饿的身份多福多寿", @"请问企鹅群", @"请问去", @"饿的签", @"请问饿", @"111", @"2222", @"333", @"444444", @"232332", @"55555", @"但是分身乏术", @"多福多寿", @"值得一交的朋友", @"的分身乏术", @"二恶烷", @"饿的身份多福多寿", @"请问企鹅群", @"请问去", @"饿的签", @"请问饿", @"长春市说", @"短发短发", @"333", @"444444", @"寿", @"232332", @"55555", @"333", @"444444", @"232332", @"55555", @"333", @"444444", @"232332", @"55555"];
    
    ListLabel *listLabel = [[ListLabel alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 0)];
    listLabel.signalTagColor = [UIColor blackColor];
    [listLabel setTagWithTagArray:strArray];
    
    [self.view addSubview:listLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
