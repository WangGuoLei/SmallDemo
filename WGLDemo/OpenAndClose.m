//
//  OpenAndClose.m
//  WGLDemo
//
//  Created by 王国磊 on 16/1/27.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "OpenAndClose.h"
#import "TextListCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface OpenAndClose () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)UITableView *textTableView;
@property (nonatomic, retain)NSMutableArray *dataSource;

@end

@implementation OpenAndClose

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    [self createUI];
}

/**
 *  解析本地数据
 */
- (void)initData {
    NSString *jsonContent = [[NSString alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"DataText" ofType:@"json"] encoding:NSUTF8StringEncoding error:nil];
    if (jsonContent) {
        NSData *jsonData = [jsonContent dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        NSArray *textList = [dic objectForKey:@"textList"];
        for (NSDictionary *dict in textList) {
            TextModel *textModel = [[TextModel alloc]initWithDict:dict];
            if (textModel) {
                [self.dataSource addObject:textModel];
            }
        }
    }
}

/**
 *  UI部分
 */
- (void)createUI {
    _textTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    _textTableView.dataSource = self;
    _textTableView.delegate = self;
    [self.view addSubview:_textTableView];
}

#pragma mark - Tableview代理方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextModel *model = _dataSource[indexPath.row];
    
    //根据isShowMoreText属性判断cell的高度
    if (model.isShowMoreText) {
        return [TextListCell cellMoreTextHeight:model];
    }
    return [TextListCell cellDefaultHeught:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    TextListCell *cell = (TextListCell *)[tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[TextListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _dataSource[indexPath.row];
    cell.showMoreTextBlock = ^(UITableViewCell *currentCell){
        [_textTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[_textTableView indexPathForCell:currentCell], nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    
    return cell;
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
