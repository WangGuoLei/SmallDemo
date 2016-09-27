//
//  PelletView.m
//  WGLDemo
//
//  Created by 无线动力 on 16/4/28.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "PelletView.h"
#import "PellTableViewSelect.h"

@interface PelletView ()

@end

@implementation PelletView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(buttonClick)];
    self.navigationItem.rightBarButtonItem = rightBar;
}

- (void)buttonClick {
    
    [PellTableViewSelect addPellTableViewSelectWithFrame:CGRectMake(0, 0, 150, 200) SelectData:@[@"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱"] Images:@[@"saoyisao.png",@"jiahaoyou.png",@"taolun.png",@"diannao.png",@"diannao.png",@"shouqian.png"] Action:nil Animated:YES];
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
