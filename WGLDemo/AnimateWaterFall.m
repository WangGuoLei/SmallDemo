//
//  AnimateWaterFall.m
//  WGLDemo
//
//  Created by 无线动力 on 16/4/29.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "AnimateWaterFall.h"
#import "Photos.h"

#define IMAGEWIDTH 120
#define IMAGEHEIGHT 160

@interface AnimateWaterFall ()

@property (nonatomic, strong) NSMutableArray *photos;

@end

@implementation AnimateWaterFall

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (NSMutableArray *)photos {

    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    NSMutableArray *photoPaths = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle]bundlePath];
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *fileName in fileNames ) {
        if ([fileName hasSuffix:@"jpg"] || [fileName hasSuffix:@"JPG"]) {
            NSString *photoPath = [path stringByAppendingPathComponent:fileName];
            [photoPaths addObject:photoPath];
        }
    }
    
    //添加9个图片到界面中
    if (photoPaths) {
        for (int i = 0; i < 12; i++) {
            float X = arc4random()%((int)self.view.bounds.size.width - IMAGEWIDTH);
            float Y = arc4random()%((int)self.view.bounds.size.height - IMAGEHEIGHT);
            float W = IMAGEWIDTH;
            float H = IMAGEHEIGHT;
            
            Photos *photo = [[Photos alloc]initWithFrame:CGRectMake(X, Y, W, H)];
            [photo updateImage:[UIImage imageWithContentsOfFile:photoPaths[i]]];
            [self.view addSubview:photo];
            
            float alpha = i*1.0/10 + 0.2;
            [photo setImageAlphaAndSpeedAndSize:alpha];
            [self.photos addObject:photo];
        }
    }
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap)];
    [doubleTap setNumberOfTapsRequired:2];
    [self.view addGestureRecognizer:doubleTap];
}

- (void)doubleTap {
    
    for (Photos *photo in self.photos) {
        if (photo.state == PhotoStateDraw || photo.state == PhotoStateBig) {
            return;
        }
    }
    
    float W = self.view.bounds.size.width / 3;
    float H = self.view.bounds.size.height / 3;
    
    [UIView animateWithDuration:1 animations:^{
        for (int i = 0; i < self.photos.count; i++) {
            Photos *photo = [self.photos objectAtIndex:i];
            
            if (photo.state == PhotoStateNormal) {
                photo.oldAlpha = photo.alpha;
                photo.oldFrame = photo.frame;
                photo.oldSpeed = photo.speed;
                photo.alpha = 1;
                photo.frame = CGRectMake(i%3*W, i/3*H, W, H);
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.speed = 0;
                photo.state = PhotoStateTogether;
                
            } else if (photo.state == PhotoStateTogether) {
                photo.alpha = photo.oldAlpha;
                photo.frame = photo.oldFrame;
                photo.speed = photo.oldSpeed;
                photo.imageView.frame = photo.bounds;
                photo.drawView.frame = photo.bounds;
                photo.state = PhotoStateNormal;
            }
        }
    }];
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
