//
//  PDFViewController.h
//  pdfModel
//
//  Created by paykee on 15/12/17.
//  Copyright © 2015年 jpy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDFView.h"
@protocol PDFViewControllerDelegate<NSObject>

-(void)closePDFViewWithCurrentPage:(NSInteger)currentPage;

@end

@interface PDFViewController : UIViewController

@property(nonatomic,weak) id<PDFViewControllerDelegate> pdfViewControllerDelegate;

@property (strong, nonatomic) PDFView *curView;  // 当前PDF页面视图

@property (strong, nonatomic) PDFView *addView;  // 新的PDF页面视图

@property (strong, nonatomic) PDFView *backView; // 用于制造翻页效果的视图

@property (strong, nonatomic) UIScrollView *scrollView; // 滚动视图，用于显示完整的PDF页面

@property (retain, nonatomic) CAGradientLayer *shadow;  // 用于制造阴影效果的Layer

@property (retain, nonatomic) CAGradientLayer *margin;  // 用于制造页边效果的Layer



-(id)initWithPDFName:(NSString *)name andLastPage:(NSInteger)lastPage; // 通过PDF文件名初始化

@end
