//
//  CocoaHederView.h
//  CocoaPicker
//
//  Created by Cocoa Lee on 15/8/25.
//  Copyright (c) 2015年 Cocoa Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^sendImage)(UIImage *iamge);
@interface CocoaHederView : UIView
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)NSMutableArray *newimageArray;
@property(nonatomic,strong)sendImage  sendImageBlock;
@end
