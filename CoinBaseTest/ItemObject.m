//
//  ItemObject.m
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/4.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import "ItemObject.h"
#import "Items.h"

@implementation ItemObject

-(id)init
{
    self = [self initWithData:nil andImage:nil];
    return self;
}
-(id)initWithData:(NSDictionary *)data  andImage:(UIImage *) image
{
    self = [super init];
    self.name = data[ITEM_TITLE];
    self.price = [data[ITEM_PRICE] floatValue];
    self.catagory = data[ITEM_CATEGORY];
    self.country = data[ITEM_COUNTRY];
    self.detail = data[ITEM_DETAIL];
    self.ownermail=data[ITEM_EMAIL];
    self.image = image;
   
    return self;
}

@end
