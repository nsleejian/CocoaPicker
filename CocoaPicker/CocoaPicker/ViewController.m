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
@property(nonatomic,strong) UIImageView *showImageView;
@property(nonatomic,strong) UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"model %@",[UIDevice currentDevice].model);
    self.view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:234/255.0];
    
    NSString *model = [UIDevice currentDevice].model;
    if ([model rangeOfString:@"Simulator"].length > 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在真机上测试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    
   
    
    
    UIImageView *imageView =[[ UIImageView  alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
    imageView.frame = self.view.bounds;
//    [self.view addSubview:imageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.bounds = CGRectMake(0, 0, 90, 90);
    button.backgroundColor = [UIColor colorWithRed:211/255.0 green:44/255.0 blue:37/255.0 alpha:1];
    button.tintColor = [UIColor whiteColor];
    button.layer.cornerRadius = 45;
    button.clipsToBounds = YES;
    button.layer.masksToBounds = NO;
    button.layer.shadowColor = [UIColor blackColor].CGColor;
    button.layer.shadowOffset = CGSizeMake(4.0f, 4.0f);
    button.layer.shadowOpacity = 0.5f;
    
    button.center = CGPointMake(self.view.bounds.size.width/2.0, CGRectGetHeight(self.view.bounds) - 100);
    [button setTitleColor:[UIColor redColor] forState:normal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(present:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(touchDownAnamation:) forControlEvents:UIControlEventTouchDown];

    
    

    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.bounds), 200)];
    _scrollView.contentSize = CGSizeMake(0, 0);
    [self.view addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.layer.shadowColor = [UIColor blackColor].CGColor;
    _scrollView.layer.shadowOffset = CGSizeMake(4.0f, 4.0f);
    _scrollView.layer.shadowOpacity = 0.5f;

    
}

#pragma mark - 弹出图片选择器
- (void)present:(UIButton*)button {
    
    button.bounds = CGRectMake(0, 0, 90, 90);
    [UIView animateWithDuration:0.25 animations:^{
        button.layer.cornerRadius = 45;

    }completion:^(BOOL finished) {
        self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;//半透明
        CocoaPickerViewController *transparentView = [[CocoaPickerViewController alloc] init];
        transparentView.delegate = self;
        transparentView.modalPresentationStyle = UIModalPresentationOverFullScreen;
        transparentView.view.frame=self.view.frame;
        transparentView.view.superview.backgroundColor = [UIColor clearColor];
        [self presentViewController:transparentView animated:YES completion:nil];
    }];
    
    

}


//你所选择的图片
#pragma mark 图片将传到这里 根据自己的需求处理
- (void)CocoaPickerViewSendBackWithImage:(NSArray *)imageArray andString:(NSString *)str{
  NSLog(@"收到 :%@",str);
    
    for (UIImage *image  in imageArray) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        float image_W = image.size.width/(image.size.height / _scrollView.bounds.size.height);
        imageView.bounds = CGRectMake(0, 0, image_W, 200);
        imageView.frame = CGRectMake(_scrollView.contentSize.width, 0, image_W, _scrollView.bounds.size.height);
        imageView.layer.borderWidth = 1;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width + image_W, _scrollView.bounds.size.height);
        [_scrollView addSubview:imageView];
        
        

    }
    
//    调整  contentOffset
        if (_scrollView.contentSize.width > self.view.bounds.size.width) {
            [UIView  animateWithDuration:0.25 animations:^{
            _scrollView.contentOffset = CGPointMake(_scrollView.contentSize.width - self.view.bounds.size.width, 0);
            }];

        }

}



- (void)touchDownAnamation:(UIButton* )button{
    button.bounds = CGRectMake(0, 0, 100, 100);
    
    [UIView animateWithDuration:0.25 animations:^{
        button.layer.cornerRadius = 50;
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
