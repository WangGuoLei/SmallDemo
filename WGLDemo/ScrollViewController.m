//
//  ScrollViewController.m
//  WGLDemo
//
//  Created by 无线动力 on 16/5/6.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "ScrollViewController.h"
#import "SegmentTapView.h"
#import "FlipTableView.h"

#import "ViewController1.h"
#import "ViewController2.h"
#import "ViewController3.h"
#import "ViewController4.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ScrollViewController ()<SegmentTapViewDelegate,FlipTableViewDelegate>

@property (nonatomic, strong) SegmentTapView *segment;
@property (nonatomic, strong) FlipTableView *flipView;
@property (nonatomic, strong) NSMutableArray *controllsArray;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSegment];
    [self initFlipTableView];
}

- (void)initSegment {
    
    self.segment = [[SegmentTapView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40) withDataArray:[NSArray arrayWithObjects:@"first",@"second",@"third",@"fouth", nil] withFont:15];
    self.segment.delegate = self;
    
    [self.view addSubview:self.segment];
}

- (void)initFlipTableView {
    
    if (!self.controllsArray) {
        self.controllsArray = [[NSMutableArray alloc]init];
    }
    
    ViewController1 *v1 = [[ViewController1 alloc]init];
    ViewController2 *v2 = [[ViewController2 alloc]init];
    ViewController3 *v3 = [[ViewController3 alloc]init];
    ViewController4 *v4 = [[ViewController4 alloc]init];
    
    [self.controllsArray addObject:v1];
    [self.controllsArray addObject:v2];
    [self.controllsArray addObject:v3];
    [self.controllsArray addObject:v4];
    
    self.flipView = [[FlipTableView alloc] initWithFrame:CGRectMake(0, 104, SCREEN_WIDTH, SCREEN_HEIGHT - 104) withArray:_controllsArray];
    self.flipView.delegate = self;
    
    [self.view addSubview:self.flipView];
}

#pragma mark - 代理方法

- (void)selectedIndex:(NSInteger)index {
    
    [self.flipView selectIndex:index];
}
- (void)scrollChangeToIndex:(NSInteger)index {
    
    [self.segment selectIndex:index];
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
