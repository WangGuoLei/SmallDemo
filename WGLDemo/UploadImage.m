//
//  UploadImage.m
//  WGLDemo
//
//  Created by 王国磊 on 16/2/23.
//  Copyright © 2016年 王国磊. All rights reserved.
//

#import "UploadImage.h"

#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height

@interface UploadImage () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong)UIImageView *imageView;

@end

@implementation UploadImage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
}

- (void)createUI {
    
    // 创建头像的imageView
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake((WIDTH-100)/2, (HEIGHT-100)/2, 100, 100)];
    _imageView.backgroundColor = [UIColor lightGrayColor];
    _imageView.layer.cornerRadius = 50.0;
    _imageView.clipsToBounds = YES;
    [self.view addSubview:_imageView];
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
    [_imageView addGestureRecognizer:tap];
    _imageView.userInteractionEnabled = YES;
}

// 头像单击触发事件
- (void)tapClick:(UIGestureRecognizer *)tap {
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册中选取", nil];
    } else {
        sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选取", nil];
    }
    [sheet showInView:self.view];
}

#pragma mark - 代理方法

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSUInteger sourceType = 0;
    
    // 判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                // 拍照
                sourceType = UIImagePickerControllerSourceTypeCamera;
                [self snapImage];
                break;
            case 1:
                // 相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
        }
    } else {
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        /**
         * UIImagePickerControllerSourceTypePhotoLibrary 照片库模式
         * UIImagePickerControllerSourceTypeCamera 相机模式
         * UIImagePickerControllerSourceTypeSavedPhotosAlbum 相机胶卷模式
         */
        [self localPhoto];
    }
    
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.sourceType = sourceType;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    //完成选择
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //NSLog(@"type:%@",type);
    if ([type isEqualToString:@"public.image"]) {
        //转换成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            //设置头像
            _imageView.image = image;
            //上传头像
            //[self updatePhotoFor:image];
        }];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 头像上传

- (void)snapImage {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        __block UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
        ipc.allowsEditing = YES;
        ipc.navigationBar.barTintColor =[UIColor whiteColor];
        ipc.navigationBar.tintColor = [UIColor whiteColor];
        ipc.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
        [self presentViewController:ipc animated:YES completion:^{
            ipc = nil;
        }];
    } else {
        NSLog(@"模拟器无法打开照相机");
    }
}

- (void)localPhoto {
    
    __block UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    picker.navigationBar.barTintColor = [UIColor whiteColor];
    picker.navigationBar.tintColor = [UIColor blackColor];
    picker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
    [self presentViewController:picker animated:YES completion:^{
        picker = nil;
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
