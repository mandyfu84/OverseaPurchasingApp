//
//  ItemDetailUIViewController.m
//  OverseaPurchasing
//
//  Created by Fu Juo Wen on 2016/6/4.
//  Copyright © 2016年 ntnu. All rights reserved.
//

#import "ItemDetailUIViewController.h"

@interface ItemDetailUIViewController()

@end


@implementation ItemDetailUIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.itemImage.image = self.itemObject.image;
    self.itemNameLabel.text = self.itemObject.name;

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
            break;
        case 1: 
            cell.textLabel.text = @"Catagory";
            cell.detailTextLabel.text = self.itemObject.catagory;
            break;
        case 2:
            cell.textLabel.text = @"Location";
            cell.detailTextLabel.text = self.itemObject.country;
            break;
        case 3:
            cell.textLabel.text = @"Detail";
            cell.detailTextLabel.text = self.itemObject.detail;
            break;
        case 4:
            cell.textLabel.text = @"Ownermail";
            cell.detailTextLabel.text = self.itemObject.ownermail;

        default:
            break;
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

@end
