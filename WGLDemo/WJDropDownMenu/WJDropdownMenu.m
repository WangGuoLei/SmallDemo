//
//  WJDropdownMenu.m
//  WJDropDownMenu
//
//  Created by 无线动力 on 16/1/23.
//  Copyright © 2016年 Wireless. All rights reserved.
//

#import "WJDropdownMenu.h"
#import <UIKit/UIKit.h>

#define cell_h   40
#define window_h [UIScreen mainScreen].bounds.size.height
#define carverAnimationDefalutTime 0.15
#define menuTitleDefalutFont  [UIFont systemFontOfSize:12]
#define TableTitleDefalutFont [UIFont systemFontOfSize:10]

@interface WJDropdownMenu ()

@property (nonatomic,strong) UIView       *backView;
@property (nonatomic,strong) UITableView    *tableFirst;
@property (nonatomic,strong) UITableView    *tableSecond;
@property (nonatomic,strong) UITableView    *tableThird;

@property (nonatomic,strong) NSMutableArray *bgLayers;
@property (nonatomic,strong) NSMutableArray *dataSourceFirst;
@property (nonatomic,strong) NSMutableArray *dataSourceSecond;
@property (nonatomic,strong) NSMutableArray *dataSourceThird;

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSMutableArray *allData;
@property (nonatomic,strong) NSMutableArray *allDataSource;

@property (nonatomic,assign) BOOL           firstTableViewShow;
@property (nonatomic,assign) BOOL           secondTableViewShow;
@property (nonatomic,assign) BOOL           thirdTableViewShow;

@property (nonatomic,assign) NSInteger      lastSelectedIndex;
@property (nonatomic,assign) NSInteger      lastSelectedCellIndex;
@property (nonatomic,assign) NSInteger      lastSecondCellIndex;
@property (nonatomic,assign) NSInteger      i;
@property (nonatomic,assign) NSInteger      j;

@property (nonatomic,assign) CGFloat        tableViewWith;
@property (nonatomic,assign) CGFloat        menuBaseHeight;

@end

@implementation WJDropdownMenu

- (void)createOneMenuTitleArray:(NSArray *)menuTitleArray FirstArray:(NSArray *)FirstArray {
    
    self.menuBaseHeight = self.frame.size.height;
    [self createMenuViewWithData:menuTitleArray];
    [self.allDataSource addObject:FirstArray];
    
    [self createTableViewFirst];
    [self createTableViewSecond];
}

- (void)createTwoMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr {
    
    self.menuBaseHeight = self.frame.size.height;
    [self createMenuViewWithData:menuTitleArray];
    [self.allDataSource addObject:firstArr];
    [self.allDataSource addObject:secondArr];
    
    [self createTableViewFirst];
    [self createTableViewSecond];
}

- (void)createThreeMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr threeArr:(NSArray *)threeArr {
    
    self.menuBaseHeight = self.frame.size.height;
    [self createMenuViewWithData:menuTitleArray];
    [self.allDataSource addObject:firstArr];
    [self.allDataSource addObject:secondArr];
    [self.allDataSource addObject:threeArr];
    
    [self createTableViewFirst];
    [self createTableViewSecond];
    [self createTableViewThird];
}

- (void)createFourMenuTitleArray:(NSArray *)menuTitleArray FirstArr:(NSArray *)firstArr SecondArr:(NSArray *)secondArr threeArr:(NSArray *)threeArr fourArr:(NSArray *)fourArr {
    
    self.menuBaseHeight = self.frame.size.height;
    [self createMenuViewWithData:menuTitleArray];
    [self.allDataSource addObject:firstArr];
    [self.allDataSource addObject:secondArr];
    [self.allDataSource addObject:threeArr];
    [self.allDataSource addObject:fourArr];
    
    [self createTableViewFirst];
    [self createTableViewSecond];
}

- (void)changeMenuDataWithIndex:(NSInteger)index {
    
    [self createWithFirstData:self.allDataSource[index][0]];
    if ([self.allDataSource[index] count] ==1) {
        self.tableViewWith = self.frame.size.width;
        self.allData = nil;
    } else if ([self.allDataSource[index] count] == 2){
        self.tableViewWith = self.frame.size.width/2;
        [self createWithSecondData:self.allDataSource[index][1]];
    } else if ([self.allDataSource[index] count] == 3){
        self.tableViewWith = self.frame.size.width/3;
        [self createWithSecondData:self.allDataSource[index][1]];
        [self createWithThirdData:self.allDataSource[index][2]];
    }
}

- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point {
    
    CAShapeLayer *layer = [CAShapeLayer new];
    UIBezierPath *path = [UIBezierPath new];
    
    if (self.menuArrowStyle == menuArrowStyleSolid) {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(8, 0)];
        [path addLineToPoint:CGPointMake(4, 5)];
    } else {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(5, 5)];
        [path moveToPoint:CGPointMake(5, 5)];
        [path addLineToPoint:CGPointMake(10, 0)];
    }
    
    [path closePath];
    layer.path = path.CGPath;
    
    layer.lineWidth = 0.8;
    if (self.menuArrowStyle == menuArrowStyleSolid) {
        layer.fillColor = [UIColor colorWithRed:0xcc/255.0 green:0xcc/255.0 blue:0xcc/255.0 alpha:0xcc/255.0].CGColor;
    } else {
        layer.strokeColor = [UIColor colorWithRed:0xcc/255.0 green:0xcc/255.0 blue:0xcc/255.0 alpha:0xcc/255.0].CGColor;
        layer.fillColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:255/255.0].CGColor;
    }
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    CGPathRelease(bound);
    layer.position = point;
    return layer;
}

- (CALayer *)createBgLayerWithColor:(UIColor *)color andPosition:(CGPoint)position {
    
    CALayer *layer = [CALayer layer];
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, 20, 20);
    layer.backgroundColor = color.CGColor;
    return layer;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([touch.view isKindOfClass:[UIButton class]] || [NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"] ) {
        return NO;
    }
    return YES;
}

- (void)remover {
    
    CALayer *layer = self.bgLayers[self.lastSelectedIndex-100];
    layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
    
    self.firstTableViewShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    self.secondTableViewShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableSecond.frame = CGRectMake(self.tableViewWith,CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    self.thirdTableViewShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableThird.frame = CGRectMake(self.tableViewWith * 2,CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    
    [self hideCarverView];
}

- (void)createMenuViewWithData:(NSArray *)data {
    
    self.cellHeight = self.cellHeight ? self.cellHeight : cell_h;
    self.lastSelectedIndex = -1;
    self.backgroundColor = self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.2];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.menuBaseHeight);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(remover)];
    [self addGestureRecognizer:tap];
    tap.delegate = self;
    
    self.bgLayers = [[NSMutableArray alloc]init];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width
        , self.menuBaseHeight)];
    self.backView.userInteractionEnabled = YES;
    self.backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.backView];
    
    NSInteger num = data.count;
    CGFloat btnW = (self.frame.size.width-num+1)/num;
    for (int i = 0; i < num; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((btnW+1)*i, 0, btnW, self.menuBaseHeight)];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = 100+i;
        btn.titleLabel.font = self.menuTitleFont ? [UIFont systemFontOfSize:self.menuTitleFont] : menuTitleDefalutFont;
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:data[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showFirstTableView:) forControlEvents:UIControlEventTouchUpInside];
        CGPoint bgLayerPoint = CGPointMake(self.frame.size.width/num-10, self.menuBaseHeight/2);
        CALayer *bgLayer = [self createBgLayerWithColor:[UIColor clearColor] andPosition:bgLayerPoint];
        CGPoint indicatorPoint = CGPointMake(10, 10);
        CAShapeLayer *indicator = [self createIndicatorWithColor:[UIColor lightGrayColor] andPosition:indicatorPoint];
        [bgLayer addSublayer:indicator];
        [self.bgLayers addObject:bgLayer];
        [btn.layer addSublayer:bgLayer];
        [self.backView addSubview:btn];
    }
    
    for (int i = 0; i < num; i++) {
        UILabel *lineLb = [[UILabel alloc]initWithFrame:CGRectMake((btnW+1)*i+btnW, self.menuBaseHeight/10, 1, self.menuBaseHeight/10*8)];
        lineLb.backgroundColor = [UIColor lightGrayColor];
        if (i == num - 1) {
            lineLb.hidden = YES;
        }
        [self.backView addSubview:lineLb];
    }
    
    UILabel *VlineLbTop = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.backView.frame.size.width, 1)];
    VlineLbTop.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *VlineLbBom = [[UILabel alloc]initWithFrame:CGRectMake(0, self.menuBaseHeight, self.backView.frame.size.width, 1)];
    VlineLbBom.backgroundColor = [UIColor lightGrayColor];
    
    [self.backView addSubview:VlineLbTop];
    [self.backView addSubview:VlineLbBom];
}

- (void)showFirstAndSecondTableView:(NSInteger)index {
    
    [self changeMenuDataWithIndex:index-100];
    
    if (self.firstTableViewShow == NO) {
        
        self.firstTableViewShow = YES;
        
        [self showCarverView];
        
        
        CALayer *layer = self.bgLayers[index-100];
        layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
        self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, self.cellHeight*self.dataSourceFirst.count);
        }];
        
    } else {
        
        CALayer *layer = self.bgLayers[index-100];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        self.firstTableViewShow = NO;
        self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, self.cellHeight*self.dataSourceFirst.count);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        }];
        self.secondTableViewShow = NO;
        [UIView animateWithDuration:0.2 animations:^{
            
            self.tableSecond.frame = CGRectMake(self.tableViewWith, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
            self.tableThird.frame = CGRectMake(self.tableViewWith * 2, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        }];
        
        [self hideCarverView];
        
    }
    self.lastSelectedIndex = index;
}

- (void)showCarverView {
    
    if (!self.caverAnimationTime) {
        self.caverAnimationTime = carverAnimationDefalutTime;
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width
                            , window_h-self.frame.origin.y);
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.backgroundColor = self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }];
}

- (void)hideCarverView{
    
    if (!self.caverAnimationTime) {
        self.caverAnimationTime = carverAnimationDefalutTime;
    }
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.menuBaseHeight);
    [UIView animateWithDuration:self.caverAnimationTime animations:^{
        self.backgroundColor = self.CarverViewColor ? self.CarverViewColor : [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
    }];
    
}

- (void)showFirstTableView:(UIButton *)btn {
    
    self.allData = nil;
    self.data = nil;
    self.dataSourceSecond = nil;
    self.dataSourceThird = nil;
    
    if (self.lastSelectedIndex != btn.tag && self.lastSelectedIndex !=-1) {
        CALayer *layer = self.bgLayers[self.lastSelectedIndex-100];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        
        [UIView animateWithDuration:0.1 animations:^{
            
            self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
            self.tableSecond.frame = CGRectMake(self.tableViewWith, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
            self.tableThird.frame = CGRectMake(self.tableViewWith * 2, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        } completion:^(BOOL finished) {
            
            self.firstTableViewShow = NO;
            self.secondTableViewShow = NO;
            self.thirdTableViewShow = NO;
            [self showFirstAndSecondTableView:btn.tag];

        }];
        
    } else {
        [self showFirstAndSecondTableView:btn.tag];
    }
}

- (void)showSecondTabelView:(BOOL)secondTableViewShow {
    
    if (self.secondTableViewShow == YES) {
        [self showCarverView];
        [UIView animateWithDuration:0.2 animations:^{
            self.tableSecond.frame = CGRectMake(self.tableViewWith, CGRectGetMaxY(self.backView.frame), self.tableViewWith, self.cellHeight*self.dataSourceSecond.count);
        }];
    }else{
        [self showCarverView];
        self.secondTableViewShow = YES;
        self.tableSecond.frame = CGRectMake(self.tableViewWith, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableSecond.frame = CGRectMake(self.tableViewWith, CGRectGetMaxY(self.backView.frame),self.tableViewWith, self.cellHeight*self.dataSourceSecond.count);
        }];
    }
    
}

- (void)showThirdTabelView:(BOOL)thirdTableViewShow {
    
    if (self.thirdTableViewShow == YES) {
        [self showCarverView];
        [UIView animateWithDuration:0.2 animations:^{
            self.tableThird.frame = CGRectMake(CGRectGetMaxX(self.tableSecond.frame), CGRectGetMaxY(self.backView.frame), self.tableViewWith, self.cellHeight*self.dataSourceThird.count);
        }];
    } else {
        [self showCarverView];
        self.thirdTableViewShow = YES;
        self.tableThird.frame = CGRectMake(CGRectGetMaxX(self.tableSecond.frame), CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        [UIView animateWithDuration:0.2 animations:^{
            self.tableThird.frame = CGRectMake(CGRectGetMaxX(self.tableSecond.frame), CGRectGetMaxY(self.backView.frame),self.tableViewWith, self.cellHeight*self.dataSourceThird.count);
        }];
    }
}

- (void)createWithFirstData:(NSArray *)dataFirst {
    
    self.dataSourceFirst = [NSMutableArray arrayWithArray:dataFirst];
    [self.tableFirst reloadData];
}

- (void)createWithSecondData:(NSArray *)dataSecond {
    
    self.allData = [NSMutableArray arrayWithArray:dataSecond];
    [self.tableSecond reloadData];
}

- (void)createWithThirdData:(NSArray *)dataThird {
    
    self.data = [NSMutableArray arrayWithArray:dataThird];
    [self.tableThird reloadData];
}


- (void)createTableViewFirst {
    
    self.tableFirst = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backView.frame),self.frame.size.width, 0) style:UITableViewStylePlain];
    self.tableFirst.scrollEnabled = NO;
    self.tableFirst.delegate = self;
    self.tableFirst.dataSource = self;
    
    [self insertSubview:self.tableFirst belowSubview:self.backView];
}

- (void)createTableViewSecond {
    
    self.tableSecond = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.frame.size.width/2, 0) style:UITableViewStylePlain];
    self.tableSecond.scrollEnabled = NO;
    self.tableSecond.delegate = self;
    self.tableSecond.dataSource = self;
    self.tableSecond.autoresizesSubviews = NO;
    [self insertSubview:self.tableSecond belowSubview:self.backView];
}

- (void)createTableViewThird {
    
    self.tableThird = [[UITableView alloc]initWithFrame:CGRectMake(self.tableViewWith*2, CGRectGetMaxY(self.backView.frame), self.frame.size.width/3, 0) style:UITableViewStylePlain];
    self.tableThird.scrollEnabled = NO;
    self.tableThird.delegate = self;
    self.tableThird.dataSource = self;
    self.tableThird.autoresizesSubviews = NO;
    [self insertSubview:self.tableThird belowSubview:self.backView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.tableFirst) {
        return self.dataSourceFirst.count;
    } else if (tableView == self.tableSecond) {
        return self.dataSourceSecond.count;
    } else if (tableView == self.tableThird){
        return self.dataSourceThird.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.tableFirst) {
        static NSString *cellID = @"cellFirst";
        UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell1 == nil) {
            cell1 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
        }
        cell1.textLabel.text = self.dataSourceFirst[indexPath.row];
        cell1.textLabel.font = self.tableTitleFont ? [UIFont systemFontOfSize:self.tableTitleFont] : TableTitleDefalutFont;
        if (!self.allData) {
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
            cell1.accessoryType = UITableViewCellAccessoryNone;
        } else {
            cell1.selectionStyle = UITableViewCellSelectionStyleGray;
            cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        return cell1;
        
    } else if (tableView == self.tableSecond){
        static NSString *cellIde = @"cellSecond";
        
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
        }
        if (!self.data) {
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            cell2.accessoryType = UITableViewCellAccessoryNone;
        } else{
            cell2.selectionStyle = UITableViewCellSelectionStyleGray;
            cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        cell2.textLabel.text = self.dataSourceSecond[indexPath.row];
        cell2.textLabel.font = self.tableTitleFont ? [UIFont systemFontOfSize:self.tableTitleFont] : TableTitleDefalutFont;
        return cell2;
    } else if (tableView == self.tableThird){
        static NSString *cellIde = @"cellThird";
        UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellIde];
        if (cell3 == nil) {
            cell3 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIde];
        }
        cell3.textLabel.text = self.dataSourceThird[indexPath.row];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        cell3.textLabel.font = self.tableTitleFont ? [UIFont systemFontOfSize:self.tableTitleFont] : TableTitleDefalutFont;
        return cell3;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self)weakSelf = self;
    void (^complete)(void) = ^(void){
        CALayer *layer = self.bgLayers[weakSelf.lastSelectedIndex-100];
        layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
        UIButton *btn = (id)[self viewWithTag:weakSelf.lastSelectedIndex];
        weakSelf.firstTableViewShow = NO;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(weakSelf.backView.frame), self.tableViewWith, 0);
        }];
        weakSelf.secondTableViewShow = NO;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.tableSecond.frame = CGRectMake(self.tableViewWith,CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        }];
        weakSelf.thirdTableViewShow = NO;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.tableThird.frame = CGRectMake(self.tableViewWith * 2,CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
        }];
        [weakSelf hideCarverView];
        if (weakSelf.allData && !weakSelf.dataSourceThird) {
            [btn setTitle:weakSelf.dataSourceSecond[indexPath.row] forState:UIControlStateNormal];
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:andSecondIndex:)]) {
                
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-100 firstIndex:weakSelf.lastSelectedCellIndex andSecondIndex:indexPath.row];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:andSecondContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceSecond[indexPath.row]
                                  firstContent:weakSelf.dataSourceFirst[weakSelf.lastSelectedCellIndex]
                              andSecondContent:weakSelf.dataSourceSecond[indexPath.row]];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:secondIndex:thirdIndex:)]) {
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-100 firstIndex:weakSelf.lastSelectedCellIndex secondIndex:indexPath.row thirdIndex:0];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:secondContent:thirdContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceSecond[indexPath.row] firstContent:weakSelf.dataSourceFirst[weakSelf.lastSelectedCellIndex] secondContent:weakSelf.dataSourceSecond[indexPath.row] thirdContent:nil];
            }
        }
        if (!weakSelf.allData && !weakSelf.dataSourceThird) {
            [btn setTitle:weakSelf.dataSourceFirst[indexPath.row] forState:UIControlStateNormal];
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:andSecondIndex:)]) {
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-100 firstIndex:indexPath.row andSecondIndex:0];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:andSecondContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceFirst[indexPath.row] firstContent:weakSelf.dataSourceFirst[indexPath.row] andSecondContent:nil];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:secondIndex:thirdIndex:)]) {
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-100 firstIndex:indexPath.row secondIndex:0 thirdIndex:0];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:secondContent:thirdContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceFirst[indexPath.row] firstContent:weakSelf.dataSourceFirst[indexPath.row] secondContent:nil thirdContent:nil];
            }
        }
        if (weakSelf.allData && weakSelf.dataSourceThird) {
            [btn setTitle:weakSelf.dataSourceThird[indexPath.row] forState:UIControlStateNormal];
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:andSecondIndex:)]) {
                
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-100 firstIndex:weakSelf.lastSelectedCellIndex andSecondIndex:weakSelf.lastSecondCellIndex];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:andSecondContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceSecond[weakSelf.lastSecondCellIndex]
                                  firstContent:weakSelf.dataSourceFirst[weakSelf.lastSelectedCellIndex]
                              andSecondContent:weakSelf.dataSourceSecond[weakSelf.lastSecondCellIndex]];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstIndex:secondIndex:thirdIndex:)]) {
                [_delegate menuCellDidSelected:weakSelf.lastSelectedIndex-100 firstIndex:weakSelf.lastSelectedCellIndex secondIndex:self.lastSecondCellIndex thirdIndex:indexPath.row];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(menuCellDidSelected:firstContent:secondContent:thirdContent:)]) {
                [_delegate menuCellDidSelected:weakSelf.dataSourceThird[indexPath.row] firstContent:weakSelf.dataSourceFirst[weakSelf.lastSelectedCellIndex] secondContent:weakSelf.dataSourceSecond[weakSelf.lastSecondCellIndex] thirdContent:weakSelf.dataSourceThird[indexPath.row]];
            }
        }
        weakSelf.allData = nil;
        weakSelf.data = nil;
        weakSelf.dataSourceSecond = nil;
        weakSelf.dataSourceThird = nil;
    };
    
    if (tableView == self.tableFirst) {
        self.lastSelectedCellIndex = indexPath.row;
        if (self.allData) {
            _i = indexPath.row;
            self.dataSourceSecond = self.allData[_i];
            [self.tableSecond reloadData];
            [self showSecondTabelView:self.secondTableViewShow];
        } else {
            complete();
        }
    } else if (tableView == self.tableSecond) {
        if (self.data) {
            _j= indexPath.row;
            self.lastSecondCellIndex = indexPath.row;
            self.dataSourceThird = self.data[(_i)*2+(_j)];
            [self.tableThird reloadData];
            [self showThirdTabelView:self.thirdTableViewShow];
        } else {
            complete();
        }
    } else if (tableView == self.tableThird){
        complete();
    }
}

- (void)drawBackMenu {
    
    CALayer *layer = self.bgLayers[self.lastSelectedIndex-100];
    layer.transform = CATransform3DMakeRotation(M_PI*2, 0, 0, 1);
    self.firstTableViewShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableFirst.frame = CGRectMake(0, CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    self.secondTableViewShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableSecond.frame = CGRectMake(self.tableViewWith,CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    self.thirdTableViewShow = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.tableThird.frame = CGRectMake(self.tableViewWith * 2,CGRectGetMaxY(self.backView.frame), self.tableViewWith, 0);
    }];
    [self hideCarverView];
    self.allData = nil;
    self.data = nil;
    self.dataSourceSecond = nil;
    self.dataSourceThird = nil;
}

- (NSMutableArray *)allDataSource {
    
    if (_allDataSource == nil) {
        _allDataSource = [NSMutableArray array];
    }
    return _allDataSource;
}

@end
