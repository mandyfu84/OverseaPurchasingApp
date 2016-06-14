//
//  LogIn.m
//  OverseaPurchasing
//
//  Created by Timmy on 2016/6/11.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import "LogIn.h"
#import "MongoLabSDK/MongoLabSDK.h"

#import "ViewController.h"
#import <coinbase-official/CoinbaseOAuth.h>
#import <coinbase-official/CoinbaseUser.h>
#import <coinbase-official/CoinbaseAccount.h>
@interface LogIn ()
@property (retain, nonatomic) IBOutlet UITextField *emailField;
@property (retain, nonatomic) IBOutlet UITextField *password;
- (IBAction)login:(UIButton *)sender;

@end

@implementation LogIn

//TODO - Enter database name - you can have multiple databases being used
#define MY_DATABASE @"tpiti_wallet"

#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

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


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_emailField release];
    [_password release];
    [super dealloc];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)login:(UIButton *)sender {
    NSString *MY_COLLECTION = @"User";
    // get input from textField
    NSString *email = self.emailField.text;
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
    }
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







@end
