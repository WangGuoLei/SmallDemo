//
//  ViewController.m
//  WGLDemo
//
//  Created by 王国磊 on 16/1/26.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)NSMutableArray *titles;
@property (nonatomic, strong)NSMutableArray *classNames;

@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ViewController

- (NSMutableArray *)titles {
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray *)classNames {
    if (!_classNames) {
        _classNames = [NSMutableArray array];
    }
    return _classNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"WGLDemo";
    
    [self createUI];
    [self addCell];
}

- (void)createUI {
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

/**
 *  添加Cell
 */
- (void)addCell:(NSString *)title class:(NSString *)className {
    [self.titles addObject:title];
    [self.classNames addObject:className];
}

- (void)addCell {
    [self addCell:@"TableView联动" class:@"Two_TableViews"];
    [self addCell:@"TableView非联动" class:@"TableView_Two"];
    [self addCell:@"TableView展开与收起" class:@"OpenAndClose"];
    [self addCell:@"上传头像(调用相机、相册、预览)" class:@"UploadImage"];
    [self addCell:@"筛选(下拉菜单)" class:@"DropdownMenu"];
    [self addCell:@"pdf阅读" class:@"pdf"];
    [self addCell:@"多选、全选、插入、删除" class:@"TableView"];
    [self addCell:@"跑马灯" class:@"Ridehorselight"];
    [self addCell:@"TableView-HeaderView" class:@"TableHeaderView"];
    [self addCell:@"仿QQ弹出视图" class:@"PelletView"];
    [self addCell:@"瀑布流" class:@"WaterFall"];
    [self addCell:@"动画瀑布流" class:@"AnimateWaterFall"];
    [self addCell:@"二级导航栏" class:@"SecondaryNav"];
    [self addCell:@"聊天界面气泡" class:@"BubbleDemo"];
    [self addCell:@"自定义流式标签" class:@"ListView"];
    [self addCell:@"滚动导航条" class:@"ScrollViewController"];
    [self addCell:@"加入购物车" class:@"AddShoppingCar"];
    [self addCell:@"字符串画线动画" class:@"AnimationLine"];
    [self addCell:@"标签效果" class:@"SphereView"];
    [self addCell:@"collectionView分组排序" class:@"CollectionViewSort"];
    [self addCell:@"selectView" class:@"selectVC"];
    
    [self.tableView reloadData];
}

/**
 *  TableView代理方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _titles[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = _classNames[indexPath.row];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *vc = [[class alloc]init];
        vc.title = _titles[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
