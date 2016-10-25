//
//  ViewController.m
//  DrawingBoard
//
//  Created by ZhouYong on 16/10/25.
//  Copyright © 2016年 Rephontil/Yong Zhou. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet DrawView *drawView;


@end


@implementation ViewController

- (IBAction)clear:(UIBarButtonItem *)sender {
    [_drawView clean];
    
}

- (IBAction)unDo:(UIBarButtonItem *)sender {
    [self.drawView unDo];
}
- (IBAction)eraser:(UIBarButtonItem *)sender {
    [self.drawView eraser];
}
- (IBAction)photo:(UIBarButtonItem *)sender {
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    pickerVC.delegate = self;
    [self presentViewController:pickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    NSLog(@"%@",info);
    self.drawView.image = info[UIImagePickerControllerOriginalImage];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)savePhono:(UIBarButtonItem *)sender {
//    开启上下文
    UIGraphicsBeginImageContextWithOptions(_drawView.bounds.size, NO, 0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [_drawView.layer renderInContext:ctx];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    UIGraphicsEndImageContext();
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
}

- (IBAction)changeLineColour:(UIButton *)sender {
    self.drawView.pathColour = sender.backgroundColor;
    self.drawView.lineWidth = 2;
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
