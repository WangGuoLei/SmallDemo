//
//  SecondaryNav.m
//  WGLDemo
//
//  Created by 无线动力 on 16/5/4.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "SecondaryNav.h"
#import "DTScrollStatusView.h"

@interface SecondaryNav ()<DTScrollStatusDelegate>

@property (nonatomic, strong) DTScrollStatusView *scrollTapViw;

@end

@implementation SecondaryNav

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollTapViw = [[DTScrollStatusView alloc]initWithTitleArr:@[@"工作",@"任务",@"目标"] andType:ScrollTapTypeWithNavigation];
    _scrollTapViw.scrollStatusDelegate = self;
    
    [self.view addSubview:_scrollTapViw];
}

#pragma mark -- delegate

- (void)refreshViewWithTag:(int)tag andIsHeader:(BOOL)isHeader {
    
    if(isHeader) {
        if(tag == 1) {
            UITableView *table = _scrollTapViw.tableArr[tag -1];
            [table reloadData];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    if (tableView.tag == 1) {
        cell.textLabel.text = @"工作";
    } else if (tableView.tag == 2) {
        cell.textLabel.text = @"任务";
    } else {
        cell.textLabel.text = @"目标";
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView.tag == 1) {
        return 1;
    }
    return 2;
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
