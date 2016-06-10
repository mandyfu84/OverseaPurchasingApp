//
//  LogIn.m
//  OverseaPurchasing
//
//  Created by Timmy on 2016/6/11.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import "LogIn.h"
#import "MongoLabSDK/MongoLabSDK.h"

@interface LogIn ()
@property (retain, nonatomic) IBOutlet UITextField *emailField;
@property (retain, nonatomic) IBOutlet UITextField *password;
- (IBAction)login:(UIButton *)sender;

@end

@implementation LogIn

//TODO - Enter database name - you can have multiple databases being used
#define MY_DATABASE @"tpiti_wallet"

#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

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
    NSLog(@"unregistered user!");
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
                                       return;//block
                                   }];
        [alert addAction:errormsg];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
@end
