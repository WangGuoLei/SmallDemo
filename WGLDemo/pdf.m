//
//  pdf.m
//  WGLDemo
//
//  Created by 无线动力 on 16/4/21.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "pdf.h"
#import "PDFViewController.h"

@interface pdf ()<PDFViewControllerDelegate>

@property(nonatomic,assign) NSInteger lookPage;

@end

@implementation pdf

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.lookPage = 1;
    UIButton *pdfBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 100, 100, 50)];
    [pdfBtn setTitle:@"阅读pdf" forState:UIControlStateNormal];
    [pdfBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pdfBtn addTarget:self action:@selector(readPdf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:pdfBtn];
}

-(void)readPdf {
    
    PDFViewController *pdfVC = [[PDFViewController alloc] initWithPDFName:@"OpenCV.pdf" andLastPage:self.lookPage];
    pdfVC.pdfViewControllerDelegate = self;
    [self.navigationController pushViewController:pdfVC animated:YES];
}

-(void)closePDFViewWithCurrentPage:(NSInteger)currentPage {
    
    self.lookPage = currentPage;
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
