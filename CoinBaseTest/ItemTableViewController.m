//
//  ItemTableViewController.m
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/4.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import "ItemTableViewController.h"
#import "Items.h"
#import "ItemObject.h"
#import "ItemDetailUIViewController.h"

@interface ItemTableViewController ()

@end

@implementation ItemTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    //    NSString *item1 = @"1";
    //    NSString *item2 = @"2";
    //    NSString *item3 = @"3";
    //    NSString *item4 = @"4";
    //    NSString *item5 = @"5";
    //    NSString *item6 = @"6";
    //    NSString *item7 = @"7";
    //    NSString *item8 = @"8";
    //    NSString *item9 = @"9";
    //self.items = [[NSMutableArray alloc] initWithObjects:item1, item2, item3, item4, item5, item6, item7, item8, item9, nil];
    
    self.items = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *itemData in [Items allItems]){
        NSString *URL = itemData[ITEM_IMGURL];
        NSURL *imageURL = [NSURL URLWithString:URL];
        
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        UIImage *image = [UIImage imageWithData:imageData];
        ItemObject *item = [[ItemObject alloc] initWithData:itemData andImage:image];
        
        [self.items addObject:item];
        /*
        // run on a background thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            NSLog(@"URL: %@",imageURL);
            NSLog(@"Size of Image(bytes):%d",[imageData length]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the UI
                ItemObject *item = [[ItemObject alloc] initWithData:itemData andImage:[UIImage imageWithData:imageData]];
                
                [self.items addObject:item];
            });
        });
         */
        /*
        NSString *imageName = [NSString stringWithFormat:@"%@.png", itemData[ITEM_TITLE]];
        ItemObject *item = [[ItemObject alloc] initWithData:itemData andImage:[UIImage imageNamed:imageName]];
        [self.items addObject:item];
         */
    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    ItemObject *item = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text =  [NSNumber numberWithFloat:item.price].stringValue;
    cell.imageView.image = item.image;
    
    //  cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

//send itemobject to detail page
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        if([segue.destinationViewController isKindOfClass:[ItemDetailUIViewController class]])
        {
            ItemDetailUIViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            ItemObject *selectedObject = self.items[path.row];
            nextViewController.itemObject = selectedObject;
            //NSLog(@"123: %@", sender);
        }
    }
}


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

@end
