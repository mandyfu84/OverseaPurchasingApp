//
//  LogIn.m
//  OverseaPurchasing
//
//  Created by Timmy on 2016/6/11.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import "ViewController.h"
#import "MongoLabSDK/MongoLabSDK.h"
#import <coinbase-official/CoinbaseOAuth.h>
#import <coinbase-official/CoinbaseUser.h>
#import <coinbase-official/CoinbaseAccount.h>
@interface ViewController ()

@end

@implementation ViewController
//TODO - Enter database name - you can have multiple databases being used
#define MY_DATABASE @"tpiti_wallet"

#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]
- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 *  viewDidAppear
 *
 *  畫面剛出現時，判斷是否登入過，如果未登入就開啟登入網頁
 */
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"didappear");
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


-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"didWillAppear");
    [self.client getCurrentUser:^(CoinbaseUser *user, NSError *error) {
        if (error) {
            NSLog(@"Could not load user: %@", error);
        } else {
            self.emailField.text = user.email;
            NSLog(@"Signed in as: %@", user.email);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
*/

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
            self.emailField.text = user.email;
            self.moneyField.text = user.balance.amount;
            currentUser = user;
        }
    }];
}



/**
 *  getPrice
 *
 *  取得比特幣對美金匯率
 */
/*
-(IBAction)getPrice:(id)sender
{
    [self.client getBuyPrice:^(CoinbaseBalance *btc, NSArray *fees, CoinbaseBalance *subtotal, CoinbaseBalance *total, NSError *error) {
        NSString *priceString = [NSString stringWithFormat:@"buy price: %@ %@ = %@ %@",btc.amount, btc.currency, total.amount, total.currency];
        [[[UIAlertView alloc] initWithTitle:@"price" message:priceString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }];
}
*/
/**
 *  createOrder
 *
 *  指定對方的email與比特幣金額，轉帳指定的比特幣數量給對方
 */
/*
-(IBAction)createOrder:(id)sender
{
    if (!amountField.text.length) {
        [[[UIAlertView alloc] initWithTitle:@"send error" message:@"Please enter amount" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    if (!receiverField.text.length) {
        [[[UIAlertView alloc] initWithTitle:@"send error" message:@"Please enter receiver" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        return;
    }
    
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
        [acc sendAmount:amountField.text to:receiverField.text completion:^(CoinbaseTransaction *transaction, NSError *sendError) {
            NSLog(@"error:%@",sendError);
            NSLog(@"transaction:%@",transaction);
            NSLog(@"receiverField's text = %@",receiverField.text);
            
            if (sendError) {
                NSString *errorString = [sendError description];
                [[[UIAlertView alloc] initWithTitle:@"send error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
            }
        }];
    }];
    
}
*/

- (void)dealloc {
    //[_email release];
    //[_password release];
    [_emailField release];
    [_moneyField release];
    [super dealloc];
}

- (IBAction)login:(UIButton *)sender {
    /*
    NSString *MY_COLLECTION = @"User";
    // get input from textField
    NSString *email = self.email.text;
    NSString *password = self.password.text;
    // Generate Query like {$and:[{"email":"xxxx@gmail.com"},{"password":"123456789"}]}
    NSString *query = [NSString stringWithFormat:@"{$and:[{\"email\":\"%@\"},{\"password\":\"%@\"}]}", email,password];
    //NSLog(@"%@",query);
    // Query
    NSArray *resultList = [[MongoLabSDK sharedInstance] getCollectionItemList:MY_DATABASE collectionName:MY_COLLECTION query:query];
    // Error Detection
    NSLog(@"%@",resultList);
    
    if (resultList == nil || [resultList count] == 0) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"登入失敗"
                                      message:@"請重新輸入"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* errormsg = [UIAlertAction
                                   actionWithTitle:@"再試一次"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action)
                                   {
                                       NSLog(@"unregistered user!");
                                       return;//block
                                   }];
        [alert addAction:errormsg];
        [self presentViewController:alert animated:YES completion:nil];
     */
    NSLog(@"Confirm");
}


@end






































