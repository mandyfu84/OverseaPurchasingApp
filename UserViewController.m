//
//  UserViewController.m
//  OverseaPurchasing
//
//  Created by 高穎 on 2016/6/11.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import "ViewController.h"

#import "UserViewController.h"
#import "GeneralData .h"


@interface UserViewController ()

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[singletonObject sharedSingletonObject]->account=@"OAQQQ";
    self.useremail.text=[singletonObject sharedSingletonObject]->account;
    //self.moneyField.text =[NSString stringWithFormat:@"%8e", [singletonObject sharedSingletonObject]->balance];
    
    self.moneyField.text =[NSString stringWithFormat:@"%f", [singletonObject sharedSingletonObject]->balance];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"didappear");
    
    [super viewDidAppear:animated];

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

    [_useremail release];
    [super dealloc];
}
@end
