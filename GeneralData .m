//
//  GeneralData.m
//  OverseaPurchasing
//
//  Created by 高穎 on 2016/6/11.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GeneralData .h"

@implementation singletonObject

static singletonObject *_singletonObject =nil;

-(id)init{
    self =[super init];
    if(self)
    {
        account=@"";
        ownermail=@"";
        price=0;
    }
    return self;
}
+(singletonObject *)sharedSingletonObject{
    @synchronized([singletonObject class]){
        if(!_singletonObject)
            [[self alloc] init];
        return _singletonObject;
    }
    return nil;
}
+(id)alloc{
    @synchronized ([singletonObject class]) {
        _singletonObject=[super alloc];
        return _singletonObject;
    }
    
}

-(void) showcount{
    NSLog(@"%@",account);
}
-(void) showowner{
    NSLog(@"%@",ownermail);
}
-(void) showprice{
    NSLog(@"%f",price);
}-(void)addcount{
    account=@"jf";
}
-(void)dealloc{
    [super dealloc];
}
@end