//
//  Two_TableViews.m
//  WGLDemo
//
//  Created by 王国磊 on 16/1/27.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "Two_TableViews.h"

#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface Two_TableViews () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *leftTableView;
@property (nonatomic, strong)UITableView *rightTableView;

@property (nonatomic, retain)NSArray *dataSource;

@property (nonatomic, assign)BOOL isScroll;

@end

@implementation Two_TableViews

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _isScroll = YES;
    _dataSource = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"DataSource" ofType:@"plist"]];
    
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
    
    /**
     *  市列表
     */
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(_leftTableView.frame.size.width, 64, WIDTH - _leftTableView.frame.size.width, HEIGHT) style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_rightTableView];
}

#pragma mark - TableView代理方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _leftTableView) {
        return 1;
    }
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return _dataSource.count;
    }
    return [[_dataSource[section] objectForKey:@"市"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if (tableView == _leftTableView) {
        cell.textLabel.text = [_dataSource[indexPath.row] objectForKey:@"省(直辖市、民族自治区)"];
    } else {
        cell.textLabel.text = [[_dataSource[indexPath.section] objectForKey:@"市"] objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return 0;
    }
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return 0;
    }
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _rightTableView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _rightTableView.frame.size.width, 30)];
        view.backgroundColor = [UIColor lightGrayColor];
        UILabel *label = [[UILabel alloc] initWithFrame:view.bounds];
        label.text = [_dataSource[section] objectForKey:@"省(直辖市、民族自治区)"];
        label.textAlignment = 1;
        [view addSubview:label];
        
        return view;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftTableView) {
        _isScroll = NO;
        [_leftTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        
        //滑动到对应的section
        [_rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[_dataSource[indexPath.section] objectForKey:@"省(直辖市、民族自治区)"] message:[[_dataSource[indexPath.section] objectForKey:@"市"] objectAtIndex:indexPath.row] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

#pragma mark - 联动效果

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (_isScroll) {
        if (tableView == _rightTableView) {
            /**
             *  取到屏幕上显示的的一个cell的section
             *  对应选中左边tableView的
             *  indexPathsForVisibleRows：取到当前页面上的cell的数组
             */
            NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
            [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingFooterView:(UIView *)view forSection:(NSInteger)section {
    if (_isScroll) {
        if (tableView == _rightTableView) {
            NSInteger topCellSection = [[[tableView indexPathsForVisibleRows] firstObject] section];
            [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:topCellSection inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
    
}

/**
 *  在用户结束拖动后被调用，decelerate为YES时，结束拖动后会有减速过程
 *  在didEndDragging之后，如果有减速过程，scrollview的dragging并不会立即置为NO
 *  而是要等到减速结束之后，所以这个dragging属性的实际语义更接近scrolling
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _isScroll = YES;
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
