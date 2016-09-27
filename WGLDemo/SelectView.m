//
//  SelectView.m
//  WGLDemo
//
//  Created by 无线动力 on 16/7/5.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "SelectView.h"
#import "SelectViewCell.h"
#import "SelectHeaderView.h"

@interface SelectView ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *indexArray;
}

@property (nonatomic, strong) UITableView *tableView;
@property(strong,nonatomic)SelectHeaderView *headerView;

@end

@implementation SelectView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        indexArray = [NSArray arrayWithObjects:@{@"num":@[@"问题1", @"问题2", @"问题3", @"问题4", @"问题5", @"问题6", @"问题7", @"问题8", @"请点击复合你的)"]}, nil];
        
        [self setTableView];
    }
    return self;
}

- (void)setTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 9;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"cellName";
    SelectViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[SelectViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ([[[indexArray objectAtIndex:0]objectForKey:@"num"] count]/4 + [[[indexArray objectAtIndex:0]objectForKey:@"num"] count]%4) * 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    _headerView = [[SelectHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    _headerView.nameLabel.text = [NSString stringWithFormat:@"%@:",[[[indexArray objectAtIndex:0]objectForKey:@"num"] objectAtIndex:section]];
    
    return _headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0;
}

@end
