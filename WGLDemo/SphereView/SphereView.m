//
//  SphereView.m
//  WGLDemo
//
//  Created by 无线动力 on 16/6/7.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "SphereView.h"
#import "XLSphereView.h"

@interface SphereView ()

@property (nonatomic, strong) XLSphereView *sphereView;

@end

@implementation SphereView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor blackColor];
    
    CGFloat sphereViewW = self.view.frame.size.width - 40;
    _sphereView = [[XLSphereView alloc]initWithFrame:CGRectMake(20, 120, sphereViewW, sphereViewW)];
    
    NSMutableArray *mutableArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (NSInteger i=0; i<40; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(0, 0, 60, 30);
        [btn setTitle:[NSString stringWithFormat:@"%ld",i] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255 green:arc4random_uniform(255)/255 blue:arc4random_uniform(255)/255 alpha:1];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:24];
        btn.layer.cornerRadius = 3;
        btn.clipsToBounds = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_sphereView addSubview:btn];
        
        [mutableArr addObject:btn];
    }
    [_sphereView setItems:mutableArr];
    [self.view addSubview:_sphereView];
}

- (void)btnClick:(UIButton *)btn {

    [_sphereView timerStop];
    
    [UIView animateWithDuration:0.3 animations:^{
        btn.transform = CGAffineTransformMakeScale(2, 2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            btn.transform = CGAffineTransformMakeScale(1., 1.);
        } completion:^(BOOL finished) {
            [_sphereView timerStart];
        }];
    }];
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
