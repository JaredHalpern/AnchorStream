//
//  ViewController.h
//  AnchorTable
//
//  Created by Jared Halpern on 2/25/16.
//  Copyright © 2016 Jared Halpern. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"

@interface ViewController : UIViewController <UITableViewDataSource, CustomTableViewCellDelegate>

@property (nonatomic, weak) IBOutlet UITableView            *tableView;

@end