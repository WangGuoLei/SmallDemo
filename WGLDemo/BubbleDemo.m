//
//  BubbleDemo.m
//  WGLDemo
//
//  Created by 无线动力 on 16/5/6.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "BubbleDemo.h"
#import "ChatModel.h"
#import "ChatCell.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface BubbleDemo ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    UIView *_chatView;
    UITextField *_textField;
}

@end

@implementation BubbleDemo

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    
    [self createView];
    [self createButton];
    [self notificationKeyboard];
}

- (void)createView {

    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _chatView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40)];
    _chatView.backgroundColor = [UIColor grayColor];
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(10, 5, SCREEN_WIDTH-60, 30)];
    _textField.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.view addSubview:_tableView];
    [self.view addSubview:_chatView];
    [_chatView addSubview:_textField];
}

- (void)createButton {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(SCREEN_WIDTH-40, 5, 30, 30);
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendText) forControlEvents:UIControlEventTouchUpInside];
    
    [_chatView addSubview:button];
}

- (void)notificationKeyboard {

    //监听键盘出现
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //监听键盘消失
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatModel *chatModel = _dataArray[indexPath.row];
    
    //计算文本所占大小
    CGSize size = [chatModel.content boundingRectWithSize:CGSizeMake(250, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size;
    
    return size.height+25;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ChatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell) {
        cell = [[ChatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ChatModel* chatModel = _dataArray[indexPath.row];
    
    //计算文本所占大小
    CGSize size = [chatModel.content boundingRectWithSize:CGSizeMake(250, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil].size;

    if (chatModel.isSelf) {
        //自己发的
        cell.rightBubble.hidden = NO;
        cell.leftBubble.hidden = YES;
        //显示文本
        cell.rightLabel.text = chatModel.content;
        //重新计算label和气泡的大小
        cell.rightLabel.frame = CGRectMake(10, 5, size.width, size.height);
        cell.rightBubble.frame = CGRectMake(SCREEN_WIDTH-30-size.width, 5, size.width+20, size.height+20);
    } else {
        //接收到的
        cell.rightBubble.hidden = YES;
        cell.leftBubble.hidden = NO;
        //显示文本
        cell.leftLabel.text = chatModel.content;
        //重新计算label和气泡的大小
        cell.leftLabel.frame = CGRectMake(15, 5, size.width, size.height);
        cell.leftBubble.frame = CGRectMake(10, 5, size.width+20, size.height+20);
    }
    
    return cell;
}

//发送文本
- (void)sendText {
    
    ChatModel *chatModel = [[ChatModel alloc]init];
    chatModel.content = _textField.text;
    chatModel.isSelf = YES;
    _textField.text = @"";
    [_dataArray addObject:chatModel];
    
    //添加一行
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0];
    [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    //滚动到最后一行
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoSpeak) userInfo:nil repeats:NO];
}

- (void)autoSpeak {
    
    NSArray* array = @[@"好的", @"没问题", @"一边去", @"忙呢!", @"去死~"];
    
    ChatModel* chatModel = [[ChatModel alloc] init];
    chatModel.content = array[arc4random()%array.count];
    chatModel.isSelf = NO;
    [_dataArray addObject:chatModel];
    
    //添加一行
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:_dataArray.count-1 inSection:0];
    [_tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    //滚动到最后一行
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

//键盘出现
- (void)keyboardWillShow:(NSNotification*)noti {
    
    //键盘的高度
    CGSize size = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    //tableView的大小
    _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40-size.height);
    
    //chatView的位置
    _chatView.frame = CGRectMake(0, SCREEN_HEIGHT-40-size.height, SCREEN_WIDTH, 40);
}

//键盘消失
- (void)keyboardWillHide:(NSNotification*)noti {
    
    //tableView的大小恢复
    _tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-40);
    
    //chatView的位置恢复
    _chatView.frame = CGRectMake(0, SCREEN_HEIGHT-40, SCREEN_WIDTH, 40);
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
