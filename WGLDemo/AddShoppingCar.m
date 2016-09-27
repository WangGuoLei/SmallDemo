//
//  AddShoppingCar.m
//  WGLDemo
//
//  Created by 无线动力 on 16/5/10.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "AddShoppingCar.h"

@interface AddShoppingCar ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation AddShoppingCar
{
    CGPoint center;
    NSArray *sizeArray;
    NSArray *colorArray;
    NSDictionary *stockDict;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareData];
    [self createUI];
}

- (void)prepareData {

    sizeArray = @[@"S", @"M", @"L"];
    colorArray = @[@"蓝色", @"红色", @"卡其色", @"紫金色"];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"stock" ofType:@"plist"];
    stockDict = [[NSDictionary alloc]initWithContentsOfURL:[NSURL fileURLWithPath:path]];
}

- (void)createUI {

    _bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    _bgView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_bgView];
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
