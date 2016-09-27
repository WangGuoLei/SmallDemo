//
//  TableHeaderView.m
//  WGLDemo
//
//  Created by 无线动力 on 16/4/27.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "TableHeaderView.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface TableHeaderView ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation TableHeaderView
{
    UIImageView *headerImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

- (void)createUI {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.contentInset = UIEdgeInsetsMake(200, 0, 0, 0);
    self.tableView = tableView;
    
    headerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, -200, SCREEN_WIDTH, 200)];
    headerImage.image = [UIImage imageNamed:@"girl.jpg"];
    headerImage.contentMode = UIViewContentModeScaleAspectFill;
    headerImage.clipsToBounds = YES;
    
    [self.view addSubview:self.tableView];
    [self.tableView addSubview:headerImage];
}

#pragma mark - TableView代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

#pragma mark - ScrollView代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.tableView) {
        
        CGFloat offset_y = scrollView.contentOffset.y;
        
        CGRect frame = headerImage.frame;
        frame.origin.y = offset_y;
        frame.size.height = -offset_y;
        headerImage.frame = frame;
        
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
