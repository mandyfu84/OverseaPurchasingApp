//
//  AddItemTableViewController.h
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/11.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddItemTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITextField *ItemName;
@property (strong, nonatomic) IBOutlet UITextField *ItemPrice;
@property (strong, nonatomic) IBOutlet UITextField *ItemCategory;
@property (strong, nonatomic) IBOutlet UITextField *ItemLocation;
@property (strong, nonatomic) IBOutlet UITextField *ItemDetail;
@property (retain, nonatomic) IBOutlet UIImageView *image;
- (IBAction)takePhoto:(UIButton *)sender;

- (IBAction)Upload:(UIButton *)sender;

@end
