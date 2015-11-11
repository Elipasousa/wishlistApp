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
#import "AddItemViewController.h"
#import "ItemDetailsViewController.h"
#import <SWTableViewCell/SWTableViewCell.h>

@interface WishlistTableViewController : BaseViewController <UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *filterView;
@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterViewHeightConstraint;
- (IBAction)clearFilterTouched:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *totalItemsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITextField *filterTextField;
- (IBAction)searchTouched:(id)sender;

@property (strong, nonatomic) NSArray *items;

@end

