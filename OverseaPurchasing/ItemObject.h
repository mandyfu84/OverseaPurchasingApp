//
//  ItemObject.h
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/4.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ItemObject : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) float price;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *catagory;
@property (strong, nonatomic) NSString *detail;
@property (strong, nonatomic) NSString *ownermail;

@property (strong, nonatomic) UIImage *image;


-(id)initWithData:(NSDictionary *)data andImage:(UIImage *) image;

@end
