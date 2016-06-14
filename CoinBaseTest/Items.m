//
//  Items.m
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/4.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "Items.h"

@implementation Items

+(NSArray *) allItems
{
    NSMutableArray *itemImformation = [@[] mutableCopy];
    
    NSDictionary *item1Dic = @{ITEM_TITLE : @"Item1", ITEM_CATEGORY : @"Item Category1" ,ITEM_PRICE : @0.00000001, ITEM_COUNTRY : @"Item County1", ITEM_DETAIL : @"Item Detail1"};
    [itemImformation addObject:item1Dic];

    NSDictionary *item2Dic = @{ITEM_TITLE : @"Item2", ITEM_CATEGORY : @"Item Category2" ,ITEM_PRICE : @0.00000002, ITEM_COUNTRY : @"Item County1", ITEM_DETAIL : @"Item Detail1"};
    [itemImformation addObject:item2Dic];
    
    NSDictionary *item3Dic = @{ITEM_TITLE : @"Item3", ITEM_CATEGORY : @"Item Category1" ,ITEM_PRICE : @0.00000003, ITEM_COUNTRY : @"Item County1", ITEM_DETAIL : @"Item Detail1"};
    [itemImformation addObject:item3Dic];
    
    return [itemImformation copy];
}

@end
