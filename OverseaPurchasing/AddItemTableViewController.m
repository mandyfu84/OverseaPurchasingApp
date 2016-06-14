//
//  AddItemTableViewController.m
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/11.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import "AddItemTableViewController.h"

@interface AddItemTableViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,NSURLConnectionDelegate>

@end

@implementation AddItemTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
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
    [super dealloc];
}

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
    NSLog(@"Upload");
    NSString *MY_COLLECTION = @"User"; // indicate which collection to send
    // Declare a dictionary and mapping key and value
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    [item setValue:self.ItemName.text forKey:@"name"];
    [item setValue:[NSNumber numberWithFloat:[self.ItemPrice.text intValue]] forKey:@"price"];
    [item setValue:self.ItemCategory.text forKey:@"category"];
    [item setValue:self.ItemLocation.text forKey:@"location"];
    [item setValue:self.ItemDetail.text forKey:@"detail"];
    
    [item setValue:[NSNumber numberWithInt:2] forKey:@"id"];
    [item setValue:@"www.google.com/img02.jpg" forKey:@"img_url"];
    [item setValue:@"40347905S@gmail.com" forKey:@"courier_mail"];

    NSLog(@"%@",item);
}

@end
