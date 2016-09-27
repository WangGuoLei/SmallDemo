//
//  Ridehorselight.m
//  WGLDemo
//
//  Created by 无线动力 on 16/4/26.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "Ridehorselight.h"

@interface Ridehorselight ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, weak) UIView *viewAnima;
@property (nonatomic, weak) UILabel *customLabel;

@end

@implementation Ridehorselight

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addClildView];
    [self setTimer];
}

- (void)addClildView {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat viewX = (self.view.frame.size.width-200)/2;
    UIView *viewAnima = [[UIView alloc] initWithFrame:CGRectMake(viewX, 100, 200, 40)];
    viewAnima.backgroundColor = [UIColor  yellowColor];
    self.viewAnima = viewAnima;
    self.viewAnima.clipsToBounds = YES;
    
    CGFloat customLabelY = (self.viewAnima.frame.size.height-30)/2;
    UILabel *customLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.viewAnima.frame.size.width, customLabelY, 200, 30)];
    customLabel.text = @"跑马灯效果，滚动文本！";
    customLabel.textColor = [UIColor redColor];
    self.customLabel = customLabel;
    
    [self.view addSubview:viewAnima];
    [viewAnima addSubview:customLabel];
}

- (void)setTimer {

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(changePos) userInfo:nil repeats:YES];
}

- (void)changePos {
    
    CGPoint cenPos = self.customLabel.center;
    if (cenPos.x < -100) {
        
        CGFloat distance = self.customLabel.frame.size.width/2;
        self.customLabel.center = CGPointMake(self.viewAnima.frame.size.width+distance, 20);
    } else {
        self.customLabel.center = CGPointMake(cenPos.x-5, 20);
    }
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
