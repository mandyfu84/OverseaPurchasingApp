//
//  ItemDetailUIViewController.h
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/4.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemObject.h"
#import <coinbase-official/Coinbase.h>
@interface ItemDetailUIViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    CoinbaseUser *currentUser;
    
    IBOutlet UITextField *amountField;
    IBOutlet UITextField *receiverField;
    
}
@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *itemImage;
@property (strong, nonatomic) IBOutlet ItemObject *itemObject;
@property (strong, nonatomic) IBOutlet UITableView *tabelView;

#define receiverAccount @"40347905S@gmail.com"
#define itemprice @"0.00000001"

// John's account
#define kCoinbaseDemoClientID @"e27225ec83d04ae824534ca72b8837efdf3a07ca4ec3be907c3b52d2e07fba13"
#define kCoinbaseDemoClientSecret @"1dc3fdf8fa17113e0fd207f3e5e973bc4ccf31035c7f5e2fae2b1f0a7740a902"

/*
 //My account
 #define kCoinbaseDemoClientID @"744262c75b329d21185ed1efb9656adbe94bcee61327c928f73986b19c4aaa69"
 #define kCoinbaseDemoClientSecret @"64a280d7540913cafa074c0dca5b681a4ffbc66c14d5c5b749b3a4ab0e56f8df"
 */
#define SandboxOAuthURL [NSURL URLWithString:@"https://sandbox.coinbase.com/"]
#define SandboxAPIURL [NSURL URLWithString:@"https://api.sandbox.coinbase.com/"]


- (void)authenticationComplete:(NSDictionary *)response;
@property (strong, atomic) NSMutableArray *items;

@property (nonatomic, strong) NSString *accessToken;
@property (strong) NSString *refreshToken;
@property (nonatomic, retain) Coinbase *client;

@property (retain, nonatomic) IBOutlet UILabel *selleremailField;
@property (retain, nonatomic) IBOutlet UILabel *priceField;

@end

