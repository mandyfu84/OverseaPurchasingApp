//
//  SignUp.m
//  OverseaPurchasing
//
//  Created by Timmy on 2016/6/10.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import "SignUp.h"
#import "MongoLabSDK/MongoLabSDK.h"

@interface SignUp ()
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *password;
- (IBAction)confirmPressed:(UIButton *)sender;

@end

@implementation SignUp

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (IBAction)confirmPressed:(UIButton *)sender {
    NSLog(@"confirm is pressed!");
    NSString *MY_COLLECTION = @"User";
    // Declare a dictionary and mapping key and value
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    [item setValue:self.emailField.text forKey:@"email"];
    [item setValue:self.password.text forKey:@"password"];
    NSLog(@"%@",item);
    // Send it!
    NSDictionary *resultList = [[MongoLabSDK sharedInstance] insertCollectionItem:MY_DATABASE collectionName:MY_COLLECTION item:item];
    //NSLog(@"%@",resultList);
    // Error detection
    NSString *msg = [resultList objectForKey:@"message"];
    if([msg  isEqual: @"Please provide a valid API key."]){
        NSLog(@"%@",msg);
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@"註冊失敗"
                                      message:@"請重新輸入"
                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* errormsg = [UIAlertAction
                                    actionWithTitle:@"OK"
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
