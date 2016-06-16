//
//  Items.m
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/4.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MongoLabSDK.h"
#include "Items.h"


@implementation Items

//TODO - Enter database name - you can have multiple databases being used
#define MY_DATABASE @"tpiti_wallet"
#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

+(NSArray *) allItems
{
    NSMutableArray *itemImformation = [@[] mutableCopy];
    /*
    NSDictionary *item1Dic = @{ITEM_TITLE : @"Item1", ITEM_CATEGORY : @"Item Category1" ,ITEM_PRICE : @0.00000001, ITEM_COUNTRY : @"Item County1", ITEM_DETAIL : @"Item Detail1"};
    [itemImformation addObject:item1Dic];

    NSDictionary *item2Dic = @{ITEM_TITLE : @"Item2", ITEM_CATEGORY : @"Item Category2" ,ITEM_PRICE : @0.00000002, ITEM_COUNTRY : @"Item County1", ITEM_DETAIL : @"Item Detail1"};
    [itemImformation addObject:item2Dic];
    
    NSDictionary *item3Dic = @{ITEM_TITLE : @"Item3", ITEM_CATEGORY : @"Item Category1" ,ITEM_PRICE : @0.00000003, ITEM_COUNTRY : @"Item County1", ITEM_DETAIL : @"Item Detail1"};
    [itemImformation addObject:item3Dic];
    */
    NSString *MY_COLLECTION = @"Product"; // indicate which collection to send
    
    NSString *sort = @"{\"_id\":-1}";
    NSArray *resultList = [[MongoLabSDK sharedInstance] getCollectionItemList:MY_DATABASE collectionName:MY_COLLECTION query:nil  sortOrder:sort limit:0];
    
    /*
    "_id": 2,
    "name": "20",
    "category": "20",
    "seller_mail": "40347905S@gmail.com",
    "img_url": "http://www.csie.ntnu.edu.tw/~40347905s/uploads/2.jpg",
    "detail": "20",
    "location": "20",
    "price": 20
    */
     for (int i=0 ; i<[resultList count] ; i++) {
         NSString *title = [[resultList objectAtIndex:i]objectForKey:@"name"];
         NSString *category = [[resultList objectAtIndex:i]objectForKey:@"category"];
         NSNumber *price = [[resultList objectAtIndex:i]objectForKey:@"price"];
         NSString *location = [[resultList objectAtIndex:i]objectForKey:@"location"];
         NSString *detail = [[resultList objectAtIndex:i]objectForKey:@"detail"];
         NSString *imgurl = [[resultList objectAtIndex:i]objectForKey:@"img_url"];
         NSString *email = [[resultList objectAtIndex:i]objectForKey:@"seller_mail"];
         NSDictionary *itemDic = @{
                                   ITEM_TITLE : title,
                                   ITEM_CATEGORY : category ,
                                   ITEM_PRICE : price,
                                   ITEM_COUNTRY : location,
                                   ITEM_DETAIL : detail,
                                   ITEM_IMGURL : imgurl,
                                   ITEM_EMAIL : email
                                   };
         [itemImformation addObject:itemDic];
     }
    
    /*for(int i=0;i<5;i++){
        NSDictionary *itemDic = @{ITEM_TITLE : @"Item1", ITEM_CATEGORY : @"Item Category1" ,ITEM_PRICE : @100, ITEM_COUNTRY : @"Item County1", ITEM_DETAIL : @"Item Detail1"};
        [itemImformation addObject:itemDic];
    }*/
    
    return [itemImformation copy];
}

@end
