//
//  PDFViewController.m
//  pdfModel
//
//  Created by paykee on 15/12/17.
//  Copyright © 2015年 jpy. All rights reserved.
//

#import "PDFViewController.h"

@interface PDFViewController () {
    BOOL next_;     // 是否翻向下一页
    BOOL enlarged_; // pdf视图是否被放大
    NSUInteger currentPage_; // 当前页号
    NSUInteger totalPages_;  // 总页数
    CGFloat startX_;    // 翻页手势起点的x值
    CGFloat curoffset_; // 翻页手势的位移值
    CGFloat minoffset_; // 翻页手势有效的最小位移值
    CGRect pdfRect_; // 完整的PDF页面的框架矩形
    CGRect fitRect_; // 适配后的PDF页面的框架矩形
    CGPDFDocumentRef pdfRef_;  // pdf文件
    CGPDFPageRef     pdfPage_; // pdf页面
}

@property (strong, nonatomic) UITapGestureRecognizer *doubleTap_; // 双击手势，用于查看完整的PDF页面

@property (strong, nonatomic) UIView *viewForPDF; // self.view中用于放置pdf阅读视图的子视图

@property (nonatomic, assign) NSInteger lastPage;

@end

@implementation PDFViewController

#pragma mark -
#pragma mark Initialize

/* 通过PDF文件名初始化 */
-(id)initWithPDFName:(NSString *)name andLastPage:(NSInteger)lastPage {
    
    self = [super init];
    if (self) {
        /* 根据pdf文件路径初始化pdf阅读视图 */
        NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name]; // 获取PDF文件名的完整路径
//        NSLog(@"filePath = %@", filePath); // 例如：filePath = /Users/one/Library/Application Support/iPhone Simulator/7.0/Applications/5815AD09-13F2-4C77-9CAE-ADD399E85A5E/PDFReader_i7_Demo.app/CGPDFDocument.pdf
        pdfRef_ = [self createPDFFromExistFile:filePath]; // 创建pdf文件对象
        pdfPage_ = CGPDFDocumentGetPage(pdfRef_, 1); // 创建pdf首页页面
        currentPage_ = lastPage; // 页号，从1开始
        self.lastPage = lastPage;
    }
    return self;
}

/* 根据文件路径创建pdf文件 */
- (CGPDFDocumentRef)createPDFFromExistFile:(NSString *)aFilePath {
    
    CFStringRef path;
    CFURLRef url;
    CGPDFDocumentRef document;
    
    path = CFStringCreateWithCString(NULL, [aFilePath UTF8String], kCFStringEncodingUTF8);
    url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, NO);
    CFRelease(path);
    
    document = CGPDFDocumentCreateWithURL(url);
    CFRelease(url);
    totalPages_ = CGPDFDocumentGetNumberOfPages(document); // 设置PDF文件总页数
    if (totalPages_ == 0) { // 创建出错处理
        NSLog(@"Create Error");
        return NULL;
    }
    return document;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backToLast)];
    
    /* 初始化参数 */
    minoffset_ = self.view.frame.size.width / 5.;
    enlarged_ = NO; // 初始的PDF视图的放大状态为NO
    
    /* 初始化视图 */
    self.navigationItem.title = [NSString stringWithFormat:@"%lu / %lu", (unsigned long)currentPage_, (unsigned long)totalPages_];
    self.curView  = [[PDFView alloc] initWithPDFRef:pdfRef_ andLastPage:self.lastPage];
    self.addView  = [[PDFView alloc] initWithPDFRef:pdfRef_ andLastPage:self.lastPage];
    self.backView = [[PDFView alloc] initWithPDFRef:pdfRef_ andLastPage:self.lastPage];
    self.backView.pageIndex = 0;
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.viewForPDF = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height )];
    
    
    /* 设置PDF阅读视图的页面布局 */
    CGFloat w = self.curView.frame.size.width;
    CGFloat h = self.curView.frame.size.height;
    pdfRect_  = self.curView.frame;
    CGFloat scale = h / w; // PDF原视图高度和宽度的比例
//    NSLog(@"w = %f", w);
//    NSLog(@"h = %f", h);
    CGFloat href = self.view.frame.size.width * scale; // 经过页面适配后的高度
    CGFloat yref = (self.view.frame.size.height - 60.0 - href) / 2.; // 经过页面适配后的原点y值
//    NSLog(@"href = %f", href);
//    NSLog(@"yref = %f", yref);
    self.curView.frame = CGRectMake(0., yref, self.view.frame.size.width, href); // 设置适配后PDF视图的位置和大小
    fitRect_ = self.curView.frame; // 保存适配后的框架矩形
    [self.view addSubview:self.viewForPDF];
    [self.viewForPDF addSubview:self.curView]; // 添加页面适配后的PDF视图
    
    
    /* 为视图添加双击手势 */
    self.doubleTap_ = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(enlargePDFPage:)];
    self.doubleTap_.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:self.doubleTap_];
}

/* 双击手势的响应方法 */
-(void)enlargePDFPage:(id)sender {
    
    if (enlarged_ == NO) { // 如果PDF页面未被放大
        [self.curView removeFromSuperview];     //首先移除当前PDF页面
        [self.view addSubview:self.scrollView]; // 在self.view中添加scrollView
        [self.scrollView addSubview:self.curView];   // 在scrollView上重新添加curView
        self.curView.frame = pdfRect_; // 设置curView的框架为原始PDF视图的框架
        self.scrollView.contentSize = pdfRect_.size; // 设置scrollView的内容尺寸
        enlarged_ = YES; // 设置放大状态
        self.navigationController.navigationBarHidden = YES; // 隐藏导航条
        
    } else { // 如果PDF页面已经被放大
        [self.scrollView removeFromSuperview]; // 移除scrollView和curView
        [self.viewForPDF addSubview:self.curView]; // 在viewForPDF子视图重新添加curView
        self.curView.frame = fitRect_;
        enlarged_ = NO; // 取消放大状态
        self.navigationController.navigationBarHidden = NO; // 显示导航条
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //记录手势起点的x值
    UITouch *touch = [touches anyObject];
    startX_ = [touch locationInView:self.view].x;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //将视图中已经存在的渐变或页边阴影去掉
    if (self.shadow) {
        [self.shadow removeFromSuperlayer];
    }
    if (self.margin) {
        [self.margin removeFromSuperlayer];
    }
    
    //获取当前手势触点的x值
    UITouch *touch = [touches anyObject];
    float x = [touch locationInView:self.view].x;
    if (x - startX_ >= 0) {
        curoffset_ = x - startX_;
    }
    else {
        curoffset_ = startX_ - x;
    }
    
    // 设定翻转页面的矩形范围
    CGRect rect = self.view.bounds;
    if (x >= 160) {
        rect.size.width = (320 / x - 1) * 160;
        rect.origin.x   = x - rect.size.width;
    }
    else {
        rect.size.width = 320 - x;
        rect.origin.x = x - rect.size.width;
    }
    int tempX = rect.origin.x; //保存翻转页面起点的x值
    self.backView.frame = rect;
    
    //rect用于设定翻页时左边页面的范围
    rect = self.view.bounds;
    rect.size.width = x;
    
    // 判断手势并设定页面，制造翻页效果
    if (x - startX_ > 0) { //向右划的手势，上一页
        next_ = NO;
        if (currentPage_ == 1) {
            return; // 如果是第一页则不接受手势
        }
        else {
            self.addView.frame = rect;
            self.addView.clipsToBounds = YES;
            self.addView.pageIndex = currentPage_ - 1;
            [self.addView reloadView];
            
            [self.viewForPDF insertSubview:self.addView aboveSubview:self.curView];
            
            [self.viewForPDF insertSubview:self.backView aboveSubview:self.addView];
        }
    }
    else { //向左划的手势，下一页
        next_ = YES;
        
        if (currentPage_ == totalPages_) {
            return; // 如果到达最后一页则不接受手势
        }
        else {
            self.curView.frame = rect;
            self.addView.pageIndex = currentPage_ + 1;
            self.addView.frame = fitRect_;
            [self.addView reloadView];
            
            [self.viewForPDF insertSubview:self.addView belowSubview:self.curView];
            
            [self.viewForPDF insertSubview:self.backView aboveSubview:self.curView];
        }
    }
    
    //设定翻页时backPage视图两边的渐变阴影效果
    self.shadow = [[CAGradientLayer alloc] init];
    self.shadow.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor,
                         (id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2].CGColor,
                         (id)[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor,
                         nil];
    rect = self.view.bounds;
    rect.size.width = 50;
    rect.origin.x = x - 25;
    self.shadow.frame = rect;
    self.shadow.startPoint = CGPointMake(0.0, 0.5);
    self.shadow.endPoint = CGPointMake(1.0, 0.5);
    [self.view.layer addSublayer:self.shadow];
    
    self.margin = [[CAGradientLayer alloc] init];
    self.margin.colors = [NSArray arrayWithObjects:
                         (id)[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.2].CGColor,
                         (id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.3].CGColor,
                         nil];
    self.margin.frame = CGRectMake(tempX - 35, 0, 50, self.view.bounds.size.height);
    self.margin.startPoint = CGPointMake(0.0, 0.5);
    self.margin.endPoint = CGPointMake(1.0, 0.5);
    [self.view.layer addSublayer:self.margin];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 如果是第一页并且翻向上一页
    if (currentPage_ == 1) {
        if (next_ == NO) {
            return;
        }
    }
    // 如果是最后一页并且翻向下一页
    if (currentPage_ == totalPages_) {
        if (next_ == YES) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"注意" message:@"已经到达最后一页" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [av show];
            return;
        }
    }
    if (curoffset_ < minoffset_) {
        self.curView.frame = fitRect_;
        self.curView.pageIndex = currentPage_ ;
        [self.curView reloadView];
        
        [self.addView  removeFromSuperview];
        [self.backView removeFromSuperview];
        
        //移除阴影效果
        [self.shadow removeFromSuperlayer];
        [self.margin removeFromSuperlayer];
        return;
    }
    
    if (next_ == YES) { // 下一页
        currentPage_++;
//        NSLog(@"%lu / %lu", (unsigned long)currentPage_, (unsigned long)totalPages_);
        self.curView.frame = fitRect_;
        self.curView.pageIndex = currentPage_;
        [self.curView reloadView];
        
        self.navigationItem.title = [NSString stringWithFormat:@"%lu / %lu", (unsigned long)currentPage_, (unsigned long)totalPages_];
    }
    else { // 上一页
        currentPage_--;
//        NSLog(@"%lu / %lu", (unsigned long)currentPage_, (unsigned long)totalPages_);
        self.curView.frame = fitRect_;
        self.curView.pageIndex = currentPage_;
        [self.curView reloadView];
        
        self.navigationItem.title = [NSString stringWithFormat:@"%lu / %lu", (unsigned long)currentPage_, (unsigned long)totalPages_];
    }
    
    [self.addView  removeFromSuperview];
    [self.backView removeFromSuperview];
    
    //移除阴影效果
    [self.shadow removeFromSuperlayer];
    [self.margin removeFromSuperlayer];
}

-(void)backToLast {
    
    if([self.pdfViewControllerDelegate respondsToSelector:@selector(closePDFViewWithCurrentPage:)]){
        [self.pdfViewControllerDelegate closePDFViewWithCurrentPage:currentPage_];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
