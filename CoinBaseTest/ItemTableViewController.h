//
//  ItemTableViewController.h
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/4.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemTableViewController : UITableViewController

@property (strong, atomic) NSMutableArray *items;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end
