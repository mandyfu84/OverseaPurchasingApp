//
//  GeneralData.h
//  OverseaPurchasing
//
//  Created by 高穎 on 2016/6/11.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface singletonObject :NSObject {
    @public
    NSString *account;
    float price;
    NSString *ownermail;
}


+(singletonObject*)sharedSingletonObject;


-(void)showcount;
-(void)addcount;
-(void) showowner;
-(void) showprice;
@end