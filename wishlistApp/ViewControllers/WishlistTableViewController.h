//
//  WishlistTableViewController.h
//  wishlistApp
//
//  Created by Elisabete Sousa on 09/11/15.
//  Copyright © 2015 Elisabete Bicho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WishlistInfoTableViewCell.h"
#import "BaseViewController.h"

@interface WishlistTableViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *items;

@end

