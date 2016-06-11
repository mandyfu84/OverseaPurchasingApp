//
//  Items.h
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/4.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ITEM_TITLE @"Item Name"
#define ITEM_CATEGORY @"Item Category"
#define ITEM_PRICE @"Item Price"
#define ITEM_COUNTRY @"Item County"
#define ITEM_DETAIL @"Item Detail"

@interface Items : NSObject

+(NSArray *) allItems;

@end


