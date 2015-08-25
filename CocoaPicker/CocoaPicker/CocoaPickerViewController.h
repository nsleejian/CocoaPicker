//
//  CocoaPickerViewController.h
//  CocoaPicker
//
//  Created by Cocoa Lee on 15/8/25.
//  Copyright (c) 2015年 Cocoa Lee. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CocoaPickerViewControllerDelegate <NSObject>

//拍照 相册 返回图片  一张
-(void)CocoaPickerViewSendBackWithImage:(UIImage*)image andString :(NSString *)str;

@end


@interface CocoaPickerViewController : UIViewController

@property(assign,nonatomic)id<CocoaPickerViewControllerDelegate> delegate;

@end

