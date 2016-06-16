//
//  AddItemTableViewController.m
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/11.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import "AddItemTableViewController.h"
#import "MongoLabSDK.h"
#import "GeneralData .h"

@interface AddItemTableViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,NSURLConnectionDelegate>
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation AddItemTableViewController


//TODO - Enter database name - you can have multiple databases being used
#define MY_DATABASE @"tpiti_wallet"
#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             
                                             initWithTarget:self action:@selector(handleBackgroundTap:)];
    
    tapRecognizer.cancelsTouchesInView = NO;
    
    [self.view addGestureRecognizer:tapRecognizer];
    
    
    
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
    
    // Generate Activity Indicator
    _spinner.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    _spinner.hidesWhenStopped = true;
    _spinner.center = self.view.center;
    [self.view addSubview:_spinner]; // invisible now
    NSLog(@"viedidloadfinish");
}


- (void) handleBackgroundTap:(UITapGestureRecognizer*)sender

{
    [_ItemName resignFirstResponder];
    [_ItemPrice resignFirstResponder];
    [_ItemCategory resignFirstResponder];
    [_ItemDetail resignFirstResponder];
    [_ItemLocation resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_ItemName release];
    [_ItemPrice release];
    [_ItemCategory release];
    [_ItemLocation release];
    [_ItemDetail release];
    [_image release];
    [_spinner release];
    [super dealloc];
}

/*
-(int) getCurrentMaxID{
    NSLog(@"getCurrentMaxID");
    int id = 0;
    
    NSString *query = @"{\"_id\":-1}";
    NSString *queryParams = @"";
    queryParams = [NSString stringWithFormat:@"&s=%@", [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    //NSString* urlString =@"https://api.mongolab.com/api/1/databases/tpiti_wallet/collections/Product?apiKey=v0KbZnCTNV1mUIziflTd2i932GHY2uAd&q={\"_id\":150}";
    NSString *urlString = @"";
    urlString = [NSString stringWithFormat:@"https://api.mongolab.com/api/1/databases/tpiti_wallet/collections/Product?apiKey=v0KbZnCTNV1mUIziflTd2i932GHY2uAd%@",queryParams];
    NSLog(@"%@",urlString);

    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSLog(@"below:");
             NSDictionary *MAXdata = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:0
                                                                        error:NULL];
             
             NSLog(@"%@",MAXdata);
             //NSNumber *orderNumber =
             //id = [orderNumber intValue];
         }
     }];
    return id;
}
*/



- (IBAction)takePhoto:(UIButton *)sender {
    NSLog(@"take a photo");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    // Create the actions.
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"Cancel!");
    }];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:NSLocalizedString(@"拍攝", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"take a shot!");
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    UIAlertAction *selectGallery = [UIAlertAction actionWithTitle:NSLocalizedString(@"從相簿", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSLog(@"select from gallery!");
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }];
    // Add the actions.
    [alertController addAction:cancel];
    [alertController addAction:takePhoto];
    [alertController addAction:selectGallery];
    // Show it
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    NSLog(@"Image Information:\n%@",info[UIImagePickerControllerEditedImage]);
    self.image.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    //if user cancels taking photo
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (IBAction)Upload:(UIButton *)sender {
    // Activity Indicator Start
    [NSThread detachNewThreadSelector:@selector(threadStartAnimating) toTarget:self withObject:nil];

    NSLog(@"Upload");
    NSString *MY_COLLECTION = @"Product"; // indicate which collection to send
    
    // Declare a dictionary and mapping key and value
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    [item setValue:self.ItemName.text forKey:@"name"];
    [item setValue:[NSNumber numberWithFloat:[self.ItemPrice.text doubleValue]] forKey:@"price"];
    [item setValue:self.ItemCategory.text forKey:@"category"];
    [item setValue:self.ItemLocation.text forKey:@"location"];
    [item setValue:self.ItemDetail.text forKey:@"detail"];
    [item setValue: [singletonObject sharedSingletonObject]->account forKey:@"seller_mail"]; // parameter passing needed
    
    
    
    // get id from MongoDB
    //https://api.mongolab.com/api/1/databases/tpiti_wallet/collections/Product?apiKey=v0KbZnCTNV1mUIziflTd2i932GHY2uAd&s={"_id":-1}&l=1
    NSString *sort = @"{\"_id\":-1}";
    NSArray *resultList = [[MongoLabSDK sharedInstance] getCollectionItemList:MY_DATABASE collectionName:MY_COLLECTION query:nil  sortOrder:sort limit:1];
    
    
    NSLog(@"%@",resultList);
    
    int id = 0;
    NSLog(@"%lu",(unsigned long)resultList.count);
    if (resultList == nil || resultList.count == 0) {
        NSLog(@"empty_id");
        id = 0;
    }else{
        NSNumber *orderNumber = [[resultList objectAtIndex: 0 ]objectForKey:@"_id"];
        NSLog(@"orderNumber = %@",orderNumber);
        id = [orderNumber intValue];
        id += 1;
        NSLog(@"%d",id);
    }
    [item setValue:[NSNumber numberWithInt:id] forKey:@"_id"];
    
    //[self getCurrentMaxID];
    //int id = 3;
     //[item setValue:[NSNumber numberWithInt:id] forKey:@"_id"];
    
    
    
    
    
    
    
     
     
    // -----upload image------
    NSData *imageData = UIImageJPEGRepresentation(_image.image, 0.1);
    NSLog(@"Size of Image(bytes):%lu",(unsigned long)[imageData length]);
    NSString *urlString = @"http://www.csie.ntnu.edu.tw/~40347905s/uploads.php";
    NSString *imageName = [NSString stringWithFormat:@"%d", id];;
    // setting up the request object now
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = [[NSString alloc]init];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\"test.png\"rn" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/%@.jpg\r\n\r\n",imageName] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    //Using Synchronous Request. You can also use asynchronous connection and get update in delegates
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"get_image_from:\"%@\"",returnString);
    // use semicolon to split the word and concatenate with "http"
    NSString *imageURL = [NSString stringWithFormat: @"http:%@", [[returnString componentsSeparatedByString:@":"] objectAtIndex:1]];
    [item setValue:imageURL forKey:@"img_url"];
    
    // upload to MongoDB
    NSDictionary *resultUploadList = [[MongoLabSDK sharedInstance] insertCollectionItem:MY_DATABASE collectionName:MY_COLLECTION item:item];
    NSLog(@"%@",resultUploadList);
    
    // Activity Indicator End
    [_spinner stopAnimating];
    
    // Suppose upload successfully, display msg and clear all textfields
    NSString *msg = @"Upload Successfully";
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"congratulations!"
                                          message:msg
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK action");
                                   self.ItemName.text = @"";
                                   self.ItemPrice.text = @"";
                                   self.ItemCategory.text = @"";
                                   self.ItemLocation.text = @"";
                                   self.ItemDetail.text = @"";
                                   NSString *defaultimage = @"default-image.jpg";
                                   self.image.image = [UIImage imageNamed:defaultimage];
                               }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void) threadStartAnimating {
    [_spinner startAnimating];
}

@end
