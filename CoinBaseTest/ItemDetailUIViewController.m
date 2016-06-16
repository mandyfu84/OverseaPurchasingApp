//
//  ItemDetailUIViewController.m
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/4.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import "ItemDetailUIViewController.h"

#import "ViewController.h"
#import <coinbase-official/CoinbaseOAuth.h>
#import <coinbase-official/CoinbaseUser.h>
#import <coinbase-official/CoinbaseAccount.h>
#import "GeneralData .h"
@interface ItemDetailUIViewController()

@end


@implementation ItemDetailUIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.itemImage.image = self.itemObject.image;
    self.itemNameLabel.text = self.itemObject.name;
    
    self.selleremailField.text = [singletonObject sharedSingletonObject]->ownermail;
    self.priceField.text = [NSString stringWithFormat:@"%f", [singletonObject sharedSingletonObject]->price];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Price";
            cell.detailTextLabel.text = [NSNumber numberWithFloat: self.itemObject.price].stringValue;
            [singletonObject sharedSingletonObject]->price=self.itemObject.price;            break;
        case 1: 
            cell.textLabel.text = @"Catagory";
            cell.detailTextLabel.text = [self.itemObject.catagory stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            break;
        case 2:
            cell.textLabel.text = @"Location";
            cell.detailTextLabel.text = [self.itemObject.country stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            break;
        case 3:
            cell.textLabel.text = @"Detail";
            cell.detailTextLabel.text = [self.itemObject.detail stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            break;
        case 4:
            cell.textLabel.text = @"Ownermail";
            cell.detailTextLabel.text = self.itemObject.ownermail;
            
            
        default:
            break;
    }
[singletonObject sharedSingletonObject]->ownermail=self.itemObject.ownermail;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

//
//  ViewController.m
//  CoinBaseTest
//
//  Created by John Hsu on 2016/4/23.
//  Copyright © 2016年 test. All rights reserved.
//


/**
 *  viewDidAppear
 *
 *  畫面剛出現時，判斷是否登入過，如果未登入就開啟登入網頁
 */
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]) {
        self.accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"];
        self.client = [Coinbase coinbaseWithOAuthAccessToken:self.accessToken];
        self.client.baseURL = SandboxAPIURL;
    }
    else {
        [self reAuthorize];
        ///[self goAuthorize];
    }
}

-(void)reAuthorize
{
    // meta為限制透過app每天只能最多轉帳給別人1000美金的比特幣
    [CoinbaseOAuth setBaseURL:SandboxOAuthURL];
    [CoinbaseOAuth startOAuthAuthenticationWithClientId:kCoinbaseDemoClientID
                                                  scope:@"balance transactions user send"
                                            redirectUri:@"com.test.coinbasesandboxtest://coinbase-oauth"
     //@"com.OverseaPurchasing://coinbase-oauth"
     //@"com.test.coinbasesandboxtest://coinbase-oauth"
                                                   meta:@{
                                                          @"send_limit_amount": @"1000",
                                                          @"send_limit_currency" : @"USD",
                                                          @"send_limit_period" : @"day"
                                                          }];
}

/**
 *  authenticationComplete
 *
 *  給OAuth完成使用，認證完成用URL開啟APP時，會從AppDelegate呼叫過來這裡
 */
- (void)authenticationComplete:(NSDictionary *)response
{
    // Tokens successfully received!
    self.accessToken = [response objectForKey:@"access_token"];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.accessToken forKey:@"access_token"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *refreshToken = [response objectForKey:@"refresh_token"];
    // NSNumber *expiresIn = [response objectForKey:@"expires_in"];
    // In your app, you will probably want to save these three values at this point.
    self.refreshToken = refreshToken;
    
    // Now that we are authenticated, load some data
    self.client = [Coinbase coinbaseWithOAuthAccessToken:self.accessToken];
    self.client.baseURL = SandboxAPIURL;
}

-(IBAction)currentUserAction:(id)sender
{
    
    [self.client getCurrentUser:^(CoinbaseUser *user, NSError *error) {
        if ([error.userInfo[@"statusCode"] intValue] == 401) {
            ///[self reAuthorize];
            [self reAuthorize];
        }
        if (error) {
            NSLog(@"Could not load user: %@", error);
        } else {
            NSLog(@"Signed in as: %@", user.email);
            currentUser = user;
        }
    }];
    
}

/**
 *  getPrice
 *
 *  取得比特幣對美金匯率
 */
-(IBAction)getPrice:(id)sender
{
    [self.client getBuyPrice:^(CoinbaseBalance *btc, NSArray *fees, CoinbaseBalance *subtotal, CoinbaseBalance *total, NSError *error) {
        NSString *priceString = [NSString stringWithFormat:@"buy price: %@ %@ = %@ %@",btc.amount, btc.currency, total.amount, total.currency];
        [[[UIAlertView alloc] initWithTitle:@"price" message:priceString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }];
}

/**
 *  createOrder
 *
 *  指定對方的email與比特幣金額，轉帳指定的比特幣數量給對方
 */
-(IBAction)createOrder:(id)sender
{
    [[singletonObject sharedSingletonObject]showprice ] ;
    [[singletonObject sharedSingletonObject]showowner ] ;
    /*    if (!amountField.text.length) {
        [[[UIAlertView alloc] initWithTitle:@"send error" message:@"Please enter amount" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    if (!receiverField.text.length) {
        [[[UIAlertView alloc] initWithTitle:@"send error" message:@"Please enter receiver" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
*/
    [self.client getPrimaryAccount:^(CoinbaseAccount *acc, NSError *error) {
        if ([error.userInfo[@"statusCode"] intValue] == 401) {
            ///[self reAuthorize];
            [self reAuthorize];
            return;
        }
        acc.client = [Coinbase coinbaseWithOAuthAccessToken:self.accessToken];
        acc.client.baseURL = SandboxAPIURL;
        
        NSLog(@"client:%@",acc.client);
        NSLog(@"url:%@",SandboxAPIURL);
        
        //        [acc getBalance:^(CoinbaseBalance *bal, NSError *error) {
        //            NSLog(@"error:%@",err);
        //            NSLog(@"bal:%@",bal);
        //
        //        }];
        //[singletonObject sharedSingletonObject]->price
        //[[NSNumber numberWithFloat:myFloat] stringValue]
        [acc sendAmount:[[NSNumber numberWithFloat:[singletonObject sharedSingletonObject]->price] stringValue] to:[singletonObject sharedSingletonObject]->ownermail completion:^(CoinbaseTransaction *transaction, NSError *sendError) {
            NSLog(@"error:%@",sendError);
            NSLog(@"transaction:%@",transaction);
            NSLog(@"receiverField's text = %@",[singletonObject sharedSingletonObject]->ownermail);
            self.selleremailField.text = [singletonObject sharedSingletonObject]->ownermail;
            self.priceField.text = [NSString stringWithFormat:@"%e", [singletonObject sharedSingletonObject]->price];
            NSLog(@"item price: %@",[NSString stringWithFormat:@"%e", [singletonObject sharedSingletonObject]->price]);
            if (sendError) {
                NSString *errorString = [sendError description];
                [[[UIAlertView alloc] initWithTitle:@"send error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            }
        }];
    }];
    
}


@end
