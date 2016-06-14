//
//  UserObject.h
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/7.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserObject : NSObject

@property (strong, nonatomic) NSString *_id;
@property (strong, nonatomic) NSString *mail;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *address;
@property (nonatomic) float money;

@end