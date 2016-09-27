//
//  TableView.m
//  WGLDemo
//
//  Created by 无线动力 on 16/4/21.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "TableView.h"

@interface TableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
@property (nonatomic, strong)NSMutableArray *selectArray;

@property (nonatomic, assign)BOOL isAll;

@end

@implementation TableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
    
    _isAll = NO;
    
    self.selectArray = [@[] mutableCopy];
    self.dataSourceArray = [@[] mutableCopy];
    for (int i = 0; i < 20; i++) {
        NSString *string = [NSString stringWithFormat:@"jack-%d", i];
        [_dataSourceArray addObject:string];
    }
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"全选" style:UIBarButtonItemStylePlain target:self action:@selector(allSelect)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(changeAction)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"插入" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(insertAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)changeAction {
    
    [self.tableView setEditing:YES animated:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(completeAction)];
}

- (void)completeAction {

    if (_selectArray.count != 0) {
        for (int i = 0; i < _selectArray.count; i++) {
            [_dataSourceArray removeObjectsInArray:_selectArray];
            [self.tableView reloadData];
        }
        
        [_selectArray removeAllObjects];
    }
    
    [self.tableView setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(changeAction)];
}

- (void)allSelect {
    
    _isAll = YES;
    [self.tableView setEditing:YES animated:YES];
    if (_isAll) {
        if (_selectArray.count != 0) {
            [_selectArray removeAllObjects];
            [_selectArray addObjectsFromArray:_dataSourceArray];
        }else{
            [_selectArray addObjectsFromArray:_dataSourceArray];
        }
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(completeAction)];
    
    for (int i = 0; i < _dataSourceArray.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
}

- (void)insertAction {
    
    NSString *insertString = @"dscdsc";
    [_dataSourceArray addObject:insertString];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_dataSourceArray.count-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_Id = @"row";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_Id];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_Id];
    }
    cell.textLabel.text = _dataSourceArray[indexPath.row];
    cell.detailTextLabel.text = @"close";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!_isAll) {
        [self.selectArray addObject:_dataSourceArray[indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.selectArray removeObject:_dataSourceArray[indexPath.row]];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_dataSourceArray removeObject:_dataSourceArray[indexPath.row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
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
