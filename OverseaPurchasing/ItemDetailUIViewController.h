//
//  ItemDetailUIViewController.h
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/4.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemObject.h"

@interface ItemDetailUIViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *itemImage;
@property (strong, nonatomic) IBOutlet ItemObject *itemObject;
@property (strong, nonatomic) IBOutlet UITableView *tabelView;

@end
