//
//  CocoaGroup.m
//  CocoaPicker
//
//  Created by Cocoa Lee on 15/8/26.
//  Copyright (c) 2015年 Cocoa Lee. All rights reserved.
//

#import "CocoaGroup.h"

@implementation CocoaGroup
static CocoaGroup* _CocoaShareInstance= nil;

@synthesize imageArray = _imageArray;

+(instancetype) CocoaShareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _CocoaShareInstance = [[self alloc] init] ;
    }) ;
    
    return _CocoaShareInstance ;
}
@end
