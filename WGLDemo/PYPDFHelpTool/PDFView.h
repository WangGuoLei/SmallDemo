//
//  PDFView.h
//  pdfModel
//
//  Created by paykee on 15/12/17.
//  Copyright © 2015年 jpy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFView : UIView{
    CGPDFDocumentRef pdfRef; // pdf文件
    CGPDFPageRef pdfPage;    // pdf页面
}
@property (assign, nonatomic) NSUInteger pageIndex; // 页面号

- (id)initWithPDFRef:(CGPDFDocumentRef)pdfr andLastPage:(NSInteger)lastPage;

- (void)reloadView;

@end
