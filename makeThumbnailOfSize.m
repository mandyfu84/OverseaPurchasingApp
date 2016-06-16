//
//  makeThumbnailOfSize.m
//  CoinBaseTest
//
//  Created by Fu Juo Wen on 2016/6/16.
//  Copyright © 2016年 test. All rights reserved.
//

#import "makeThumbnailOfSize.h"

@implementation UIImage (PhoenixMaster)
- (UIImage *) makeThumbnailOfSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    // draw scaled image into thumbnail context
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newThumbnail = UIGraphicsGetImageFromCurrentImageContext();
    // pop the context
    UIGraphicsEndImageContext();
    if(newThumbnail == nil)
        NSLog(@"could not scale image");
    return newThumbnail;
}

@end