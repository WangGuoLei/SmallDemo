//
//  PDFView.m
//  pdfModel
//
//  Created by paykee on 15/12/17.
//  Copyright © 2015年 jpy. All rights reserved.
//

#import "PDFView.h"

@implementation PDFView

/* 初始化PDFView对象 */
- (id)initWithPDFRef:(CGPDFDocumentRef)pdfr andLastPage:(NSInteger)lastPage {
    
    pdfRef = pdfr;
    pdfPage = CGPDFDocumentGetPage(pdfRef, 1); // 创建pdf首页页面
    self.pageIndex = lastPage; // 要展示的页面号，从1开始
    CGRect mediaRect = CGPDFPageGetBoxRect(pdfPage, kCGPDFTrimBox);
    self = [super initWithFrame:mediaRect];
    return self;
}

/* drawRect:方法，每个UIView的自带方法 */
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext(); // 获取当前的绘图上下文
    [[UIColor whiteColor] set];
    CGContextFillRect(context, rect);
    CGContextGetCTM(context);
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    pdfPage = CGPDFDocumentGetPage(pdfRef, self.pageIndex);
    CGRect mediaRect = CGPDFPageGetBoxRect(pdfPage, kCGPDFCropBox);
    CGContextScaleCTM(context, rect.size.width / mediaRect.size.width, rect.size.height / mediaRect.size.height);
    CGContextTranslateCTM(context, -mediaRect.origin.x, -mediaRect.origin.y);
    CGContextDrawPDFPage(context, pdfPage); // 绘制当前页面
}

/* 更新视图，例如翻页的时候需要更新 */
- (void)reloadView {
    
    [self setNeedsDisplay];
}

@end
