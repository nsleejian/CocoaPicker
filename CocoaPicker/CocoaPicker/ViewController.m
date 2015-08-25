//
//  ViewController.m
//  CocoaPicker
//
//  Created by Cocoa Lee on 15/8/25.
//  Copyright (c) 2015年 Cocoa Lee. All rights reserved.
//

#import "ViewController.h"
#import "CocoaPickerViewController.h"
@interface ViewController ()<CocoaPickerViewControllerDelegate>
@property(nonatomic,strong)UIButton *button;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imageView =[[ UIImageView  alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    
    UIButton *button = [UIButton new];
    button.bounds = CGRectMake(0, 0, 90, 90);
    button.center = CGPointMake(self.view.bounds.size.width/2.0, 400);
    [button setTitle:@"click" forState:normal];
    [button setTitleColor:[UIColor redColor] forState:normal];
    button.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    _button = button;
    
}

- (void)present:(id)sender {
    self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;//半透明全靠这句了
    CocoaPickerViewController *transparentView = [[CocoaPickerViewController alloc] init];
    transparentView.delegate = self;
    transparentView.modalPresentationStyle = UIModalPresentationOverFullScreen;
    transparentView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    transparentView.view.frame=self.view.frame;
    transparentView.view.backgroundColor=[[UIColor whiteColor] colorWithAlphaComponent:.3];
    transparentView.view.superview.backgroundColor = [UIColor clearColor];
    [self presentViewController:transparentView animated:YES completion:nil];
}


- (void)CocoaPickerViewSendBackWithImage:(UIImage *)image andString:(NSString *)str{
  NSLog(@"收到 :%@",str);
    [_button setBackgroundImage:image forState:normal];
    _button.bounds = CGRectMake(0, 0, 200, image.size.height / (image.size.width /200));
    [_button setTitle:@"" forState:normal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
