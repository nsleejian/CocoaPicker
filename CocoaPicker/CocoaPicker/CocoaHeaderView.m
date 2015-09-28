//
//  CocoaHeaderView.m
//  CocoaPicker
//
//  Created by Cocoa Lee on 15/8/25.
//  Copyright (c) 2015年 Cocoa Lee. All rights reserved.
//

#import "CocoaHeaderView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CocoaGroup.h"

@implementation CocoaHeaderView
- (id)init{
    self = [super init];
    if (self) {
        [self getPhotoLibName];
    }
    return self;
}

- (void)initHeaderView{
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 190);

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 190)];
    [self addSubview:scrollView];
    _scrollView = scrollView;
}

- (void)getPhotoLibName {
    //    1 获得所有相册
    _sendBackArray = [NSMutableArray array];

    NSArray *imageArray = [CocoaGroup CocoaShareInstance].imageArray;
    if (imageArray > 0) {
        [self initHeaderView];
        [self addPhotoToScrollViewWithImageArray:imageArray];

    }
    else{
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            if (group == nil) {
                return ;
            }
            NSString *name = [NSString stringWithFormat:@"%@",[group valueForProperty:ALAssetsGroupPropertyName]];
            NSLog(@"name : %@",name);
            if ([name isEqualToString:@"相机胶卷"]) {
                [self getImageWith:group];
            }
        } failureBlock:^(NSError *error) {
            
            NSLog(@"Group not found!\n");
            
        }];

    }
    
    
    
    
    
}

#pragma mark －获取相册图片
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
    
    [self initHeaderView];
    
    [CocoaGroup CocoaShareInstance].imageArray = _newimageArray;
    
    [self addPhotoToScrollViewWithImageArray:newArray];
}

#pragma makr -添加图片到ScrollView
- (void)addPhotoToScrollViewWithImageArray:(NSArray *)newImageArray{
    

    for (int i = 0;i < newImageArray.count ;i++) {
        UIImage *image = newImageArray[i];
        UIButton *imageBtn = [UIButton new];
        [imageBtn setImage:image forState:normal];
        imageBtn.tag = i;
        [imageBtn addTarget:self action:@selector(imageClick:) forControlEvents:UIControlEventTouchUpInside];
        imageBtn.layer.borderWidth = 2;
        imageBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        
        //   先计算出宽度  然后调整 scrollView 宽度 然后添加到 scrollVIiew上
        //   0 根据高度计算宽度
        float imageView_W = image.size.width/(image.size.height/_scrollView.bounds.size.height);
        //   1 调整 scrollView contentSize
        imageBtn.frame = CGRectMake(_scrollView.contentSize.width, 0, imageView_W, _scrollView.bounds.size.height);
        imageBtn.selected = NO;
        _scrollView.contentSize = CGSizeMake(_scrollView.contentSize.width + imageView_W, _scrollView.contentSize.height);
        [_scrollView addSubview:imageBtn];
    }
}



#pragma mark －相册点击事件
- (void)imageClick:(UIButton*)btn
{
    btn.selected = !btn.selected;
    UIImage *image = [CocoaGroup CocoaShareInstance].imageArray[btn.tag];
   
    if (btn.selected) {
        [_sendBackArray addObject:image];
        btn.layer.borderColor = [UIColor colorWithRed:255/255.0 green:28/255.0 blue:109/255.0 alpha:1].CGColor;
    }
    else{
        btn.layer.borderColor = [UIColor whiteColor].CGColor;
        [_sendBackArray removeObject:image];
    }
    
    _sendImageBlock(_sendBackArray);
}

    
    
    
    
//    _sendImageBlock(image);
    


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end





