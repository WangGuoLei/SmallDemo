//
//  TableView_Two.m
//  WGLDemo
//
//  Created by 王国磊 on 16/1/27.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "TableView_Two.h"

#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface TableView_Two () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *leftTableView;
@property (nonatomic, strong)UITableView *rightTableView;

@property (nonatomic, retain)NSArray *dataSource;
@property (nonatomic, retain)NSArray *secArr;

@end

@implementation TableView_Two

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"DataSource" ofType:@"plist"]];
    _secArr = [[NSArray alloc]initWithArray:[_dataSource[0] objectForKey:@"市"]];
    
    [self createUI];
}

#pragma mark - UI部分

- (void)createUI {
    /**
     *  省列表
     */
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH/2.5, HEIGHT) style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.tableFooterView = [[UIView alloc]init];
    _leftTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_leftTableView];
    
    NSIndexPath *firstPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_leftTableView selectRowAtIndexPath:firstPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
    /**
     *  市列表
     */
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(_leftTableView.frame.size.width, 64, WIDTH - _leftTableView.frame.size.width, HEIGHT) style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_rightTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return _dataSource.count;
    }
    return _secArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (tableView == _leftTableView) {
        cell.textLabel.text = [_dataSource[indexPath.row] objectForKey:@"省(直辖市、民族自治区)"];
    } else {
        cell.textLabel.text = _secArr[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        self.secArr = [[NSArray alloc]initWithArray:[_dataSource[indexPath.row] objectForKey:@"市"]];
        [_rightTableView reloadData];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[_dataSource[indexPath.section] objectForKey:@"省(直辖市、民族自治区)"] message:_secArr[indexPath.row] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
