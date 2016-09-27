//
//  PellTableViewSelect.m
//  WGLDemo
//
//  Created by 无线动力 on 16/4/28.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "PellTableViewSelect.h"

@interface  PellTableViewSelect()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, retain) NSArray *selectData;
@property (nonatomic, copy) void(^action)(NSInteger index);
@property (nonatomic, retain) NSArray * imagesData;

@end

PellTableViewSelect *backgroundView;
UITableView *tableView;

@implementation PellTableViewSelect

- (instancetype)init {
    
    if (self = [super init]) {
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

+ (void)addPellTableViewSelectWithFrame:(CGRect)frame SelectData:(NSArray *)selectData Images:(NSArray *)images Action:(void (^)(NSInteger))action Animated:(BOOL)animate
{
    if (backgroundView != nil) {
        
        [PellTableViewSelect hiden];
    }
    
    UIWindow *win = [[[UIApplication sharedApplication] windows] firstObject];
    
    backgroundView = [[PellTableViewSelect alloc] initWithFrame:win.bounds];
    backgroundView.action = action;
    backgroundView.imagesData = images ;
    backgroundView.selectData = selectData;
    backgroundView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.1];
    [win addSubview:backgroundView];
    
    //tableView
    tableView = [[UITableView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-80, 70.0-20.0*selectData.count, frame.size.width, 40*selectData.count) style:0];
    tableView.dataSource = backgroundView;
    tableView.delegate = backgroundView;
    tableView.layer.cornerRadius = 10.0f;
    
    //定点
    tableView.layer.anchorPoint = CGPointMake(1.0, 0);
    tableView.transform =CGAffineTransformMakeScale(0.0001, 0.0001);
    tableView.rowHeight = 40;
    [win addSubview:tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackgroundClick)];
    [backgroundView addGestureRecognizer:tap];
    backgroundView.action = action;
    backgroundView.selectData = selectData;
    
    if (animate == YES) {
        backgroundView.alpha = 0;

        [UIView animateWithDuration:0.3 animations:^{
            backgroundView.alpha = 0.5;
            tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
}

+ (void)hiden
{
    if (backgroundView != nil) {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            tableView.transform = CGAffineTransformMakeScale(0.000001, 0.0001);
            
        } completion:^(BOOL finished) {
            
            [backgroundView removeFromSuperview];
            [tableView removeFromSuperview];
            tableView = nil;
            backgroundView = nil;
        }];
    }
}

+ (void)tapBackgroundClick
{
    [PellTableViewSelect hiden];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selectData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"PellTableViewSelectIdentifier";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:Identifier];
    }
    cell.imageView.image = [UIImage imageNamed:self.imagesData[indexPath.row]];
    cell.textLabel.text = _selectData[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.action) {
        self.action(indexPath.row);
    }
    [PellTableViewSelect hiden];
}

#pragma mark 绘制三角形

- (void)drawRect:(CGRect)rect
{
    // 设置背景色
    [[UIColor whiteColor] set];
    
    //拿到当前视图准备好的画板
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    CGContextBeginPath(context); //标记
    CGFloat location = [UIScreen mainScreen].bounds.size.width;
    
    CGContextMoveToPoint(context, location-10-10, 70); //设置起点
    CGContextAddLineToPoint(context, location-2*10-10, 60);
    CGContextAddLineToPoint(context, location-10*3-10, 70);
    
    CGContextClosePath(context); //路径结束标志，不写默认封闭
    [[UIColor whiteColor] setFill];  //设置填充色
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径path
}


@end
