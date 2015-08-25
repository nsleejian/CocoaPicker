//
//  CocoaHederView.m
//  CocoaPicker
//
//  Created by Cocoa Lee on 15/8/25.
//  Copyright (c) 2015年 Cocoa Lee. All rights reserved.
//

#import "CocoaHederView.h"
#import <AssetsLibrary/AssetsLibrary.h>



@implementation CocoaHederView


- (id)init{
    self = [super init];
    if (self) {
        [self initHeaderView];
    }
    return self;
}


- (void)initHeaderView{
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 190);

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 190)];
    [self addSubview:scrollView];
    _scrollView = scrollView;
//    1 获得所有相册
    ALAssetsLibrary *assetsLibrary;
    assetsLibrary = [[ALAssetsLibrary alloc] init];
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {

        if (group == nil) {
            return ;
        }
        
        NSString *name = [NSString stringWithFormat:@"%@",[group valueForProperty:ALAssetsGroupPropertyName]];
        NSLog(@"name : %@",name);
        if ([name isEqualToString:@"我的照片流"]) {
            [self getImageWith:group];
        }
        
    } failureBlock:^(NSError *error) {
        
        NSLog(@"Group not found!\n");
        
    }];
    
 
    
}


- (void)getImageWith:(ALAssetsGroup*)assetsGroup{
    
    NSMutableArray *imageArray = [NSMutableArray array];
        [assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
            if (result) {
                UIImage *image=[UIImage imageWithCGImage: result.aspectRatioThumbnail];
                [imageArray addObject:image];
            }
        }];
    
    
//    颠倒数组  循环遍历   用临时数组替换
    NSMutableArray *newArray = [NSMutableArray array];
    for (UIImage * image in [imageArray reverseObjectEnumerator]) {
        [newArray addObject:image];
    }
    
    _newimageArray = newArray;
    
    
    
    
    
    for (int i = 0;i < imageArray.count ;i++) {
        
        UIImage *image = newArray[i];
        UIButton *imageView = [UIButton new];
        [imageView setImage:image forState:normal];
        imageView.tag = i;
        [imageView addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        imageView.layer.borderWidth = 2;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        
        //   先计算出宽度  然后调整 scrollView 宽度 然后添加到 scrollVIiew上
        //   0 根据高度计算宽度
        float imageView_W = image.size.width/(image.size.height/_scrollView.bounds.size.height);
        //              调整 scrollView contentSize
        imageView.frame = CGRectMake(_scrollView.contentSize.width, 0, imageView_W, _scrollView.bounds.size.height);
        
        _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width + imageView_W, _scrollView.contentSize.height);
        
        [_scrollView addSubview:imageView];
        
        
        
        
    }
    
  
    
}



- (void)imageClick:(UIButton*)btn
{
    NSLog(@"Tap : %ld",btn.tag);
    UIImage *image = _newimageArray[btn.tag];
    _sendImageBlock(image);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
